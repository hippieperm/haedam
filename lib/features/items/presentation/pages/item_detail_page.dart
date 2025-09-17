import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:intl/intl.dart';
import '../providers/items_provider.dart';
import '../../../../shared/widgets/loading_widget.dart';
import '../../../../shared/widgets/error_widget.dart';

class ItemDetailPage extends ConsumerStatefulWidget {
  final String itemId;

  const ItemDetailPage({super.key, required this.itemId});

  @override
  ConsumerState<ItemDetailPage> createState() => _ItemDetailPageState();
}

class _ItemDetailPageState extends ConsumerState<ItemDetailPage> {
  @override
  Widget build(BuildContext context) {
    final itemAsync = ref.watch(itemProvider(widget.itemId));

    return Scaffold(
      appBar: AppBar(title: const Text('분재 상세')),
      body: itemAsync.when(
        data: (item) {
          if (item == null) {
            return const Center(child: Text('분재를 찾을 수 없습니다.'));
          }
          return _buildItemDetail(item);
        },
        loading: () => const LoadingWidget(message: '분재 정보를 불러오는 중...'),
        error: (error, stack) => AppErrorWidget(
          message: error.toString(),
          onRetry: () => ref.invalidate(itemProvider(widget.itemId)),
        ),
      ),
    );
  }

  Widget _buildItemDetail(item) {
    final timeLeft = _getTimeLeft(item);
    final isEndingSoon = timeLeft.inHours < 2;

    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // 이미지 갤러리
          _buildImageGallery(item),

          // 기본 정보
          Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // 제목
                Text(
                  item.title,
                  style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 8),

                // 종류 정보
                Row(
                  children: [
                    Chip(label: Text(item.species)),
                    const SizedBox(width: 8),
                    Chip(label: Text(item.style)),
                    const SizedBox(width: 8),
                    Chip(label: Text(item.sizeClass)),
                  ],
                ),
                const SizedBox(height: 16),

                // 경매 정보
                Card(
                  child: Padding(
                    padding: const EdgeInsets.all(16),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          '경매 정보',
                          style: Theme.of(context).textTheme.titleMedium
                              ?.copyWith(fontWeight: FontWeight.bold),
                        ),
                        const SizedBox(height: 12),
                        _buildInfoRow(
                          '시작가',
                          '${NumberFormat('#,###').format(item.auction?.startPrice ?? 0)}원',
                        ),
                        _buildInfoRow(
                          '현재가',
                          '${NumberFormat('#,###').format(item.auction?.currentPrice ?? item.auction?.startPrice ?? 0)}원',
                        ),
                        if (item.auction?.buyNowPrice != null)
                          _buildInfoRow(
                            '즉시구매가',
                            '${NumberFormat('#,###').format(item.auction!.buyNowPrice!)}원',
                          ),
                        _buildInfoRow(
                          '입찰 단위',
                          '${NumberFormat('#,###').format(item.auction?.bidStep ?? 1000)}원',
                        ),
                        _buildInfoRow(
                          '입찰 수',
                          '${item.auction?.bidCount ?? 0}회',
                        ),
                        const SizedBox(height: 8),
                        Row(
                          children: [
                            Icon(
                              Icons.schedule,
                              size: 20,
                              color: isEndingSoon
                                  ? Colors.red
                                  : Colors.grey[600],
                            ),
                            const SizedBox(width: 8),
                            Text(
                              _formatTimeLeft(timeLeft),
                              style: Theme.of(context).textTheme.titleMedium
                                  ?.copyWith(
                                    color: isEndingSoon
                                        ? Colors.red
                                        : Colors.grey[600],
                                    fontWeight: isEndingSoon
                                        ? FontWeight.bold
                                        : FontWeight.normal,
                                  ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 16),

                // 분재 상세 정보
                Card(
                  child: Padding(
                    padding: const EdgeInsets.all(16),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          '분재 정보',
                          style: Theme.of(context).textTheme.titleMedium
                              ?.copyWith(fontWeight: FontWeight.bold),
                        ),
                        const SizedBox(height: 12),
                        _buildInfoRow('높이', '${item.heightCm}cm'),
                        _buildInfoRow('관폭', '${item.crownWidthCm}cm'),
                        _buildInfoRow('추정 수령', '${item.ageYearsEst}년'),
                        if (item.healthNotes != null) ...[
                          const SizedBox(height: 8),
                          Text(
                            '건강 상태',
                            style: Theme.of(context).textTheme.bodyMedium
                                ?.copyWith(fontWeight: FontWeight.bold),
                          ),
                          Text(item.healthNotes!),
                        ],
                        if (item.originNotes != null) ...[
                          const SizedBox(height: 8),
                          Text(
                            '출처',
                            style: Theme.of(context).textTheme.bodyMedium
                                ?.copyWith(fontWeight: FontWeight.bold),
                          ),
                          Text(item.originNotes!),
                        ],
                        if (item.careHistory != null) ...[
                          const SizedBox(height: 8),
                          Text(
                            '관리 이력',
                            style: Theme.of(context).textTheme.bodyMedium
                                ?.copyWith(fontWeight: FontWeight.bold),
                          ),
                          Text(item.careHistory!),
                        ],
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 16),

                // 입찰 버튼
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: () {
                      // TODO: 입찰 기능 구현
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text('입찰 기능은 준비 중입니다.')),
                      );
                    },
                    child: const Text('입찰하기'),
                  ),
                ),
                if (item.auction?.buyNowPrice != null) ...[
                  const SizedBox(height: 8),
                  SizedBox(
                    width: double.infinity,
                    child: OutlinedButton(
                      onPressed: () {
                        // TODO: 즉시구매 기능 구현
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(content: Text('즉시구매 기능은 준비 중입니다.')),
                        );
                      },
                      child: Text(
                        '즉시구매 (${NumberFormat('#,###').format(item.auction!.buyNowPrice!)}원)',
                      ),
                    ),
                  ),
                ],
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildImageGallery(item) {
    return SizedBox(
      height: 300,
      child: PageView.builder(
        itemCount: (item.media?.length ?? 0) + 1, // 커버 이미지 + 미디어
        itemBuilder: (context, index) {
          String imageUrl;
          if (index == 0) {
            imageUrl = item.coverImageUrl;
          } else {
            imageUrl = item.media[index - 1].url;
          }

          return CachedNetworkImage(
            imageUrl: imageUrl,
            fit: BoxFit.cover,
            placeholder: (context, url) => Container(
              color: Colors.grey[200],
              child: const Center(child: CircularProgressIndicator()),
            ),
            errorWidget: (context, url, error) => Container(
              color: Colors.grey[200],
              child: const Icon(
                Icons.image_not_supported,
                color: Colors.grey,
                size: 50,
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _buildInfoRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: 80,
            child: Text(
              label,
              style: Theme.of(
                context,
              ).textTheme.bodyMedium?.copyWith(color: Colors.grey[600]),
            ),
          ),
          Expanded(
            child: Text(value, style: Theme.of(context).textTheme.bodyMedium),
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
