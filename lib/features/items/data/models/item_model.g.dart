// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'item_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$ItemModelImpl _$$ItemModelImplFromJson(Map<String, dynamic> json) =>
    _$ItemModelImpl(
      id: json['id'] as String,
      sellerId: json['sellerId'] as String,
      title: json['title'] as String,
      species: json['species'] as String,
      style: json['style'] as String,
      sizeClass: json['sizeClass'] as String,
      heightCm: (json['heightCm'] as num).toDouble(),
      crownWidthCm: (json['crownWidthCm'] as num).toDouble(),
      ageYearsEst: (json['ageYearsEst'] as num).toInt(),
      healthNotes: json['healthNotes'] as String?,
      originNotes: json['originNotes'] as String?,
      careHistory: json['careHistory'] as String?,
      coverImageUrl: json['coverImageUrl'] as String,
      media:
          (json['media'] as List<dynamic>?)
              ?.map((e) => MediaItem.fromJson(e as Map<String, dynamic>))
              .toList() ??
          const [],
      status: $enumDecode(_$ItemStatusEnumMap, json['status']),
      auction: json['auction'] == null
          ? null
          : AuctionInfo.fromJson(json['auction'] as Map<String, dynamic>),
      shipping: json['shipping'] == null
          ? null
          : ShippingInfo.fromJson(json['shipping'] as Map<String, dynamic>),
      createdAt: const TimestampConverter().fromJson(
        json['createdAt'] as Timestamp,
      ),
      updatedAt: const TimestampConverter().fromJson(
        json['updatedAt'] as Timestamp,
      ),
      approvedBy: json['approvedBy'] as String?,
      approvedAt: _$JsonConverterFromJson<Timestamp, DateTime>(
        json['approvedAt'],
        const TimestampConverter().fromJson,
      ),
    );

Map<String, dynamic> _$$ItemModelImplToJson(_$ItemModelImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'sellerId': instance.sellerId,
      'title': instance.title,
      'species': instance.species,
      'style': instance.style,
      'sizeClass': instance.sizeClass,
      'heightCm': instance.heightCm,
      'crownWidthCm': instance.crownWidthCm,
      'ageYearsEst': instance.ageYearsEst,
      'healthNotes': instance.healthNotes,
      'originNotes': instance.originNotes,
      'careHistory': instance.careHistory,
      'coverImageUrl': instance.coverImageUrl,
      'media': instance.media,
      'status': _$ItemStatusEnumMap[instance.status]!,
      'auction': instance.auction,
      'shipping': instance.shipping,
      'createdAt': const TimestampConverter().toJson(instance.createdAt),
      'updatedAt': const TimestampConverter().toJson(instance.updatedAt),
      'approvedBy': instance.approvedBy,
      'approvedAt': _$JsonConverterToJson<Timestamp, DateTime>(
        instance.approvedAt,
        const TimestampConverter().toJson,
      ),
    };

const _$ItemStatusEnumMap = {
  ItemStatus.draft: 'DRAFT',
  ItemStatus.scheduled: 'SCHEDULED',
  ItemStatus.live: 'LIVE',
  ItemStatus.paused: 'PAUSED',
  ItemStatus.ended: 'ENDED',
  ItemStatus.settled: 'SETTLED',
  ItemStatus.canceled: 'CANCELED',
};

Value? _$JsonConverterFromJson<Json, Value>(
  Object? json,
  Value? Function(Json json) fromJson,
) => json == null ? null : fromJson(json as Json);

Json? _$JsonConverterToJson<Json, Value>(
  Value? value,
  Json? Function(Value value) toJson,
) => value == null ? null : toJson(value);

_$MediaItemImpl _$$MediaItemImplFromJson(Map<String, dynamic> json) =>
    _$MediaItemImpl(
      url: json['url'] as String,
      type: json['type'] as String,
      sort: (json['sort'] as num).toInt(),
    );

Map<String, dynamic> _$$MediaItemImplToJson(_$MediaItemImpl instance) =>
    <String, dynamic>{
      'url': instance.url,
      'type': instance.type,
      'sort': instance.sort,
    };

_$AuctionInfoImpl _$$AuctionInfoImplFromJson(Map<String, dynamic> json) =>
    _$AuctionInfoImpl(
      startPrice: (json['startPrice'] as num).toInt(),
      bidStep: (json['bidStep'] as num).toInt(),
      reservePrice: (json['reservePrice'] as num?)?.toInt(),
      buyNowPrice: (json['buyNowPrice'] as num?)?.toInt(),
      startsAt: const TimestampConverter().fromJson(
        json['startsAt'] as Timestamp,
      ),
      endsAt: const TimestampConverter().fromJson(json['endsAt'] as Timestamp),
      autoExtendMinutes: (json['autoExtendMinutes'] as num?)?.toInt() ?? 2,
      currentPrice: (json['currentPrice'] as num?)?.toInt() ?? 0,
      currentBidId: json['currentBidId'] as String?,
      currentBidderId: json['currentBidderId'] as String?,
      bidCount: (json['bidCount'] as num?)?.toInt() ?? 0,
    );

Map<String, dynamic> _$$AuctionInfoImplToJson(_$AuctionInfoImpl instance) =>
    <String, dynamic>{
      'startPrice': instance.startPrice,
      'bidStep': instance.bidStep,
      'reservePrice': instance.reservePrice,
      'buyNowPrice': instance.buyNowPrice,
      'startsAt': const TimestampConverter().toJson(instance.startsAt),
      'endsAt': const TimestampConverter().toJson(instance.endsAt),
      'autoExtendMinutes': instance.autoExtendMinutes,
      'currentPrice': instance.currentPrice,
      'currentBidId': instance.currentBidId,
      'currentBidderId': instance.currentBidderId,
      'bidCount': instance.bidCount,
    };

_$ShippingInfoImpl _$$ShippingInfoImplFromJson(Map<String, dynamic> json) =>
    _$ShippingInfoImpl(
      method: $enumDecode(_$ShippingMethodEnumMap, json['method']),
      feePolicy: json['feePolicy'] as String,
    );

Map<String, dynamic> _$$ShippingInfoImplToJson(_$ShippingInfoImpl instance) =>
    <String, dynamic>{
      'method': _$ShippingMethodEnumMap[instance.method]!,
      'feePolicy': instance.feePolicy,
    };

const _$ShippingMethodEnumMap = {
  ShippingMethod.pickup: 'PICKUP',
  ShippingMethod.courier: 'COURIER',
  ShippingMethod.freight: 'FREIGHT',
};
