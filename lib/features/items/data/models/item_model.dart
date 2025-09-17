import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

part 'item_model.freezed.dart';
part 'item_model.g.dart';

@freezed
class ItemModel with _$ItemModel {
  const factory ItemModel({
    required String id,
    required String sellerId,
    required String title,
    required String species,
    required String style,
    required String sizeClass,
    required double heightCm,
    required double crownWidthCm,
    required int ageYearsEst,
    String? healthNotes,
    String? originNotes,
    String? careHistory,
    required String coverImageUrl,
    @Default([]) List<MediaItem> media,
    required ItemStatus status,
    AuctionInfo? auction,
    ShippingInfo? shipping,
    @TimestampConverter() required DateTime createdAt,
    @TimestampConverter() required DateTime updatedAt,
    String? approvedBy,
    @TimestampConverter() DateTime? approvedAt,
  }) = _ItemModel;

  factory ItemModel.fromJson(Map<String, dynamic> json) =>
      _$ItemModelFromJson(json);
}

@freezed
class MediaItem with _$MediaItem {
  const factory MediaItem({
    required String url,
    required String type,
    required int sort,
  }) = _MediaItem;

  factory MediaItem.fromJson(Map<String, dynamic> json) =>
      _$MediaItemFromJson(json);
}

@freezed
class AuctionInfo with _$AuctionInfo {
  const factory AuctionInfo({
    required int startPrice,
    required int bidStep,
    int? reservePrice,
    int? buyNowPrice,
    @TimestampConverter() required DateTime startsAt,
    @TimestampConverter() required DateTime endsAt,
    @Default(2) int autoExtendMinutes,
    @Default(0) int currentPrice,
    String? currentBidId,
    String? currentBidderId,
    @Default(0) int bidCount,
  }) = _AuctionInfo;

  factory AuctionInfo.fromJson(Map<String, dynamic> json) =>
      _$AuctionInfoFromJson(json);
}

@freezed
class ShippingInfo with _$ShippingInfo {
  const factory ShippingInfo({
    required ShippingMethod method,
    required String feePolicy,
  }) = _ShippingInfo;

  factory ShippingInfo.fromJson(Map<String, dynamic> json) =>
      _$ShippingInfoFromJson(json);
}

enum ItemStatus {
  @JsonValue('DRAFT')
  draft,
  @JsonValue('SCHEDULED')
  scheduled,
  @JsonValue('LIVE')
  live,
  @JsonValue('PAUSED')
  paused,
  @JsonValue('ENDED')
  ended,
  @JsonValue('SETTLED')
  settled,
  @JsonValue('CANCELED')
  canceled,
}

enum ShippingMethod {
  @JsonValue('PICKUP')
  pickup,
  @JsonValue('COURIER')
  courier,
  @JsonValue('FREIGHT')
  freight,
}

class TimestampConverter implements JsonConverter<DateTime, Timestamp> {
  const TimestampConverter();

  @override
  DateTime fromJson(Timestamp timestamp) => timestamp.toDate();

  @override
  Timestamp toJson(DateTime date) => Timestamp.fromDate(date);
}
