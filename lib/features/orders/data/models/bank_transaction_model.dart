import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

part 'bank_transaction_model.freezed.dart';
part 'bank_transaction_model.g.dart';

@freezed
class BankTransactionModel with _$BankTransactionModel {
  const factory BankTransactionModel({
    required String id,
    required String bank,
    required String accountNo,
    required int amount,
    required String depositorName,
    required String memo,
    @TimestampConverter() required DateTime txTime,
    required MatchStatus matchStatus,
    String? matchedOrderId,
  }) = _BankTransactionModel;

  factory BankTransactionModel.fromJson(Map<String, dynamic> json) =>
      _$BankTransactionModelFromJson(json);
}

enum MatchStatus {
  @JsonValue('UNMATCHED')
  unmatched,
  @JsonValue('AUTO_MATCHED')
  autoMatched,
  @JsonValue('MANUAL_MATCHED')
  manualMatched,
  @JsonValue('SUSPECT')
  suspect,
}

class TimestampConverter implements JsonConverter<DateTime, Timestamp> {
  const TimestampConverter();

  @override
  DateTime fromJson(Timestamp timestamp) => timestamp.toDate();

  @override
  Timestamp toJson(DateTime date) => Timestamp.fromDate(date);
}
