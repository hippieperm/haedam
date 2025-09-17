import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../providers/items_provider.dart';
import '../widgets/item_card.dart';
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

    final screenWidth = MediaQuery.of(context).size.width;
    final isDesktop = screenWidth > 1200;

    return Scaffold(
      appBar: AppBar(
        title: Row(
          children: [
            Container(
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: Theme.of(context).primaryColor.withOpacity(0.1),
                borderRadius: BorderRadius.circular(8),
              ),
              child: Icon(
                Icons.local_florist,
                color: Theme.of(context).primaryColor,
                size: 28,
              ),
            ),
            const SizedBox(width: 12),
            const Text(
              '해담',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 24),
            ),
          ],
        ),
        actions: [
          if (isDesktop) ...[
            TextButton.icon(
              onPressed: () {
                // TODO: 검색 기능 구현
              },
              icon: const Icon(Icons.search),
              label: const Text('검색'),
            ),
            const SizedBox(width: 8),
            TextButton.icon(
              onPressed: () {
                context.push('/profile');
              },
              icon: const Icon(Icons.person),
              label: const Text('프로필'),
            ),
            const SizedBox(width: 8),
            if (isLoggedIn)
              ElevatedButton.icon(
                onPressed: () {
                  context.push('/upload');
                },
                icon: const Icon(Icons.add),
                label: const Text('분재 등록'),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Theme.of(context).primaryColor,
                  foregroundColor: Colors.white,
                ),
              ),
            const SizedBox(width: 16),
          ] else ...[
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
        ],
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(48),
          child: Container(
            decoration: BoxDecoration(
              border: Border(
                bottom: BorderSide(color: Colors.grey.shade300, width: 1),
              ),
            ),
            child: TabBar(
              controller: _tabController,
              indicatorColor: Theme.of(context).primaryColor,
              labelColor: Theme.of(context).primaryColor,
              unselectedLabelColor: Colors.grey.shade600,
              labelStyle: const TextStyle(
                fontWeight: FontWeight.w600,
                fontSize: 16,
              ),
              tabs: const [
                Tab(text: '마감임박'),
                Tab(text: '신규'),
                Tab(text: '전체'),
              ],
            ),
          ),
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children: [
          _buildEndingSoonTab(isDesktop: isDesktop),
          _buildNewItemsTab(isDesktop: isDesktop),
          _buildAllItemsTab(isDesktop: isDesktop),
        ],
      ),
      floatingActionButton: isLoggedIn && !isDesktop
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

  Widget _buildEndingSoonTab({bool isDesktop = false}) {
    final endingSoonItems = ref.watch(endingSoonItemsProvider);
    print('Ending soon items state: ${endingSoonItems.runtimeType}');

    return endingSoonItems.when(
      data: (items) {
        print('Ending soon items data: ${items.length} items');
        if (items.isEmpty) {
          return _buildEmptyState(
            message: '마감 임박인 경매가 없습니다.',
            icon: Icons.schedule,
            isDesktop: isDesktop,
          );
        }
        return _buildItemsList(items, isDesktop: isDesktop);
      },
      loading: () {
        print('Ending soon items loading...');
        return _buildLoadingState(
          message: '마감 임박 경매를 불러오는 중...',
          isDesktop: isDesktop,
        );
      },
      error: (error, stack) {
        print('Ending soon error: $error');
        print('Stack trace: $stack');
        return _buildErrorState(
          message: '데이터를 불러오는 중 오류가 발생했습니다: ${error.toString()}',
          onRetry: () => ref.invalidate(endingSoonItemsProvider),
          isDesktop: isDesktop,
        );
      },
    );
  }

  Widget _buildNewItemsTab({bool isDesktop = false}) {
    final newItems = ref.watch(newItemsProvider);
    print('New items state: ${newItems.runtimeType}');

    return newItems.when(
      data: (items) {
        print('New items data: ${items.length} items');
        if (items.isEmpty) {
          return _buildEmptyState(
            message: '새로운 경매가 없습니다.',
            icon: Icons.new_releases,
            isDesktop: isDesktop,
          );
        }
        return _buildItemsList(items, isDesktop: isDesktop);
      },
      loading: () {
        print('New items loading...');
        return _buildLoadingState(
          message: '새로운 경매를 불러오는 중...',
          isDesktop: isDesktop,
        );
      },
      error: (error, stack) {
        print('New items error: $error');
        print('Stack trace: $stack');
        return _buildErrorState(
          message: '데이터를 불러오는 중 오류가 발생했습니다: ${error.toString()}',
          onRetry: () => ref.invalidate(newItemsProvider),
          isDesktop: isDesktop,
        );
      },
    );
  }

  Widget _buildAllItemsTab({bool isDesktop = false}) {
    final allItems = ref.watch(liveItemsProvider);
    print('All items state: ${allItems.runtimeType}');

    return allItems.when(
      data: (items) {
        print('All items data: ${items.length} items');
        if (items.isEmpty) {
          return _buildEmptyState(
            message: '진행 중인 경매가 없습니다.',
            icon: Icons.gavel,
            isDesktop: isDesktop,
          );
        }
        return _buildItemsList(items, isDesktop: isDesktop);
      },
      loading: () {
        print('All items loading...');
        return _buildLoadingState(
          message: '경매 목록을 불러오는 중...',
          isDesktop: isDesktop,
        );
      },
      error: (error, stack) {
        print('All items error: $error');
        print('Stack trace: $stack');
        return _buildErrorState(
          message: '데이터를 불러오는 중 오류가 발생했습니다: ${error.toString()}',
          onRetry: () => ref.invalidate(liveItemsProvider),
          isDesktop: isDesktop,
        );
      },
    );
  }

  Widget _buildItemsList(List items, {bool isDesktop = false}) {
    final screenWidth = MediaQuery.of(context).size.width;
    double spacing;

    if (screenWidth > 1200) {
      spacing = 20;
    } else if (screenWidth > 768) {
      spacing = 16;
    } else if (screenWidth > 480) {
      spacing = 12;
    } else {
      spacing = 8;
    }

    return Container(
      padding: EdgeInsets.all(
        screenWidth > 1200
            ? 32
            : screenWidth > 768
            ? 20
            : screenWidth > 480
            ? 12
            : 8,
      ),
      child: SingleChildScrollView(
        child: Wrap(
          alignment: WrapAlignment.center,
          spacing: spacing,
          runSpacing: spacing,
          children: items.map((item) {
            return ItemCard(
              item: item,
              onTap: () => context.push('/items/${item.id}'),
            );
          }).toList(),
        ),
      ),
    );
  }

  Widget _buildEmptyState({
    required String message,
    required IconData icon,
    bool isDesktop = false,
  }) {
    return Center(
      child: Padding(
        padding: EdgeInsets.all(isDesktop ? 64 : 32),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              padding: const EdgeInsets.all(24),
              decoration: BoxDecoration(
                color: Colors.grey.shade100,
                borderRadius: BorderRadius.circular(50),
              ),
              child: Icon(
                icon,
                size: isDesktop ? 64 : 48,
                color: Colors.grey.shade400,
              ),
            ),
            const SizedBox(height: 24),
            Text(
              message,
              style: TextStyle(
                fontSize: isDesktop ? 20 : 16,
                color: Colors.grey.shade600,
                fontWeight: FontWeight.w500,
              ),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildLoadingState({required String message, bool isDesktop = false}) {
    return Center(
      child: Padding(
        padding: EdgeInsets.all(isDesktop ? 64 : 32),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CircularProgressIndicator(
              strokeWidth: 3,
              valueColor: AlwaysStoppedAnimation<Color>(
                Theme.of(context).primaryColor,
              ),
            ),
            const SizedBox(height: 24),
            Text(
              message,
              style: TextStyle(
                fontSize: isDesktop ? 18 : 16,
                color: Colors.grey.shade600,
                fontWeight: FontWeight.w500,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildErrorState({
    required String message,
    required VoidCallback onRetry,
    bool isDesktop = false,
  }) {
    return Center(
      child: Padding(
        padding: EdgeInsets.all(isDesktop ? 64 : 32),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              padding: const EdgeInsets.all(24),
              decoration: BoxDecoration(
                color: Colors.red.shade50,
                borderRadius: BorderRadius.circular(50),
              ),
              child: Icon(
                Icons.error_outline,
                size: isDesktop ? 64 : 48,
                color: Colors.red.shade400,
              ),
            ),
            const SizedBox(height: 24),
            Text(
              message,
              style: TextStyle(
                fontSize: isDesktop ? 18 : 16,
                color: Colors.grey.shade600,
                fontWeight: FontWeight.w500,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 24),
            ElevatedButton.icon(
              onPressed: onRetry,
              icon: const Icon(Icons.refresh),
              label: const Text('다시 시도'),
              style: ElevatedButton.styleFrom(
                backgroundColor: Theme.of(context).primaryColor,
                foregroundColor: Colors.white,
                padding: EdgeInsets.symmetric(
                  horizontal: isDesktop ? 32 : 24,
                  vertical: isDesktop ? 16 : 12,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
