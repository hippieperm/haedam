import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../core/constants/app_constants.dart';

class OrderDetailPage extends ConsumerWidget {
  final String orderId;

  const OrderDetailPage({super.key, required this.orderId});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(title: const Text('주문 상세')),
      body: const Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.receipt_long, size: 80, color: Colors.grey),
            SizedBox(height: 16),
            Text(
              '주문 상세 페이지',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 8),
            Text('주문 ID: {orderId}', style: TextStyle(color: Colors.grey)),
            SizedBox(height: 24),
            Card(
              margin: EdgeInsets.all(16),
              child: Padding(
                padding: EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      '입금 안내',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: 12),
                    Text('은행: ${AppConstants.bankName}'),
                    Text('계좌번호: ${AppConstants.accountNumber}'),
                    Text('예금주: ${AppConstants.accountOwner}'),
                    Text('입금코드: BA-123456'),
                    Text('입금금액: 1,000,000원'),
                    Text('입금기한: 2024-01-15 23:59'),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
