// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'bid_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$BidModelImpl _$$BidModelImplFromJson(Map<String, dynamic> json) =>
    _$BidModelImpl(
      id: json['id'] as String,
      bidderId: json['bidderId'] as String,
      amount: (json['amount'] as num).toInt(),
      isProxy: json['isProxy'] as bool? ?? false,
      maxProxyAmount: (json['maxProxyAmount'] as num?)?.toInt(),
      createdAt: const TimestampConverter().fromJson(
        json['createdAt'] as Timestamp,
      ),
    );

Map<String, dynamic> _$$BidModelImplToJson(_$BidModelImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'bidderId': instance.bidderId,
      'amount': instance.amount,
      'isProxy': instance.isProxy,
      'maxProxyAmount': instance.maxProxyAmount,
      'createdAt': const TimestampConverter().toJson(instance.createdAt),
    };
