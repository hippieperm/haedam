// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'order_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$OrderModelImpl _$$OrderModelImplFromJson(Map<String, dynamic> json) =>
    _$OrderModelImpl(
      id: json['id'] as String,
      itemId: json['itemId'] as String,
      buyerId: json['buyerId'] as String,
      finalPrice: (json['finalPrice'] as num).toInt(),
      buyerPremium: (json['buyerPremium'] as num).toInt(),
      sellerFee: (json['sellerFee'] as num).toInt(),
      vat: (json['vat'] as num).toInt(),
      paymentMethod: $enumDecode(_$PaymentMethodEnumMap, json['paymentMethod']),
      paymentStatus: $enumDecode(_$PaymentStatusEnumMap, json['paymentStatus']),
      depositAmount: (json['depositAmount'] as num).toInt(),
      depositCode: json['depositCode'] as String,
      depositDeadline: const TimestampConverter().fromJson(
        json['depositDeadline'] as Timestamp,
      ),
      depositorNameInput: json['depositorNameInput'] as String?,
      receiptUrl: json['receiptUrl'] as String?,
      createdAt: const TimestampConverter().fromJson(
        json['createdAt'] as Timestamp,
      ),
      updatedAt: const TimestampConverter().fromJson(
        json['updatedAt'] as Timestamp,
      ),
      settledAt: _$JsonConverterFromJson<Timestamp, DateTime>(
        json['settledAt'],
        const TimestampConverter().fromJson,
      ),
    );

Map<String, dynamic> _$$OrderModelImplToJson(_$OrderModelImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'itemId': instance.itemId,
      'buyerId': instance.buyerId,
      'finalPrice': instance.finalPrice,
      'buyerPremium': instance.buyerPremium,
      'sellerFee': instance.sellerFee,
      'vat': instance.vat,
      'paymentMethod': _$PaymentMethodEnumMap[instance.paymentMethod]!,
      'paymentStatus': _$PaymentStatusEnumMap[instance.paymentStatus]!,
      'depositAmount': instance.depositAmount,
      'depositCode': instance.depositCode,
      'depositDeadline': const TimestampConverter().toJson(
        instance.depositDeadline,
      ),
      'depositorNameInput': instance.depositorNameInput,
      'receiptUrl': instance.receiptUrl,
      'createdAt': const TimestampConverter().toJson(instance.createdAt),
      'updatedAt': const TimestampConverter().toJson(instance.updatedAt),
      'settledAt': _$JsonConverterToJson<Timestamp, DateTime>(
        instance.settledAt,
        const TimestampConverter().toJson,
      ),
    };

const _$PaymentMethodEnumMap = {PaymentMethod.bankTransfer: 'BANK_TRANSFER'};

const _$PaymentStatusEnumMap = {
  PaymentStatus.pendingPayment: 'PENDING_PAYMENT',
  PaymentStatus.paid: 'PAID',
  PaymentStatus.suspect: 'SUSPECT',
  PaymentStatus.expired: 'EXPIRED',
  PaymentStatus.refunded: 'REFUNDED',
};

Value? _$JsonConverterFromJson<Json, Value>(
  Object? json,
  Value? Function(Json json) fromJson,
) => json == null ? null : fromJson(json as Json);

Json? _$JsonConverterToJson<Json, Value>(
  Value? value,
  Json? Function(Value value) toJson,
) => value == null ? null : toJson(value);
