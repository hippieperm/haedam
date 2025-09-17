import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../shared/widgets/empty_widget.dart';

class MyOrdersPage extends ConsumerWidget {
  const MyOrdersPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(title: const Text('내 주문')),
      body: const EmptyWidget(
        message: '주문 내역이 없습니다.',
        icon: Icons.shopping_bag_outlined,
      ),
    );
  }
}
