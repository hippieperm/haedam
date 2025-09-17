import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../../data/models/item_model.dart';
import '../../data/models/bid_model.dart';
import '../../../../shared/services/firebase_service.dart';

// 데이터 구조 검증 및 수정 함수
Map<String, dynamic> _cleanItemData(Map<String, dynamic> data) {
  final cleaned = Map<String, dynamic>.from(data);

  // ID 필드 추가 (문서 ID가 없는 경우)
  if (cleaned['id'] == null) {
    cleaned['id'] = '';
  }

  // auction 필드 검증 및 수정
  if (cleaned['auction'] != null) {
    final auction = Map<String, dynamic>.from(cleaned['auction']);

    // 필수 필드 확인 및 기본값 설정
    auction['startPrice'] ??= 0;
    auction['bidStep'] ??= 0;
    auction['currentPrice'] ??= auction['startPrice'] ?? 0;
    auction['autoExtendMinutes'] ??= 2;
    auction['bidCount'] ??= 0;

    // null 값 제거
    if (auction['currentBidId'] == null) {
      auction.remove('currentBidId');
    }
    if (auction['currentBidderId'] == null) {
      auction.remove('currentBidderId');
    }

    // Timestamp 변환
    if (auction['startsAt'] is Timestamp) {
      auction['startsAt'] = auction['startsAt'];
    }
    if (auction['endsAt'] is Timestamp) {
      auction['endsAt'] = auction['endsAt'];
    }

    cleaned['auction'] = auction;
  } else {
    // auction 필드가 없는 경우 기본값으로 생성
    cleaned['auction'] = {
      'startPrice': 0,
      'bidStep': 0,
      'currentPrice': 0,
      'autoExtendMinutes': 2,
      'bidCount': 0,
    };
  }

  // shipping 필드 검증 및 수정
  if (cleaned['shipping'] != null) {
    final shipping = Map<String, dynamic>.from(cleaned['shipping']);

    // method 필드가 문자열인 경우 enum 값으로 변환
    if (shipping['method'] is String) {
      final method = shipping['method'] as String;
      switch (method.toUpperCase()) {
        case 'PICKUP':
          shipping['method'] = 'PICKUP';
          break;
        case 'COURIER':
          shipping['method'] = 'COURIER';
          break;
        case 'FREIGHT':
          shipping['method'] = 'FREIGHT';
          break;
        default:
          shipping['method'] = 'PICKUP';
      }
    }

    cleaned['shipping'] = shipping;
  } else {
    // shipping 필드가 없는 경우 기본값으로 생성
    cleaned['shipping'] = {'method': 'PICKUP', 'feePolicy': 'buyer'};
  }

  // status 필드 검증
  if (cleaned['status'] is String) {
    final status = cleaned['status'] as String;
    switch (status.toUpperCase()) {
      case 'DRAFT':
        cleaned['status'] = 'DRAFT';
        break;
      case 'SCHEDULED':
        cleaned['status'] = 'SCHEDULED';
        break;
      case 'LIVE':
        cleaned['status'] = 'LIVE';
        break;
      case 'PAUSED':
        cleaned['status'] = 'PAUSED';
        break;
      case 'ENDED':
        cleaned['status'] = 'ENDED';
        break;
      case 'SETTLED':
        cleaned['status'] = 'SETTLED';
        break;
      case 'CANCELED':
        cleaned['status'] = 'CANCELED';
        break;
      default:
        cleaned['status'] = 'DRAFT';
    }
  } else {
    cleaned['status'] = 'DRAFT';
  }

  // media 필드 검증
  if (cleaned['media'] == null) {
    cleaned['media'] = [];
  }

  // createdAt과 updatedAt 필드 검증
  if (cleaned['createdAt'] == null) {
    cleaned['createdAt'] = Timestamp.fromDate(DateTime.now());
  }
  if (cleaned['updatedAt'] == null) {
    cleaned['updatedAt'] = Timestamp.fromDate(DateTime.now());
  }

  return cleaned;
}

// Firebase 연결 테스트 provider
final firebaseConnectionTestProvider = FutureProvider<bool>((ref) async {
  try {
    print('Testing Firebase connection...');
    final snapshot = await FirebaseService.instance.itemsCollection
        .limit(1)
        .get();
    print(
      'Firebase connection test successful. Found ${snapshot.docs.length} documents.',
    );
    return true;
  } catch (e) {
    print('Firebase connection test failed: $e');
    return false;
  }
});

final itemsProvider = StreamProvider<List<ItemModel>>((ref) {
  print('Creating itemsProvider stream...');
  return FirebaseService.instance.itemsCollection.snapshots().map((snapshot) {
    print('Items snapshot received: ${snapshot.docs.length} docs');
    return snapshot.docs
        .map((doc) {
          try {
            final data = doc.data() as Map<String, dynamic>;
            print('Parsing item ${doc.id} with data: $data');

            // 데이터 구조 검증 및 수정
            final cleanedData = _cleanItemData(data);
            print('Cleaned data: $cleanedData');

            return ItemModel.fromJson(cleanedData);
          } catch (e) {
            print('Error parsing item ${doc.id}: $e');
            print('Stack trace: ${StackTrace.current}');
            return null;
          }
        })
        .where((item) => item != null)
        .cast<ItemModel>()
        .toList();
  });
});

final liveItemsProvider = StreamProvider<List<ItemModel>>((ref) {
  print('Creating liveItemsProvider stream...');
  return FirebaseService.instance.itemsCollection
      .where('status', isEqualTo: 'LIVE')
      .snapshots()
      .map((snapshot) {
        print('Live items snapshot received: ${snapshot.docs.length} docs');
        return snapshot.docs
            .map((doc) {
              try {
                final data = doc.data() as Map<String, dynamic>;
                final cleanedData = _cleanItemData(data);
                return ItemModel.fromJson(cleanedData);
              } catch (e) {
                print('Error parsing live item ${doc.id}: $e');
                return null;
              }
            })
            .where((item) => item != null)
            .cast<ItemModel>()
            .toList();
      });
});

final endingSoonItemsProvider = StreamProvider<List<ItemModel>>((ref) {
  print('Creating endingSoonItemsProvider stream...');
  return FirebaseService.instance.itemsCollection
      .where('status', isEqualTo: 'LIVE')
      .snapshots()
      .map((snapshot) {
        print(
          'Ending soon items snapshot received: ${snapshot.docs.length} docs',
        );
        return snapshot.docs
            .map((doc) {
              try {
                final data = doc.data() as Map<String, dynamic>;
                final cleanedData = _cleanItemData(data);
                return ItemModel.fromJson(cleanedData);
              } catch (e) {
                print('Error parsing ending soon item ${doc.id}: $e');
                return null;
              }
            })
            .where((item) => item != null)
            .cast<ItemModel>()
            .toList();
      });
});

final newItemsProvider = StreamProvider<List<ItemModel>>((ref) {
  print('Creating newItemsProvider stream...');
  return FirebaseService.instance.itemsCollection
      .where('status', isEqualTo: 'LIVE')
      .snapshots()
      .map((snapshot) {
        print('New items snapshot received: ${snapshot.docs.length} docs');
        return snapshot.docs
            .map((doc) {
              try {
                final data = doc.data() as Map<String, dynamic>;
                final cleanedData = _cleanItemData(data);
                return ItemModel.fromJson(cleanedData);
              } catch (e) {
                print('Error parsing new item ${doc.id}: $e');
                return null;
              }
            })
            .where((item) => item != null)
            .cast<ItemModel>()
            .toList();
      });
});

final itemProvider = StreamProvider.family<ItemModel?, String>((ref, itemId) {
  return FirebaseService.instance.itemsCollection.doc(itemId).snapshots().map((
    snapshot,
  ) {
    if (snapshot.exists) {
      return ItemModel.fromJson(snapshot.data()! as Map<String, dynamic>);
    }
    return null;
  });
});

final itemBidsProvider = StreamProvider.family<List<BidModel>, String>((
  ref,
  itemId,
) {
  return FirebaseService.instance.itemsCollection
      .doc(itemId)
      .collection('bids')
      .orderBy('amount', descending: true)
      .snapshots()
      .map(
        (snapshot) =>
            snapshot.docs.map((doc) => BidModel.fromJson(doc.data())).toList(),
      );
});
