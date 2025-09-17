// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'bank_transaction_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
  'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models',
);

BankTransactionModel _$BankTransactionModelFromJson(Map<String, dynamic> json) {
  return _BankTransactionModel.fromJson(json);
}

/// @nodoc
mixin _$BankTransactionModel {
  String get id => throw _privateConstructorUsedError;
  String get bank => throw _privateConstructorUsedError;
  String get accountNo => throw _privateConstructorUsedError;
  int get amount => throw _privateConstructorUsedError;
  String get depositorName => throw _privateConstructorUsedError;
  String get memo => throw _privateConstructorUsedError;
  @TimestampConverter()
  DateTime get txTime => throw _privateConstructorUsedError;
  MatchStatus get matchStatus => throw _privateConstructorUsedError;
  String? get matchedOrderId => throw _privateConstructorUsedError;

  /// Serializes this BankTransactionModel to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of BankTransactionModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $BankTransactionModelCopyWith<BankTransactionModel> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $BankTransactionModelCopyWith<$Res> {
  factory $BankTransactionModelCopyWith(
    BankTransactionModel value,
    $Res Function(BankTransactionModel) then,
  ) = _$BankTransactionModelCopyWithImpl<$Res, BankTransactionModel>;
  @useResult
  $Res call({
    String id,
    String bank,
    String accountNo,
    int amount,
    String depositorName,
    String memo,
    @TimestampConverter() DateTime txTime,
    MatchStatus matchStatus,
    String? matchedOrderId,
  });
}

/// @nodoc
class _$BankTransactionModelCopyWithImpl<
  $Res,
  $Val extends BankTransactionModel
>
    implements $BankTransactionModelCopyWith<$Res> {
  _$BankTransactionModelCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of BankTransactionModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? bank = null,
    Object? accountNo = null,
    Object? amount = null,
    Object? depositorName = null,
    Object? memo = null,
    Object? txTime = null,
    Object? matchStatus = null,
    Object? matchedOrderId = freezed,
  }) {
    return _then(
      _value.copyWith(
            id: null == id
                ? _value.id
                : id // ignore: cast_nullable_to_non_nullable
                      as String,
            bank: null == bank
                ? _value.bank
                : bank // ignore: cast_nullable_to_non_nullable
                      as String,
            accountNo: null == accountNo
                ? _value.accountNo
                : accountNo // ignore: cast_nullable_to_non_nullable
                      as String,
            amount: null == amount
                ? _value.amount
                : amount // ignore: cast_nullable_to_non_nullable
                      as int,
            depositorName: null == depositorName
                ? _value.depositorName
                : depositorName // ignore: cast_nullable_to_non_nullable
                      as String,
            memo: null == memo
                ? _value.memo
                : memo // ignore: cast_nullable_to_non_nullable
                      as String,
            txTime: null == txTime
                ? _value.txTime
                : txTime // ignore: cast_nullable_to_non_nullable
                      as DateTime,
            matchStatus: null == matchStatus
                ? _value.matchStatus
                : matchStatus // ignore: cast_nullable_to_non_nullable
                      as MatchStatus,
            matchedOrderId: freezed == matchedOrderId
                ? _value.matchedOrderId
                : matchedOrderId // ignore: cast_nullable_to_non_nullable
                      as String?,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$BankTransactionModelImplCopyWith<$Res>
    implements $BankTransactionModelCopyWith<$Res> {
  factory _$$BankTransactionModelImplCopyWith(
    _$BankTransactionModelImpl value,
    $Res Function(_$BankTransactionModelImpl) then,
  ) = __$$BankTransactionModelImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    String id,
    String bank,
    String accountNo,
    int amount,
    String depositorName,
    String memo,
    @TimestampConverter() DateTime txTime,
    MatchStatus matchStatus,
    String? matchedOrderId,
  });
}

/// @nodoc
class __$$BankTransactionModelImplCopyWithImpl<$Res>
    extends _$BankTransactionModelCopyWithImpl<$Res, _$BankTransactionModelImpl>
    implements _$$BankTransactionModelImplCopyWith<$Res> {
  __$$BankTransactionModelImplCopyWithImpl(
    _$BankTransactionModelImpl _value,
    $Res Function(_$BankTransactionModelImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of BankTransactionModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? bank = null,
    Object? accountNo = null,
    Object? amount = null,
    Object? depositorName = null,
    Object? memo = null,
    Object? txTime = null,
    Object? matchStatus = null,
    Object? matchedOrderId = freezed,
  }) {
    return _then(
      _$BankTransactionModelImpl(
        id: null == id
            ? _value.id
            : id // ignore: cast_nullable_to_non_nullable
                  as String,
        bank: null == bank
            ? _value.bank
            : bank // ignore: cast_nullable_to_non_nullable
                  as String,
        accountNo: null == accountNo
            ? _value.accountNo
            : accountNo // ignore: cast_nullable_to_non_nullable
                  as String,
        amount: null == amount
            ? _value.amount
            : amount // ignore: cast_nullable_to_non_nullable
                  as int,
        depositorName: null == depositorName
            ? _value.depositorName
            : depositorName // ignore: cast_nullable_to_non_nullable
                  as String,
        memo: null == memo
            ? _value.memo
            : memo // ignore: cast_nullable_to_non_nullable
                  as String,
        txTime: null == txTime
            ? _value.txTime
            : txTime // ignore: cast_nullable_to_non_nullable
                  as DateTime,
        matchStatus: null == matchStatus
            ? _value.matchStatus
            : matchStatus // ignore: cast_nullable_to_non_nullable
                  as MatchStatus,
        matchedOrderId: freezed == matchedOrderId
            ? _value.matchedOrderId
            : matchedOrderId // ignore: cast_nullable_to_non_nullable
                  as String?,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$BankTransactionModelImpl implements _BankTransactionModel {
  const _$BankTransactionModelImpl({
    required this.id,
    required this.bank,
    required this.accountNo,
    required this.amount,
    required this.depositorName,
    required this.memo,
    @TimestampConverter() required this.txTime,
    required this.matchStatus,
    this.matchedOrderId,
  });

  factory _$BankTransactionModelImpl.fromJson(Map<String, dynamic> json) =>
      _$$BankTransactionModelImplFromJson(json);

  @override
  final String id;
  @override
  final String bank;
  @override
  final String accountNo;
  @override
  final int amount;
  @override
  final String depositorName;
  @override
  final String memo;
  @override
  @TimestampConverter()
  final DateTime txTime;
  @override
  final MatchStatus matchStatus;
  @override
  final String? matchedOrderId;

  @override
  String toString() {
    return 'BankTransactionModel(id: $id, bank: $bank, accountNo: $accountNo, amount: $amount, depositorName: $depositorName, memo: $memo, txTime: $txTime, matchStatus: $matchStatus, matchedOrderId: $matchedOrderId)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$BankTransactionModelImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.bank, bank) || other.bank == bank) &&
            (identical(other.accountNo, accountNo) ||
                other.accountNo == accountNo) &&
            (identical(other.amount, amount) || other.amount == amount) &&
            (identical(other.depositorName, depositorName) ||
                other.depositorName == depositorName) &&
            (identical(other.memo, memo) || other.memo == memo) &&
            (identical(other.txTime, txTime) || other.txTime == txTime) &&
            (identical(other.matchStatus, matchStatus) ||
                other.matchStatus == matchStatus) &&
            (identical(other.matchedOrderId, matchedOrderId) ||
                other.matchedOrderId == matchedOrderId));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
    runtimeType,
    id,
    bank,
    accountNo,
    amount,
    depositorName,
    memo,
    txTime,
    matchStatus,
    matchedOrderId,
  );

  /// Create a copy of BankTransactionModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$BankTransactionModelImplCopyWith<_$BankTransactionModelImpl>
  get copyWith =>
      __$$BankTransactionModelImplCopyWithImpl<_$BankTransactionModelImpl>(
        this,
        _$identity,
      );

  @override
  Map<String, dynamic> toJson() {
    return _$$BankTransactionModelImplToJson(this);
  }
}

abstract class _BankTransactionModel implements BankTransactionModel {
  const factory _BankTransactionModel({
    required final String id,
    required final String bank,
    required final String accountNo,
    required final int amount,
    required final String depositorName,
    required final String memo,
    @TimestampConverter() required final DateTime txTime,
    required final MatchStatus matchStatus,
    final String? matchedOrderId,
  }) = _$BankTransactionModelImpl;

  factory _BankTransactionModel.fromJson(Map<String, dynamic> json) =
      _$BankTransactionModelImpl.fromJson;

  @override
  String get id;
  @override
  String get bank;
  @override
  String get accountNo;
  @override
  int get amount;
  @override
  String get depositorName;
  @override
  String get memo;
  @override
  @TimestampConverter()
  DateTime get txTime;
  @override
  MatchStatus get matchStatus;
  @override
  String? get matchedOrderId;

  /// Create a copy of BankTransactionModel
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$BankTransactionModelImplCopyWith<_$BankTransactionModelImpl>
  get copyWith => throw _privateConstructorUsedError;
}
