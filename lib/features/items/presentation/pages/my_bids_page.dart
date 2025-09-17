import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../shared/widgets/empty_widget.dart';

class MyBidsPage extends ConsumerWidget {
  const MyBidsPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(title: const Text('내 입찰')),
      body: const EmptyWidget(
        message: '입찰 내역이 없습니다.',
        icon: Icons.gavel_outlined,
      ),
    );
  }
}
