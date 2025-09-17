import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:intl/intl.dart';
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
                  CachedNetworkImage(
                    imageUrl: item.coverImageUrl,
                    fit: BoxFit.cover,
                    width: double.infinity,
                    placeholder: (context, url) => Container(
                      color: Colors.grey[100],
                      child: Center(
                        child: CircularProgressIndicator(
                          strokeWidth: 2,
                          valueColor: AlwaysStoppedAnimation<Color>(
                            Theme.of(context).primaryColor,
                          ),
                        ),
                      ),
                    ),
                    errorWidget: (context, url, error) => Container(
                      color: Colors.grey[100],
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            Icons.local_florist,
                            size: isDesktop ? 48 : 32,
                            color: Colors.grey[400],
                          ),
                          const SizedBox(height: 8),
                          Text(
                            '이미지 없음',
                            style: TextStyle(
                              color: Colors.grey[500],
                              fontSize: isDesktop ? 14 : 12,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
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
                  // 가격 오버레이
                  Positioned(
                    bottom: 8,
                    left: 8,
                    right: 8,
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 12,
                        vertical: 6,
                      ),
                      decoration: BoxDecoration(
                        color: Colors.black.withOpacity(0.7),
                        borderRadius: BorderRadius.circular(8),
                      ),
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
                ],
              ),
            ),
            // 정보
            Expanded(
              flex: 2,
              child: Padding(
                padding: EdgeInsets.all(isDesktop ? 16 : 8),
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
                          color: Colors.grey[800],
                        ),
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                    const SizedBox(height: 4),
                    // 종류와 크기
                    Row(
                      children: [
                        Flexible(
                          child: Container(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 6,
                              vertical: 2,
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
                              color: Colors.grey[600],
                            ),
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 4),
                    // 크기 정보
                    Text(
                      '${item.heightCm.toInt()}cm • ${item.crownWidthCm.toInt()}cm',
                      style: TextStyle(
                        fontSize: isDesktop ? 12 : 9,
                        color: Colors.grey[500],
                      ),
                      overflow: TextOverflow.ellipsis,
                    ),
                    const Spacer(),
                    // 남은 시간
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 6,
                        vertical: 3,
                      ),
                      decoration: BoxDecoration(
                        color: isEndingSoon
                            ? Colors.red.shade50
                            : Colors.grey.shade50,
                        borderRadius: BorderRadius.circular(6),
                        border: Border.all(
                          color: isEndingSoon
                              ? Colors.red.shade200
                              : Colors.grey.shade200,
                          width: 1,
                        ),
                      ),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Icon(
                            Icons.schedule,
                            size: isDesktop ? 14 : 12,
                            color: isEndingSoon ? Colors.red : Colors.grey[600],
                          ),
                          const SizedBox(width: 3),
                          Flexible(
                            child: Text(
                              _formatTimeLeft(timeLeft),
                              style: TextStyle(
                                fontSize: isDesktop ? 12 : 9,
                                color: isEndingSoon
                                    ? Colors.red
                                    : Colors.grey[600],
                                fontWeight: isEndingSoon
                                    ? FontWeight.bold
                                    : FontWeight.normal,
                              ),
                              overflow: TextOverflow.ellipsis,
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
