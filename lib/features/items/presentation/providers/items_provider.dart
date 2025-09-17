import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../../data/models/item_model.dart';
import '../../data/models/bid_model.dart';
import '../../../../shared/services/firebase_service.dart';

final itemsProvider = StreamProvider<List<ItemModel>>((ref) {
  return FirebaseService.instance.itemsCollection
      .where('status', isEqualTo: 'LIVE')
      .orderBy('auction.endsAt')
      .snapshots()
      .map(
        (snapshot) => snapshot.docs
            .map(
              (doc) => ItemModel.fromJson(doc.data() as Map<String, dynamic>),
            )
            .toList(),
      );
});

final liveItemsProvider = StreamProvider<List<ItemModel>>((ref) {
  return FirebaseService.instance.itemsCollection
      .where('status', isEqualTo: 'LIVE')
      .orderBy('auction.endsAt')
      .snapshots()
      .map(
        (snapshot) => snapshot.docs
            .map(
              (doc) => ItemModel.fromJson(doc.data() as Map<String, dynamic>),
            )
            .toList(),
      );
});

final endingSoonItemsProvider = StreamProvider<List<ItemModel>>((ref) {
  final now = DateTime.now();
  final twoHoursLater = now.add(const Duration(hours: 2));

  return FirebaseService.instance.itemsCollection
      .where('status', isEqualTo: 'LIVE')
      .where('auction.endsAt', isLessThan: Timestamp.fromDate(twoHoursLater))
      .orderBy('auction.endsAt')
      .snapshots()
      .map(
        (snapshot) => snapshot.docs
            .map(
              (doc) => ItemModel.fromJson(doc.data() as Map<String, dynamic>),
            )
            .toList(),
      );
});

final newItemsProvider = StreamProvider<List<ItemModel>>((ref) {
  return FirebaseService.instance.itemsCollection
      .where('status', isEqualTo: 'LIVE')
      .orderBy('createdAt', descending: true)
      .limit(20)
      .snapshots()
      .map(
        (snapshot) => snapshot.docs
            .map(
              (doc) => ItemModel.fromJson(doc.data() as Map<String, dynamic>),
            )
            .toList(),
      );
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
