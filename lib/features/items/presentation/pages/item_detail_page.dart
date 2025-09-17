import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:intl/intl.dart';
import 'dart:convert';
import '../providers/items_provider.dart';
import '../../../../shared/widgets/loading_widget.dart';
import '../../../../shared/widgets/error_widget.dart';

class ItemDetailPage extends ConsumerStatefulWidget {
  final String itemId;

  const ItemDetailPage({super.key, required this.itemId});

  @override
  ConsumerState<ItemDetailPage> createState() => _ItemDetailPageState();
}

class _ItemDetailPageState extends ConsumerState<ItemDetailPage>
    with TickerProviderStateMixin {
  late TabController _tabController;
  int _currentImageIndex = 0;

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
    final itemAsync = ref.watch(itemProvider(widget.itemId));

    return itemAsync.when(
      data: (item) {
        if (item == null) {
          return _buildNotFound();
        }
        return _buildItemDetail(item);
      },
      loading: () => const LoadingWidget(message: '분재 정보를 불러오는 중...'),
      error: (error, stack) => AppErrorWidget(
        message: error.toString(),
        onRetry: () => ref.invalidate(itemProvider(widget.itemId)),
      ),
    );
  }

  Widget _buildNotFound() {
    return Scaffold(
      appBar: AppBar(title: const Text('분재 상세'), centerTitle: true),
      body: const Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.search_off, size: 64, color: Colors.grey),
            SizedBox(height: 16),
            Text(
              '분재를 찾을 수 없습니다',
              style: TextStyle(fontSize: 18, color: Colors.grey),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildItemDetail(item) {
    final timeLeft = _getTimeLeft(item);
    final isEndingSoon = timeLeft.inHours < 2;
    final isEnded = timeLeft == Duration.zero;

    return Scaffold(
      appBar: AppBar(
        title: Text(item.title),
        centerTitle: false,
        actions: [
          IconButton(
            icon: const Icon(Icons.share),
            onPressed: () {
              ScaffoldMessenger.of(
                context,
              ).showSnackBar(const SnackBar(content: Text('공유 기능은 준비 중입니다.')));
            },
          ),
          IconButton(
            icon: const Icon(Icons.favorite_border),
            onPressed: () {
              ScaffoldMessenger.of(
                context,
              ).showSnackBar(const SnackBar(content: Text('찜하기 기능은 준비 중입니다.')));
            },
          ),
        ],
      ),
      body: LayoutBuilder(
        builder: (context, constraints) {
          // 웹/데스크톱 레이아웃 (너비가 1200px 이상)
          if (constraints.maxWidth >= 1200) {
            return _buildWebLayout(item, timeLeft, isEndingSoon, isEnded);
          }
          // 태블릿 레이아웃 (너비가 768px 이상)
          else if (constraints.maxWidth >= 768) {
            return _buildTabletLayout(item, timeLeft, isEndingSoon, isEnded);
          }
          // 모바일 레이아웃
          else {
            return _buildMobileLayout(item, timeLeft, isEndingSoon, isEnded);
          }
        },
      ),
    );
  }

  Widget _buildWebLayout(
    item,
    Duration timeLeft,
    bool isEndingSoon,
    bool isEnded,
  ) {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // 상단 이미지와 기본 정보
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // 왼쪽: 이미지 갤러리
                Expanded(flex: 2, child: _buildWebImageGallery(item)),
                const SizedBox(width: 32),
                // 오른쪽: 경매 정보 및 입찰
                Expanded(
                  flex: 1,
                  child: _buildWebAuctionPanel(
                    item,
                    timeLeft,
                    isEndingSoon,
                    isEnded,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 32),

            // 하단: 상세 정보 탭
            _buildWebDetailTabs(item, timeLeft, isEndingSoon, isEnded),
          ],
        ),
      ),
    );
  }

  Widget _buildTabletLayout(
    item,
    Duration timeLeft,
    bool isEndingSoon,
    bool isEnded,
  ) {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // 이미지 갤러리
            _buildWebImageGallery(item),
            const SizedBox(height: 24),

            // 경매 정보 카드
            _buildAuctionStatusCard(item, timeLeft, isEndingSoon, isEnded),
            const SizedBox(height: 24),

            // 탭바
            _buildTabBar(),
            const SizedBox(height: 16),

            // 탭 콘텐츠
            SizedBox(
              height: 500,
              child: TabBarView(
                controller: _tabController,
                children: [
                  _buildAuctionTab(item, timeLeft, isEndingSoon, isEnded),
                  _buildItemInfoTab(item),
                  _buildBiddingTab(item, timeLeft, isEndingSoon, isEnded),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildMobileLayout(
    item,
    Duration timeLeft,
    bool isEndingSoon,
    bool isEnded,
  ) {
    return CustomScrollView(
      slivers: [
        // 상단 앱바와 이미지
        SliverAppBar(
          expandedHeight: 300,
          pinned: true,
          flexibleSpace: FlexibleSpaceBar(
            background: _buildImageGallery(item),
            title: Text(
              item.title,
              style: const TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
                shadows: [
                  Shadow(
                    offset: Offset(0, 1),
                    blurRadius: 3,
                    color: Colors.black54,
                  ),
                ],
              ),
            ),
          ),
        ),

        // 메인 콘텐츠
        SliverToBoxAdapter(
          child: Column(
            children: [
              // 경매 상태 배지
              _buildAuctionStatusCard(item, timeLeft, isEndingSoon, isEnded),

              // 탭바
              _buildTabBar(),

              // 탭 콘텐츠
              SizedBox(
                height: 600,
                child: TabBarView(
                  controller: _tabController,
                  children: [
                    _buildAuctionTab(item, timeLeft, isEndingSoon, isEnded),
                    _buildItemInfoTab(item),
                    _buildBiddingTab(item, timeLeft, isEndingSoon, isEnded),
                  ],
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildWebImageGallery(item) {
    final imageCount = (item.media?.length ?? 0) + 1;

    return Card(
      elevation: 2,
      child: Column(
        children: [
          // 메인 이미지
          Container(
            height: 500,
            width: double.infinity,
            child: ClipRRect(
              borderRadius: const BorderRadius.vertical(
                top: Radius.circular(12),
              ),
              child: _buildImageWidget(context, item.coverImageUrl),
            ),
          ),

          // 썸네일 갤러리
          if (imageCount > 1)
            Container(
              height: 80,
              padding: const EdgeInsets.all(8),
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: imageCount,
                itemBuilder: (context, index) {
                  String imageUrl;
                  if (index == 0) {
                    imageUrl = item.coverImageUrl;
                  } else {
                    imageUrl = item.media[index - 1].url;
                  }

                  return GestureDetector(
                    onTap: () {
                      setState(() {
                        _currentImageIndex = index;
                      });
                    },
                    child: Container(
                      width: 80,
                      height: 64,
                      margin: const EdgeInsets.symmetric(horizontal: 4),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(8),
                        border: Border.all(
                          color: _currentImageIndex == index
                              ? Theme.of(context).colorScheme.primary
                              : Colors.grey[300]!,
                          width: 2,
                        ),
                      ),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(6),
                        child: _buildImageWidget(context, imageUrl),
                      ),
                    ),
                  );
                },
              ),
            ),
        ],
      ),
    );
  }

  Widget _buildImageGallery(item) {
    final imageCount = (item.media?.length ?? 0) + 1;

    return Stack(
      children: [
        PageView.builder(
          onPageChanged: (index) {
            setState(() {
              _currentImageIndex = index;
            });
          },
          itemCount: imageCount,
          itemBuilder: (context, index) {
            String imageUrl;
            if (index == 0) {
              imageUrl = item.coverImageUrl;
            } else {
              imageUrl = item.media[index - 1].url;
            }
            return _buildImageWidget(context, imageUrl);
          },
        ),

        // 이미지 인디케이터
        if (imageCount > 1)
          Positioned(
            bottom: 16,
            left: 0,
            right: 0,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: List.generate(
                imageCount,
                (index) => Container(
                  margin: const EdgeInsets.symmetric(horizontal: 4),
                  width: 8,
                  height: 8,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: _currentImageIndex == index
                        ? Colors.white
                        : Colors.white.withOpacity(0.5),
                  ),
                ),
              ),
            ),
          ),
      ],
    );
  }

  Widget _buildImageWidget(BuildContext context, String imageUrl) {
    // 이미지 URL이 비어있는 경우
    if (imageUrl.isEmpty) {
      return _buildErrorWidget(context);
    }

    // Base64 이미지인지 확인 (data:image로 시작하는지 체크)
    if (imageUrl.startsWith('data:image/') ||
        (imageUrl.isNotEmpty && !imageUrl.startsWith('http'))) {
      // Base64 이미지 처리
      try {
        String base64String = imageUrl;
        if (base64String.startsWith('data:image/')) {
          base64String = base64String.split(',')[1];
        }

        // Base64 문자열이 유효한지 확인
        if (base64String.isEmpty) {
          return _buildErrorWidget(context);
        }

        final bytes = base64Decode(base64String);
        if (bytes.isEmpty) {
          return _buildErrorWidget(context);
        }

        return Image.memory(
          bytes,
          fit: BoxFit.contain,
          width: double.infinity,
          height: double.infinity,
          errorBuilder: (context, error, stackTrace) {
            print('Base64 image decode error: $error');
            return _buildErrorWidget(context);
          },
        );
      } catch (e) {
        print('Base64 image processing error: $e');
        return _buildErrorWidget(context);
      }
    } else {
      // URL 이미지 처리
      return CachedNetworkImage(
        imageUrl: imageUrl,
        fit: BoxFit.contain,
        width: double.infinity,
        height: double.infinity,
        placeholder: (context, url) => Container(
          color: Colors.grey[200],
          child: const Center(child: CircularProgressIndicator()),
        ),
        errorWidget: (context, url, error) {
          print('Network image error: $error');
          return _buildErrorWidget(context);
        },
      );
    }
  }

  Widget _buildErrorWidget(BuildContext context) {
    return Container(
      color: Colors.grey[200],
      child: const Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.image_not_supported, color: Colors.grey, size: 50),
            SizedBox(height: 8),
            Text('이미지를 불러올 수 없습니다', style: TextStyle(color: Colors.grey)),
          ],
        ),
      ),
    );
  }

  Widget _buildWebAuctionPanel(
    item,
    Duration timeLeft,
    bool isEndingSoon,
    bool isEnded,
  ) {
    return Card(
      elevation: 4,
      child: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // 제목
            Text(
              item.title,
              style: Theme.of(
                context,
              ).textTheme.headlineSmall?.copyWith(fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),

            // 종류 정보
            Wrap(
              spacing: 8,
              runSpacing: 8,
              children: [
                _buildInfoChip(item.species, Icons.local_florist),
                _buildInfoChip(item.style, Icons.architecture),
                _buildInfoChip(item.sizeClass, Icons.straighten),
              ],
            ),
            const SizedBox(height: 24),

            // 경매 상태 배지
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 16,
                    vertical: 8,
                  ),
                  decoration: BoxDecoration(
                    color: isEnded
                        ? Colors.grey[400]
                        : isEndingSoon
                        ? Colors.red[600]
                        : Theme.of(context).colorScheme.primary,
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Text(
                    isEnded
                        ? '경매 종료'
                        : isEndingSoon
                        ? '마감 임박'
                        : '경매 진행중',
                    style: const TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 14,
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 24),

            // 가격 정보
            Container(
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: Theme.of(
                  context,
                ).colorScheme.primaryContainer.withOpacity(0.3),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Column(
                children: [
                  Text(
                    '현재가',
                    style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                      color: Theme.of(context).colorScheme.onSurfaceVariant,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    '${NumberFormat('#,###').format(item.auction?.currentPrice ?? item.auction?.startPrice ?? 0)}원',
                    style: Theme.of(context).textTheme.headlineLarge?.copyWith(
                      fontWeight: FontWeight.bold,
                      color: isEnded
                          ? Colors.grey[600]
                          : Theme.of(context).colorScheme.primary,
                    ),
                  ),
                  if (item.auction?.buyNowPrice != null) ...[
                    const SizedBox(height: 16),
                    const Divider(),
                    const SizedBox(height: 16),
                    Text(
                      '즉시구매가',
                      style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                        color: Theme.of(context).colorScheme.onSurfaceVariant,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      '${NumberFormat('#,###').format(item.auction!.buyNowPrice!)}원',
                      style: Theme.of(context).textTheme.headlineMedium
                          ?.copyWith(
                            fontWeight: FontWeight.bold,
                            color: Theme.of(context).colorScheme.primary,
                          ),
                    ),
                  ],
                ],
              ),
            ),
            const SizedBox(height: 24),

            // 타이머
            if (!isEnded)
              Material(
                color: Colors.transparent,
                child: Container(
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: isEndingSoon
                        ? Colors.red[50]
                        : Theme.of(context).colorScheme.surface,
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(
                      color: isEndingSoon
                          ? Colors.red[300]!
                          : Theme.of(
                              context,
                            ).colorScheme.outline.withOpacity(0.3),
                    ),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.schedule,
                        size: 24,
                        color: isEndingSoon
                            ? Colors.red[600]
                            : Theme.of(context).colorScheme.onSurfaceVariant,
                      ),
                      const SizedBox(width: 12),
                      Text(
                        _formatTimeLeft(timeLeft),
                        style: Theme.of(context).textTheme.titleLarge?.copyWith(
                          color: isEndingSoon
                              ? Colors.red[600]
                              : Theme.of(context).colorScheme.onSurface,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            const SizedBox(height: 24),

            // 입찰 버튼들
            if (!isEnded) ...[
              SizedBox(
                width: double.infinity,
                child: FilledButton.icon(
                  onPressed: () => _showBidDialog(item),
                  icon: const Icon(Icons.gavel),
                  label: const Text('입찰하기'),
                  style: FilledButton.styleFrom(
                    padding: const EdgeInsets.symmetric(vertical: 16),
                  ),
                ),
              ),
              if (item.auction?.buyNowPrice != null) ...[
                const SizedBox(height: 12),
                SizedBox(
                  width: double.infinity,
                  child: OutlinedButton.icon(
                    onPressed: () => _showBuyNowDialog(item),
                    icon: const Icon(Icons.flash_on),
                    label: Text(
                      '즉시구매 (${NumberFormat('#,###').format(item.auction!.buyNowPrice!)}원)',
                    ),
                    style: OutlinedButton.styleFrom(
                      padding: const EdgeInsets.symmetric(vertical: 16),
                    ),
                  ),
                ),
              ],
            ] else ...[
              Container(
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                  color: Colors.grey[100],
                  borderRadius: BorderRadius.circular(12),
                ),
                child: const Column(
                  children: [
                    Icon(Icons.event_busy, size: 48, color: Colors.grey),
                    SizedBox(height: 12),
                    Text(
                      '이 경매는 종료되었습니다',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Colors.grey,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }

  Widget _buildWebDetailTabs(
    item,
    Duration timeLeft,
    bool isEndingSoon,
    bool isEnded,
  ) {
    return Card(
      elevation: 2,
      child: Column(
        children: [
          // 탭바
          Container(
            decoration: BoxDecoration(
              color: Theme.of(
                context,
              ).colorScheme.surfaceVariant.withOpacity(0.3),
              borderRadius: const BorderRadius.vertical(
                top: Radius.circular(12),
              ),
            ),
            child: TabBar(
              controller: _tabController,
              indicator: BoxDecoration(
                color: Theme.of(context).colorScheme.primary,
                borderRadius: BorderRadius.circular(8),
              ),
              labelColor: Colors.white,
              unselectedLabelColor: Theme.of(
                context,
              ).colorScheme.onSurfaceVariant,
              labelStyle: const TextStyle(
                fontWeight: FontWeight.w600,
                fontSize: 16,
              ),
              dividerColor: Colors.transparent,
              tabs: const [
                Tab(text: '경매 정보'),
                Tab(text: '분재 정보'),
                Tab(text: '입찰 이력'),
              ],
            ),
          ),

          // 탭 콘텐츠
          Container(
            height: 400,
            child: TabBarView(
              controller: _tabController,
              children: [
                _buildWebAuctionInfoTab(item, timeLeft, isEndingSoon, isEnded),
                _buildWebItemInfoTab(item),
                _buildWebBiddingHistoryTab(item),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildWebAuctionInfoTab(
    item,
    Duration timeLeft,
    bool isEndingSoon,
    bool isEnded,
  ) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildWebInfoRow(
            Icons.gavel,
            '시작가',
            '${NumberFormat('#,###').format(item.auction?.startPrice ?? 0)}원',
          ),
          _buildWebInfoRow(
            Icons.trending_up,
            '현재가',
            '${NumberFormat('#,###').format(item.auction?.currentPrice ?? item.auction?.startPrice ?? 0)}원',
          ),
          if (item.auction?.buyNowPrice != null)
            _buildWebInfoRow(
              Icons.flash_on,
              '즉시구매가',
              '${NumberFormat('#,###').format(item.auction!.buyNowPrice!)}원',
            ),
          _buildWebInfoRow(
            Icons.add_circle_outline,
            '입찰 단위',
            '${NumberFormat('#,###').format(item.auction?.bidStep ?? 1000)}원',
          ),
          _buildWebInfoRow(
            Icons.how_to_vote,
            '입찰 수',
            '${item.auction?.bidCount ?? 0}회',
          ),
          _buildWebInfoRow(
            Icons.schedule,
            '경매 시작',
            DateFormat(
              'yyyy-MM-dd HH:mm',
            ).format(item.auction?.startsAt ?? DateTime.now()),
          ),
          _buildWebInfoRow(
            Icons.event,
            '경매 종료',
            DateFormat(
              'yyyy-MM-dd HH:mm',
            ).format(item.auction?.endsAt ?? DateTime.now()),
          ),
        ],
      ),
    );
  }

  Widget _buildWebItemInfoTab(item) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildWebInfoRow(Icons.height, '높이', '${item.heightCm}cm'),
          _buildWebInfoRow(Icons.width_wide, '관폭', '${item.crownWidthCm}cm'),
          _buildWebInfoRow(Icons.cake, '추정 수령', '${item.ageYearsEst}년'),
          if (item.healthNotes != null) ...[
            const SizedBox(height: 16),
            _buildWebDetailSection(
              '건강 상태',
              item.healthNotes!,
              Icons.health_and_safety,
            ),
          ],
          if (item.originNotes != null) ...[
            const SizedBox(height: 16),
            _buildWebDetailSection('출처', item.originNotes!, Icons.location_on),
          ],
          if (item.careHistory != null) ...[
            const SizedBox(height: 16),
            _buildWebDetailSection('관리 이력', item.careHistory!, Icons.history),
          ],
        ],
      ),
    );
  }

  Widget _buildWebBiddingHistoryTab(item) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            '입찰 이력',
            style: Theme.of(
              context,
            ).textTheme.titleLarge?.copyWith(fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 16),
          // TODO: 실제 입찰 이력 데이터 연결
          Container(
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
              color: Colors.grey[50],
              borderRadius: BorderRadius.circular(12),
            ),
            child: const Center(
              child: Text('입찰 이력이 없습니다', style: TextStyle(color: Colors.grey)),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildWebInfoRow(IconData icon, String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 12),
      child: Row(
        children: [
          Icon(icon, size: 24, color: Theme.of(context).colorScheme.primary),
          const SizedBox(width: 16),
          SizedBox(
            width: 120,
            child: Text(
              label,
              style: Theme.of(context).textTheme.titleMedium?.copyWith(
                color: Theme.of(context).colorScheme.onSurfaceVariant,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
          Expanded(
            child: Text(
              value,
              style: Theme.of(
                context,
              ).textTheme.titleMedium?.copyWith(fontWeight: FontWeight.w600),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildWebDetailSection(String title, String content, IconData icon) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Icon(icon, size: 24, color: Theme.of(context).colorScheme.primary),
            const SizedBox(width: 12),
            Text(
              title,
              style: Theme.of(
                context,
              ).textTheme.titleLarge?.copyWith(fontWeight: FontWeight.bold),
            ),
          ],
        ),
        const SizedBox(height: 12),
        Container(
          width: double.infinity,
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: Theme.of(
              context,
            ).colorScheme.surfaceVariant.withOpacity(0.3),
            borderRadius: BorderRadius.circular(8),
          ),
          child: Text(content, style: Theme.of(context).textTheme.bodyLarge),
        ),
      ],
    );
  }

  Widget _buildAuctionStatusCard(
    item,
    Duration timeLeft,
    bool isEndingSoon,
    bool isEnded,
  ) {
    return Container(
      margin: const EdgeInsets.all(16),
      child: Card(
        elevation: 0,
        color: isEnded
            ? Colors.grey[100]
            : isEndingSoon
            ? Colors.red[50]
            : Theme.of(context).colorScheme.primaryContainer,
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            children: [
              // 상태 배지
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 12,
                      vertical: 6,
                    ),
                    decoration: BoxDecoration(
                      color: isEnded
                          ? Colors.grey[400]
                          : isEndingSoon
                          ? Colors.red[600]
                          : Theme.of(context).colorScheme.primary,
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Text(
                      isEnded
                          ? '경매 종료'
                          : isEndingSoon
                          ? '마감 임박'
                          : '경매 진행중',
                      style: const TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 12,
                      ),
                    ),
                  ),
                ],
              ),

              const SizedBox(height: 16),

              // 가격 정보
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        '현재가',
                        style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                          color: Theme.of(context).colorScheme.onSurfaceVariant,
                        ),
                      ),
                      Text(
                        '${NumberFormat('#,###').format(item.auction?.currentPrice ?? item.auction?.startPrice ?? 0)}원',
                        style: Theme.of(context).textTheme.headlineMedium
                            ?.copyWith(
                              fontWeight: FontWeight.bold,
                              color: isEnded ? Colors.grey[600] : null,
                            ),
                      ),
                    ],
                  ),
                  if (item.auction?.buyNowPrice != null)
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Text(
                          '즉시구매가',
                          style: Theme.of(context).textTheme.bodyMedium
                              ?.copyWith(
                                color: Theme.of(
                                  context,
                                ).colorScheme.onSurfaceVariant,
                              ),
                        ),
                        Text(
                          '${NumberFormat('#,###').format(item.auction!.buyNowPrice!)}원',
                          style: Theme.of(context).textTheme.titleLarge
                              ?.copyWith(
                                fontWeight: FontWeight.bold,
                                color: Theme.of(context).colorScheme.primary,
                              ),
                        ),
                      ],
                    ),
                ],
              ),

              const SizedBox(height: 16),

              // 타이머
              if (!isEnded)
                Material(
                  color: Colors.transparent,
                  child: Container(
                    padding: const EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      color: isEndingSoon
                          ? Colors.red[100]
                          : Theme.of(context).colorScheme.surface,
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all(
                        color: isEndingSoon
                            ? Colors.red[300]!
                            : Theme.of(
                                context,
                              ).colorScheme.outline.withOpacity(0.3),
                      ),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.schedule,
                          size: 20,
                          color: isEndingSoon
                              ? Colors.red[600]
                              : Theme.of(context).colorScheme.onSurfaceVariant,
                        ),
                        const SizedBox(width: 8),
                        Text(
                          _formatTimeLeft(timeLeft),
                          style: Theme.of(context).textTheme.titleMedium
                              ?.copyWith(
                                color: isEndingSoon
                                    ? Colors.red[600]
                                    : Theme.of(context).colorScheme.onSurface,
                                fontWeight: FontWeight.bold,
                              ),
                        ),
                      ],
                    ),
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildTabBar() {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16),
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.surfaceVariant.withOpacity(0.3),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Material(
        color: Colors.transparent,
        child: TabBar(
          controller: _tabController,
          indicator: BoxDecoration(
            color: Theme.of(context).colorScheme.primary,
            borderRadius: BorderRadius.circular(10),
          ),
          labelColor: Colors.white,
          unselectedLabelColor: Theme.of(context).colorScheme.onSurfaceVariant,
          labelStyle: const TextStyle(fontWeight: FontWeight.w600),
          dividerColor: Colors.transparent,
          tabs: const [
            Tab(text: '경매'),
            Tab(text: '정보'),
            Tab(text: '입찰'),
          ],
        ),
      ),
    );
  }

  Widget _buildAuctionTab(
    item,
    Duration timeLeft,
    bool isEndingSoon,
    bool isEnded,
  ) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // 경매 기본 정보
          Card(
            child: Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    '경매 정보',
                    style: Theme.of(context).textTheme.titleLarge?.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 16),

                  _buildInfoRow(
                    Icons.gavel,
                    '시작가',
                    '${NumberFormat('#,###').format(item.auction?.startPrice ?? 0)}원',
                  ),
                  _buildInfoRow(
                    Icons.trending_up,
                    '현재가',
                    '${NumberFormat('#,###').format(item.auction?.currentPrice ?? item.auction?.startPrice ?? 0)}원',
                  ),
                  if (item.auction?.buyNowPrice != null)
                    _buildInfoRow(
                      Icons.flash_on,
                      '즉시구매가',
                      '${NumberFormat('#,###').format(item.auction!.buyNowPrice!)}원',
                    ),
                  _buildInfoRow(
                    Icons.add_circle_outline,
                    '입찰 단위',
                    '${NumberFormat('#,###').format(item.auction?.bidStep ?? 1000)}원',
                  ),
                  _buildInfoRow(
                    Icons.how_to_vote,
                    '입찰 수',
                    '${item.auction?.bidCount ?? 0}회',
                  ),
                ],
              ),
            ),
          ),

          const SizedBox(height: 16),

          // 입찰자 정보 (있는 경우)
          if (item.auction?.currentBidderId != null)
            Card(
              child: Padding(
                padding: const EdgeInsets.all(20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      '현재 최고 입찰자',
                      style: Theme.of(context).textTheme.titleLarge?.copyWith(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 12),
                    Row(
                      children: [
                        CircleAvatar(
                          backgroundColor: Theme.of(
                            context,
                          ).colorScheme.primary,
                          child: Text(
                            'B',
                            style: TextStyle(
                              color: Theme.of(context).colorScheme.onPrimary,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                        const SizedBox(width: 12),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                '입찰자 ${item.auction!.currentBidderId!.substring(0, 8)}...',
                                style: Theme.of(context).textTheme.titleMedium,
                              ),
                              Text(
                                '${NumberFormat('#,###').format(item.auction!.currentPrice)}원',
                                style: Theme.of(context).textTheme.bodyLarge
                                    ?.copyWith(
                                      color: Theme.of(
                                        context,
                                      ).colorScheme.primary,
                                      fontWeight: FontWeight.bold,
                                    ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
        ],
      ),
    );
  }

  Widget _buildItemInfoTab(item) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // 기본 정보
          Card(
            child: Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    '분재 정보',
                    style: Theme.of(context).textTheme.titleLarge?.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 16),

                  // 종류 칩들
                  Wrap(
                    spacing: 8,
                    runSpacing: 8,
                    children: [
                      _buildInfoChip(item.species, Icons.local_florist),
                      _buildInfoChip(item.style, Icons.architecture),
                      _buildInfoChip(item.sizeClass, Icons.straighten),
                    ],
                  ),

                  const SizedBox(height: 20),

                  _buildInfoRow(Icons.height, '높이', '${item.heightCm}cm'),
                  _buildInfoRow(
                    Icons.width_wide,
                    '관폭',
                    '${item.crownWidthCm}cm',
                  ),
                  _buildInfoRow(Icons.cake, '추정 수령', '${item.ageYearsEst}년'),
                ],
              ),
            ),
          ),

          const SizedBox(height: 16),

          // 상세 정보
          if (item.healthNotes != null ||
              item.originNotes != null ||
              item.careHistory != null)
            Card(
              child: Padding(
                padding: const EdgeInsets.all(20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      '상세 정보',
                      style: Theme.of(context).textTheme.titleLarge?.copyWith(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 16),

                    if (item.healthNotes != null) ...[
                      _buildDetailSection(
                        '건강 상태',
                        item.healthNotes!,
                        Icons.health_and_safety,
                      ),
                      const SizedBox(height: 16),
                    ],
                    if (item.originNotes != null) ...[
                      _buildDetailSection(
                        '출처',
                        item.originNotes!,
                        Icons.location_on,
                      ),
                      const SizedBox(height: 16),
                    ],
                    if (item.careHistory != null) ...[
                      _buildDetailSection(
                        '관리 이력',
                        item.careHistory!,
                        Icons.history,
                      ),
                    ],
                  ],
                ),
              ),
            ),
        ],
      ),
    );
  }

  Widget _buildBiddingTab(
    item,
    Duration timeLeft,
    bool isEndingSoon,
    bool isEnded,
  ) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        children: [
          // 입찰 폼
          Card(
            child: Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    isEnded ? '경매가 종료되었습니다' : '입찰하기',
                    style: Theme.of(context).textTheme.titleLarge?.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 16),

                  if (!isEnded) ...[
                    // 현재가 표시
                    Material(
                      color: Colors.transparent,
                      child: Container(
                        padding: const EdgeInsets.all(16),
                        decoration: BoxDecoration(
                          color: Theme.of(context).colorScheme.primaryContainer,
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              '현재가',
                              style: Theme.of(context).textTheme.titleMedium,
                            ),
                            Text(
                              '${NumberFormat('#,###').format(item.auction?.currentPrice ?? item.auction?.startPrice ?? 0)}원',
                              style: Theme.of(context).textTheme.headlineSmall
                                  ?.copyWith(
                                    fontWeight: FontWeight.bold,
                                    color: Theme.of(
                                      context,
                                    ).colorScheme.primary,
                                  ),
                            ),
                          ],
                        ),
                      ),
                    ),

                    const SizedBox(height: 20),

                    // 입찰 버튼들
                    Row(
                      children: [
                        Expanded(
                          child: FilledButton.icon(
                            onPressed: () {
                              _showBidDialog(item);
                            },
                            icon: const Icon(Icons.gavel),
                            label: const Text('입찰하기'),
                            style: FilledButton.styleFrom(
                              padding: const EdgeInsets.symmetric(vertical: 16),
                            ),
                          ),
                        ),
                      ],
                    ),

                    if (item.auction?.buyNowPrice != null) ...[
                      const SizedBox(height: 12),
                      Row(
                        children: [
                          Expanded(
                            child: OutlinedButton.icon(
                              onPressed: () {
                                _showBuyNowDialog(item);
                              },
                              icon: const Icon(Icons.flash_on),
                              label: Text(
                                '즉시구매 (${NumberFormat('#,###').format(item.auction!.buyNowPrice!)}원)',
                              ),
                              style: OutlinedButton.styleFrom(
                                padding: const EdgeInsets.symmetric(
                                  vertical: 16,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ] else ...[
                    // 경매 종료 메시지
                    Material(
                      color: Colors.transparent,
                      child: Container(
                        padding: const EdgeInsets.all(20),
                        decoration: BoxDecoration(
                          color: Colors.grey[100],
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: const Column(
                          children: [
                            Icon(
                              Icons.event_busy,
                              size: 48,
                              color: Colors.grey,
                            ),
                            SizedBox(height: 12),
                            Text(
                              '이 경매는 종료되었습니다',
                              style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                                color: Colors.grey,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildInfoRow(IconData icon, String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Row(
        children: [
          Icon(icon, size: 20, color: Theme.of(context).colorScheme.primary),
          const SizedBox(width: 12),
          SizedBox(
            width: 100,
            child: Text(
              label,
              style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                color: Theme.of(context).colorScheme.onSurfaceVariant,
              ),
            ),
          ),
          Expanded(
            child: Text(
              value,
              style: Theme.of(
                context,
              ).textTheme.bodyLarge?.copyWith(fontWeight: FontWeight.w500),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildInfoChip(String label, IconData icon) {
    return Chip(
      avatar: Icon(icon, size: 16),
      label: Text(label),
      backgroundColor: Theme.of(context).colorScheme.primaryContainer,
      labelStyle: TextStyle(
        color: Theme.of(context).colorScheme.onPrimaryContainer,
        fontWeight: FontWeight.w500,
      ),
    );
  }

  Widget _buildDetailSection(String title, String content, IconData icon) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Icon(icon, size: 20, color: Theme.of(context).colorScheme.primary),
            const SizedBox(width: 8),
            Text(
              title,
              style: Theme.of(
                context,
              ).textTheme.titleMedium?.copyWith(fontWeight: FontWeight.bold),
            ),
          ],
        ),
        const SizedBox(height: 8),
        Text(content, style: Theme.of(context).textTheme.bodyMedium),
      ],
    );
  }

  void _showBidDialog(item) {
    final currentPrice =
        item.auction?.currentPrice ?? item.auction?.startPrice ?? 0;
    final bidStep = item.auction?.bidStep ?? 1000;
    final nextBid = currentPrice + bidStep;

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('입찰하기'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text('다음 입찰가: ${NumberFormat('#,###').format(nextBid)}원'),
            const SizedBox(height: 16),
            const Text('이 가격으로 입찰하시겠습니까?'),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('취소'),
          ),
          FilledButton(
            onPressed: () {
              Navigator.pop(context);
              ScaffoldMessenger.of(
                context,
              ).showSnackBar(const SnackBar(content: Text('입찰 기능은 준비 중입니다.')));
            },
            child: const Text('입찰'),
          ),
        ],
      ),
    );
  }

  void _showBuyNowDialog(item) {
    final buyNowPrice = item.auction?.buyNowPrice ?? 0;

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('즉시구매'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text('즉시구매가: ${NumberFormat('#,###').format(buyNowPrice)}원'),
            const SizedBox(height: 16),
            const Text('이 가격으로 즉시구매하시겠습니까?'),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('취소'),
          ),
          FilledButton(
            onPressed: () {
              Navigator.pop(context);
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('즉시구매 기능은 준비 중입니다.')),
              );
            },
            child: const Text('구매'),
          ),
        ],
      ),
    );
  }

  Duration _getTimeLeft(item) {
    final endsAt = item.auction?.endsAt;
    if (endsAt == null) return Duration.zero;

    final now = DateTime.now();
    final difference = endsAt.difference(now);
    return difference.isNegative ? Duration.zero : difference;
  }

  String _formatTimeLeft(Duration duration) {
    if (duration.inDays > 0) {
      return '${duration.inDays}일 ${duration.inHours % 24}시간 남음';
    } else if (duration.inHours > 0) {
      return '${duration.inHours}시간 ${duration.inMinutes % 60}분 남음';
    } else if (duration.inMinutes > 0) {
      return '${duration.inMinutes}분 남음';
    } else {
      return '마감됨';
    }
  }
}
