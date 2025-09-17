import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:intl/intl.dart';
import 'dart:convert';
import '../../data/models/item_model.dart';

class ItemCard extends StatelessWidget {
  final ItemModel item;
  final VoidCallback? onTap;

  const ItemCard({super.key, required this.item, this.onTap});

  @override
  Widget build(BuildContext context) {
    final timeLeft = _getTimeLeft();
    final isEndingSoon = timeLeft.inHours < 2;
    final screenWidth = MediaQuery.of(context).size.width;
    final isDesktop = screenWidth > 1200;

    return Card(
      elevation: 2,
      clipBehavior: Clip.antiAlias,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // 이미지
            Expanded(
              flex: 3,
              child: Stack(
                children: [
                  _buildImageWidget(context),
                  // 마감 임박 배지
                  if (isEndingSoon)
                    Positioned(
                      top: 8,
                      right: 8,
                      child: Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 8,
                          vertical: 4,
                        ),
                        decoration: BoxDecoration(
                          color: Colors.red,
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Text(
                          '마감임박',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: isDesktop ? 12 : 10,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                ],
              ),
            ),
            // 가격 표시 (이미지 아래로 이동)
            Container(
              width: double.infinity,
              height: 50,
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
              decoration: BoxDecoration(
                color: Theme.of(context).primaryColor,
                borderRadius: const BorderRadius.only(
                  bottomLeft: Radius.circular(12),
                  bottomRight: Radius.circular(12),
                ),
              ),
              child: FittedBox(
                child: Text(
                  '${NumberFormat('#,###').format(item.auction?.currentPrice ?? item.auction?.startPrice ?? 0)}원',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: isDesktop ? 16 : 14,
                    fontWeight: FontWeight.bold,
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
            ),
            // 정보
            Expanded(
              flex: 1,
              child: Padding(
                padding: EdgeInsets.all(isDesktop ? 12 : 6),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    // 제목
                    Flexible(
                      child: Text(
                        item.title,
                        style: TextStyle(
                          fontSize: isDesktop ? 16 : 12,
                          fontWeight: FontWeight.bold,
                          color: Theme.of(context).colorScheme.onSurface,
                        ),
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                    const SizedBox(height: 2),
                    // 종류와 크기
                    Row(
                      children: [
                        Flexible(
                          child: Container(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 4,
                              vertical: 1,
                            ),
                            decoration: BoxDecoration(
                              color: Theme.of(
                                context,
                              ).primaryColor.withOpacity(0.1),
                              borderRadius: BorderRadius.circular(8),
                            ),
                            child: Text(
                              item.species,
                              style: TextStyle(
                                fontSize: isDesktop ? 12 : 9,
                                color: Theme.of(context).primaryColor,
                                fontWeight: FontWeight.w600,
                              ),
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                        ),
                        const SizedBox(width: 4),
                        Flexible(
                          child: Text(
                            item.style,
                            style: TextStyle(
                              fontSize: isDesktop ? 12 : 9,
                              color: Theme.of(
                                context,
                              ).colorScheme.onSurface.withOpacity(0.7),
                            ),
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 2),
                    // 크기 정보
                    FittedBox(
                      child: Text(
                        '${item.heightCm.toInt()}cm • ${item.crownWidthCm.toInt()}cm',
                        style: TextStyle(
                          fontSize: isDesktop ? 12 : 9,
                          color: Theme.of(
                            context,
                          ).colorScheme.onSurface.withOpacity(0.6),
                        ),
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                    const Spacer(),
                    // 남은 시간
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 4,
                        vertical: 2,
                      ),
                      decoration: BoxDecoration(
                        color: isEndingSoon
                            ? Colors.red.withOpacity(0.1)
                            : Theme.of(context).colorScheme.surface,
                        borderRadius: BorderRadius.circular(6),
                        border: Border.all(
                          color: isEndingSoon
                              ? Colors.red.withOpacity(0.3)
                              : Theme.of(
                                  context,
                                ).colorScheme.outline.withOpacity(0.3),
                          width: 1,
                        ),
                      ),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Icon(
                            Icons.schedule,
                            size: isDesktop ? 14 : 12,
                            color: isEndingSoon
                                ? Colors.red
                                : Theme.of(
                                    context,
                                  ).colorScheme.onSurface.withOpacity(0.6),
                          ),
                          const SizedBox(width: 3),
                          Flexible(
                            child: FittedBox(
                              child: Text(
                                _formatTimeLeft(timeLeft),
                                style: TextStyle(
                                  fontSize: isDesktop ? 12 : 9,
                                  color: isEndingSoon
                                      ? Colors.red
                                      : Theme.of(context).colorScheme.onSurface
                                            .withOpacity(0.6),
                                  fontWeight: isEndingSoon
                                      ? FontWeight.bold
                                      : FontWeight.normal,
                                ),
                                overflow: TextOverflow.ellipsis,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildImageWidget(BuildContext context) {
    // 이미지 URL이 비어있는 경우
    if (item.coverImageUrl.isEmpty) {
      return _buildErrorWidget(context);
    }

    // Base64 이미지인지 확인 (data:image로 시작하는지 체크)
    if (item.coverImageUrl.startsWith('data:image/') ||
        (item.coverImageUrl.isNotEmpty &&
            !item.coverImageUrl.startsWith('http'))) {
      // Base64 이미지 처리
      try {
        String base64String = item.coverImageUrl;
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
          fit: BoxFit.cover,
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
        imageUrl: item.coverImageUrl,
        fit: BoxFit.cover,
        width: double.infinity,
        height: double.infinity,
        placeholder: (context, url) => Container(
          color: Theme.of(context).colorScheme.surface,
          child: Center(
            child: CircularProgressIndicator(
              strokeWidth: 2,
              valueColor: AlwaysStoppedAnimation<Color>(
                Theme.of(context).primaryColor,
              ),
            ),
          ),
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
      color: Theme.of(context).colorScheme.surface,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.local_florist,
            size: 32,
            color: Theme.of(context).colorScheme.onSurface.withOpacity(0.4),
          ),
          const SizedBox(height: 8),
          Text(
            '이미지 없음',
            style: TextStyle(
              color: Theme.of(context).colorScheme.onSurface.withOpacity(0.6),
              fontSize: 12,
            ),
          ),
        ],
      ),
    );
  }

  Duration _getTimeLeft() {
    final endsAt = item.auction?.endsAt;
    if (endsAt == null) return Duration.zero;

    final now = DateTime.now();
    final difference = endsAt.difference(now);
    return difference.isNegative ? Duration.zero : difference;
  }

  String _formatTimeLeft(Duration duration) {
    if (duration.inDays > 0) {
      return '${duration.inDays}일 ${duration.inHours % 24}시간';
    } else if (duration.inHours > 0) {
      return '${duration.inHours}시간 ${duration.inMinutes % 60}분';
    } else if (duration.inMinutes > 0) {
      return '${duration.inMinutes}분';
    } else {
      return '마감';
    }
  }
}
