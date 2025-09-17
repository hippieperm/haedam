import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../providers/items_provider.dart';
import '../widgets/item_card.dart';
import '../../../../shared/widgets/loading_widget.dart';
import '../../../../shared/widgets/error_widget.dart';
import '../../../../shared/widgets/empty_widget.dart';
import '../../../auth/presentation/providers/auth_provider.dart';

class HomePage extends ConsumerStatefulWidget {
  const HomePage({super.key});

  @override
  ConsumerState<HomePage> createState() => _HomePageState();
}

class _HomePageState extends ConsumerState<HomePage>
    with TickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final isLoggedIn = ref
        .watch(authStateProvider)
        .when(
          data: (user) => user != null,
          loading: () => false,
          error: (_, __) => false,
        );

    // Firebase 연결 테스트
    final firebaseTest = ref.watch(firebaseConnectionTestProvider);
    firebaseTest.when(
      data: (isConnected) => print('Firebase connected: $isConnected'),
      loading: () => print('Testing Firebase connection...'),
      error: (error, stack) => print('Firebase connection error: $error'),
    );

    return Scaffold(
      appBar: AppBar(
        title: const Text('해담'),
        actions: [
          IconButton(
            icon: const Icon(Icons.search),
            onPressed: () {
              // TODO: 검색 기능 구현
            },
          ),
          IconButton(
            icon: const Icon(Icons.person),
            onPressed: () {
              context.push('/profile');
            },
          ),
          IconButton(
            icon: const Icon(Icons.bug_report),
            onPressed: () {
              context.push('/test-data');
            },
          ),
        ],
        bottom: TabBar(
          controller: _tabController,
          tabs: const [
            Tab(text: '마감임박'),
            Tab(text: '신규'),
            Tab(text: '전체'),
          ],
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children: [
          _buildEndingSoonTab(),
          _buildNewItemsTab(),
          _buildAllItemsTab(),
        ],
      ),
      floatingActionButton: isLoggedIn
          ? FloatingActionButton.extended(
              onPressed: () {
                context.push('/upload');
              },
              icon: const Icon(Icons.add),
              label: const Text('분재 등록'),
            )
          : null,
    );
  }

  Widget _buildEndingSoonTab() {
    final endingSoonItems = ref.watch(endingSoonItemsProvider);
    print('Ending soon items state: ${endingSoonItems.runtimeType}');

    return endingSoonItems.when(
      data: (items) {
        print('Ending soon items data: ${items.length} items');
        if (items.isEmpty) {
          return const EmptyWidget(
            message: '마감 임박인 경매가 없습니다.',
            icon: Icons.schedule,
          );
        }
        return _buildItemsList(items);
      },
      loading: () {
        print('Ending soon items loading...');
        return const LoadingWidget(message: '마감 임박 경매를 불러오는 중...');
      },
      error: (error, stack) {
        print('Ending soon error: $error');
        print('Stack trace: $stack');
        return AppErrorWidget(
          message: '데이터를 불러오는 중 오류가 발생했습니다: ${error.toString()}',
          onRetry: () => ref.invalidate(endingSoonItemsProvider),
        );
      },
    );
  }

  Widget _buildNewItemsTab() {
    final newItems = ref.watch(newItemsProvider);
    print('New items state: ${newItems.runtimeType}');

    return newItems.when(
      data: (items) {
        print('New items data: ${items.length} items');
        if (items.isEmpty) {
          return const EmptyWidget(
            message: '새로운 경매가 없습니다.',
            icon: Icons.new_releases,
          );
        }
        return _buildItemsList(items);
      },
      loading: () {
        print('New items loading...');
        return const LoadingWidget(message: '새로운 경매를 불러오는 중...');
      },
      error: (error, stack) {
        print('New items error: $error');
        print('Stack trace: $stack');
        return AppErrorWidget(
          message: '데이터를 불러오는 중 오류가 발생했습니다: ${error.toString()}',
          onRetry: () => ref.invalidate(newItemsProvider),
        );
      },
    );
  }

  Widget _buildAllItemsTab() {
    final allItems = ref.watch(liveItemsProvider);
    print('All items state: ${allItems.runtimeType}');

    return allItems.when(
      data: (items) {
        print('All items data: ${items.length} items');
        if (items.isEmpty) {
          return const EmptyWidget(
            message: '진행 중인 경매가 없습니다.',
            icon: Icons.gavel,
          );
        }
        return _buildItemsList(items);
      },
      loading: () {
        print('All items loading...');
        return const LoadingWidget(message: '경매 목록을 불러오는 중...');
      },
      error: (error, stack) {
        print('All items error: $error');
        print('Stack trace: $stack');
        return AppErrorWidget(
          message: '데이터를 불러오는 중 오류가 발생했습니다: ${error.toString()}',
          onRetry: () => ref.invalidate(liveItemsProvider),
        );
      },
    );
  }

  Widget _buildItemsList(List items) {
    return GridView.builder(
      padding: const EdgeInsets.all(16),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        childAspectRatio: 0.8,
        crossAxisSpacing: 16,
        mainAxisSpacing: 16,
      ),
      itemCount: items.length,
      itemBuilder: (context, index) {
        final item = items[index];
        return ItemCard(
          item: item,
          onTap: () => context.push('/items/${item.id}'),
        );
      },
    );
  }
}
