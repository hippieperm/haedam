import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

part 'bid_model.freezed.dart';
part 'bid_model.g.dart';

@freezed
class BidModel with _$BidModel {
  const factory BidModel({
    required String id,
    required String bidderId,
    required int amount,
    @Default(false) bool isProxy,
    int? maxProxyAmount,
    @TimestampConverter() required DateTime createdAt,
  }) = _BidModel;

  factory BidModel.fromJson(Map<String, dynamic> json) =>
      _$BidModelFromJson(json);
}

class TimestampConverter implements JsonConverter<DateTime, Timestamp> {
  const TimestampConverter();

  @override
  DateTime fromJson(Timestamp timestamp) => timestamp.toDate();

  @override
  Timestamp toJson(DateTime date) => Timestamp.fromDate(date);
}
