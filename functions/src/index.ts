import * as functions from "firebase-functions";
import * as admin from "firebase-admin";

admin.initializeApp();
const db = admin.firestore();

// 타입 정의
interface PlaceBidInput {
  itemId: string;
  amount: number;
  isProxy?: boolean;
  maxProxyAmount?: number;
}

interface BuyNowInput {
  itemId: string;
}

// 입찰 처리
export const placeBid = functions.https.onCall(
  async (data: PlaceBidInput, context) => {
    const uid = context.auth?.uid;
    if (!uid) {
      throw new functions.https.HttpsError(
        "unauthenticated",
        "로그인이 필요합니다."
      );
    }

    const { itemId, amount } = data;
    const itemRef = db.collection("items").doc(itemId);
    const bidsRef = itemRef.collection("bids");

    return await db.runTransaction(async (tx) => {
      const itemSnap = await tx.get(itemRef);
      if (!itemSnap.exists) {
        throw new functions.https.HttpsError(
          "not-found",
          "분재를 찾을 수 없습니다."
        );
      }

      const item = itemSnap.data()!;
      if (item.status !== "LIVE") {
        throw new functions.https.HttpsError(
          "failed-precondition",
          "진행 중인 경매가 아닙니다."
        );
      }

      const step = item.auction?.bidStep ?? 1000;
      const current =
        item.auction?.currentPrice ?? item.auction?.startPrice ?? 0;

      if (amount < current + step) {
        throw new functions.https.HttpsError(
          "invalid-argument",
          "입찰 금액이 너무 낮습니다."
        );
      }

      // 신규 입찰 문서
      const bidRef = bidsRef.doc();
      tx.set(bidRef, {
        bidderId: uid,
        amount,
        isProxy: !!data.isProxy,
        maxProxyAmount: data.maxProxyAmount ?? null,
        createdAt: admin.firestore.FieldValue.serverTimestamp(),
      });

      // 자동연장 처리
      const endsAt: admin.firestore.Timestamp = item.auction.endsAt;
      const now = admin.firestore.Timestamp.now();
      let newEndsAt = endsAt;

      if (
        item.auction.autoExtendMinutes &&
        now.toMillis() >= endsAt.toMillis() - 2 * 60 * 1000
      ) {
        newEndsAt = admin.firestore.Timestamp.fromMillis(
          endsAt.toMillis() + item.auction.autoExtendMinutes * 60 * 1000
        );
      }

      // 현재가 갱신
      tx.update(itemRef, {
        "auction.currentPrice": amount,
        "auction.currentBidderId": uid,
        "auction.currentBidId": bidRef.id,
        "auction.bidCount": (item.auction.bidCount ?? 0) + 1,
        "auction.endsAt": newEndsAt,
      });

      return {
        ok: true,
        currentPrice: amount,
        endsAt: newEndsAt.toMillis(),
      };
    });
  }
);

// 즉시구매 처리
export const buyNow = functions.https.onCall(
  async (data: BuyNowInput, context) => {
    const uid = context.auth?.uid;
    if (!uid) {
      throw new functions.https.HttpsError(
        "unauthenticated",
        "로그인이 필요합니다."
      );
    }

    const itemRef = db.collection("items").doc(data.itemId);
    return await db.runTransaction(async (tx) => {
      const item = (await tx.get(itemRef)).data();
      if (!item || item.status !== "LIVE") {
        throw new functions.https.HttpsError(
          "failed-precondition",
          "진행 중인 경매가 아닙니다."
        );
      }
      if (!item.auction?.buyNowPrice) {
        throw new functions.https.HttpsError(
          "failed-precondition",
          "즉시구매가 설정되지 않았습니다."
        );
      }

      // 아이템 종료 처리
      tx.update(itemRef, {
        status: "ENDED",
        "auction.currentPrice": item.auction.buyNowPrice,
      });

      // 주문 생성
      const orderRef = db.collection("orders").doc();
      const deadline = Date.now() + 48 * 60 * 60 * 1000; // 48시간
      const depositCode = genDepositCode(orderRef.id);

      tx.set(orderRef, {
        itemId: data.itemId,
        buyerId: uid,
        finalPrice: item.auction.buyNowPrice,
        buyerPremium: calcBuyerPremium(item.auction.buyNowPrice),
        sellerFee: calcSellerFee(item.auction.buyNowPrice),
        vat: 0,
        paymentMethod: "BANK_TRANSFER",
        paymentStatus: "PENDING_PAYMENT",
        depositAmount: calcDepositAmount(item.auction.buyNowPrice),
        depositCode,
        depositDeadline: admin.firestore.Timestamp.fromMillis(deadline),
        createdAt: admin.firestore.FieldValue.serverTimestamp(),
        updatedAt: admin.firestore.FieldValue.serverTimestamp(),
      });

      return {
        ok: true,
        orderId: orderRef.id,
        depositCode,
        deadline,
      };
    });
  }
);

// 경매 종료 스케줄러
export const finalizeAuction = functions.pubsub
  .schedule("every 1 minutes")
  .onRun(async () => {
    const now = admin.firestore.Timestamp.now();
    const snap = await db
      .collection("items")
      .where("status", "==", "LIVE")
      .where("auction.endsAt", "<=", now)
      .get();

    const batch = db.batch();
    for (const doc of snap.docs) {
      const it = doc.data();
      batch.update(doc.ref, { status: "ENDED" });

      if (it.auction?.currentBidderId) {
        const orderRef = db.collection("orders").doc();
        const deadline = Date.now() + 48 * 60 * 60 * 1000;
        batch.set(orderRef, {
          itemId: doc.id,
          buyerId: it.auction.currentBidderId,
          finalPrice: it.auction.currentPrice,
          buyerPremium: calcBuyerPremium(it.auction.currentPrice),
          sellerFee: calcSellerFee(it.auction.currentPrice),
          vat: 0,
          paymentMethod: "BANK_TRANSFER",
          paymentStatus: "PENDING_PAYMENT",
          depositAmount: calcDepositAmount(it.auction.currentPrice),
          depositCode: genDepositCode(orderRef.id),
          depositDeadline: admin.firestore.Timestamp.fromMillis(deadline),
          createdAt: admin.firestore.FieldValue.serverTimestamp(),
          updatedAt: admin.firestore.FieldValue.serverTimestamp(),
        });
      }
    }
    await batch.commit();
    return null;
  });

// 주문 만료 스케줄러
export const expirePendingOrders = functions.pubsub
  .schedule("every 10 minutes")
  .onRun(async () => {
    const now = admin.firestore.Timestamp.now();
    const snap = await db
      .collection("orders")
      .where("paymentStatus", "==", "PENDING_PAYMENT")
      .where("depositDeadline", "<=", now)
      .get();

    const batch = db.batch();
    for (const doc of snap.docs) {
      batch.update(doc.ref, {
        paymentStatus: "EXPIRED",
        updatedAt: admin.firestore.FieldValue.serverTimestamp(),
      });
    }
    await batch.commit();
    return null;
  });

// 관리자 전용 - 주문 결제 확인
export const markPaid = functions.https.onCall(
  async (data: { orderId: string }, context) => {
    if (context.auth?.token.admin !== true) {
      throw new functions.https.HttpsError(
        "permission-denied",
        "관리자만 접근 가능합니다."
      );
    }

    const ref = db.collection("orders").doc(data.orderId);
    await ref.update({
      paymentStatus: "PAID",
      updatedAt: admin.firestore.FieldValue.serverTimestamp(),
      settledAt: admin.firestore.FieldValue.serverTimestamp(),
    });

    await db.collection("auditLogs").add({
      actorId: context.auth!.uid,
      action: "markPaid",
      target: { type: "order", id: data.orderId },
      createdAt: admin.firestore.FieldValue.serverTimestamp(),
    });

    return { ok: true };
  }
);

// 유틸리티 함수들
function genDepositCode(orderId: string): string {
  return "BA-" + orderId.substring(0, 6).toUpperCase();
}

function calcBuyerPremium(price: number): number {
  return Math.round(price * 0.07); // 7%
}

function calcSellerFee(price: number): number {
  return Math.round(price * 0.1); // 10%
}

function calcDepositAmount(finalPrice: number): number {
  return finalPrice + calcBuyerPremium(finalPrice);
}
