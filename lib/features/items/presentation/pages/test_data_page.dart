import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../../data/models/item_model.dart';
import '../../../../shared/services/firebase_service.dart';

class TestDataPage extends ConsumerWidget {
  const TestDataPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(title: const Text('테스트 데이터 추가')),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              onPressed: () => _addTestData(context),
              child: const Text('테스트 데이터 추가'),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () => _checkData(context),
              child: const Text('데이터 확인'),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> _addTestData(BuildContext context) async {
    try {
      final now = DateTime.now();

      // 매우 간단한 데이터로 시작
      final itemData = {
        'id': 'test_item_1',
        'sellerId': 'test_seller',
        'title': '테스트 분재',
        'species': '소나무',
        'style': '직립형',
        'sizeClass': '소형',
        'heightCm': 30.0,
        'crownWidthCm': 25.0,
        'ageYearsEst': 5,
        'healthNotes': '건강한 상태',
        'coverImageUrl': 'https://via.placeholder.com/300x200',
        'status': 'LIVE',
        'createdAt': Timestamp.fromDate(now),
        'updatedAt': Timestamp.fromDate(now),
        'media': [],
      };

      print('Item data to save: $itemData');

      await FirebaseService.instance.itemsCollection
          .doc('test_item_1')
          .set(itemData);

      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('테스트 데이터가 추가되었습니다'),
            backgroundColor: Colors.green,
          ),
        );
      }
    } catch (e) {
      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('오류: $e'), backgroundColor: Colors.red),
        );
      }
    }
  }

  Future<void> _checkData(BuildContext context) async {
    try {
      final snapshot = await FirebaseService.instance.itemsCollection.get();
      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('데이터 개수: ${snapshot.docs.length}'),
            backgroundColor: Colors.blue,
          ),
        );
      }
    } catch (e) {
      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('오류: $e'), backgroundColor: Colors.red),
        );
      }
    }
  }
}
