import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

part 'order_model.freezed.dart';
part 'order_model.g.dart';

@freezed
class OrderModel with _$OrderModel {
  const factory OrderModel({
    required String id,
    required String itemId,
    required String buyerId,
    required int finalPrice,
    required int buyerPremium,
    required int sellerFee,
    required int vat,
    required PaymentMethod paymentMethod,
    required PaymentStatus paymentStatus,
    required int depositAmount,
    required String depositCode,
    @TimestampConverter() required DateTime depositDeadline,
    String? depositorNameInput,
    String? receiptUrl,
    @TimestampConverter() required DateTime createdAt,
    @TimestampConverter() required DateTime updatedAt,
    @TimestampConverter() DateTime? settledAt,
  }) = _OrderModel;

  factory OrderModel.fromJson(Map<String, dynamic> json) =>
      _$OrderModelFromJson(json);
}

enum PaymentMethod {
  @JsonValue('BANK_TRANSFER')
  bankTransfer,
}

enum PaymentStatus {
  @JsonValue('PENDING_PAYMENT')
  pendingPayment,
  @JsonValue('PAID')
  paid,
  @JsonValue('SUSPECT')
  suspect,
  @JsonValue('EXPIRED')
  expired,
  @JsonValue('REFUNDED')
  refunded,
}

class TimestampConverter implements JsonConverter<DateTime, Timestamp> {
  const TimestampConverter();

  @override
  DateTime fromJson(Timestamp timestamp) => timestamp.toDate();

  @override
  Timestamp toJson(DateTime date) => Timestamp.fromDate(date);
}
