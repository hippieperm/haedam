import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../../data/models/item_model.dart';
import '../../data/models/bid_model.dart';
import '../../../../shared/services/firebase_service.dart';

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
            return ItemModel.fromJson(doc.data() as Map<String, dynamic>);
          } catch (e) {
            print('Error parsing item ${doc.id}: $e');
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
                return ItemModel.fromJson(doc.data() as Map<String, dynamic>);
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
                return ItemModel.fromJson(doc.data() as Map<String, dynamic>);
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
                return ItemModel.fromJson(doc.data() as Map<String, dynamic>);
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
