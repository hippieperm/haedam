// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'bank_transaction_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$BankTransactionModelImpl _$$BankTransactionModelImplFromJson(
  Map<String, dynamic> json,
) => _$BankTransactionModelImpl(
  id: json['id'] as String,
  bank: json['bank'] as String,
  accountNo: json['accountNo'] as String,
  amount: (json['amount'] as num).toInt(),
  depositorName: json['depositorName'] as String,
  memo: json['memo'] as String,
  txTime: const TimestampConverter().fromJson(json['txTime'] as Timestamp),
  matchStatus: $enumDecode(_$MatchStatusEnumMap, json['matchStatus']),
  matchedOrderId: json['matchedOrderId'] as String?,
);

Map<String, dynamic> _$$BankTransactionModelImplToJson(
  _$BankTransactionModelImpl instance,
) => <String, dynamic>{
  'id': instance.id,
  'bank': instance.bank,
  'accountNo': instance.accountNo,
  'amount': instance.amount,
  'depositorName': instance.depositorName,
  'memo': instance.memo,
  'txTime': const TimestampConverter().toJson(instance.txTime),
  'matchStatus': _$MatchStatusEnumMap[instance.matchStatus]!,
  'matchedOrderId': instance.matchedOrderId,
};

const _$MatchStatusEnumMap = {
  MatchStatus.unmatched: 'UNMATCHED',
  MatchStatus.autoMatched: 'AUTO_MATCHED',
  MatchStatus.manualMatched: 'MANUAL_MATCHED',
  MatchStatus.suspect: 'SUSPECT',
};
