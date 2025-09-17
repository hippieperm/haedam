// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'bid_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
  'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models',
);

BidModel _$BidModelFromJson(Map<String, dynamic> json) {
  return _BidModel.fromJson(json);
}

/// @nodoc
mixin _$BidModel {
  String get id => throw _privateConstructorUsedError;
  String get bidderId => throw _privateConstructorUsedError;
  int get amount => throw _privateConstructorUsedError;
  bool get isProxy => throw _privateConstructorUsedError;
  int? get maxProxyAmount => throw _privateConstructorUsedError;
  @TimestampConverter()
  DateTime get createdAt => throw _privateConstructorUsedError;

  /// Serializes this BidModel to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of BidModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $BidModelCopyWith<BidModel> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $BidModelCopyWith<$Res> {
  factory $BidModelCopyWith(BidModel value, $Res Function(BidModel) then) =
      _$BidModelCopyWithImpl<$Res, BidModel>;
  @useResult
  $Res call({
    String id,
    String bidderId,
    int amount,
    bool isProxy,
    int? maxProxyAmount,
    @TimestampConverter() DateTime createdAt,
  });
}

/// @nodoc
class _$BidModelCopyWithImpl<$Res, $Val extends BidModel>
    implements $BidModelCopyWith<$Res> {
  _$BidModelCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of BidModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? bidderId = null,
    Object? amount = null,
    Object? isProxy = null,
    Object? maxProxyAmount = freezed,
    Object? createdAt = null,
  }) {
    return _then(
      _value.copyWith(
            id: null == id
                ? _value.id
                : id // ignore: cast_nullable_to_non_nullable
                      as String,
            bidderId: null == bidderId
                ? _value.bidderId
                : bidderId // ignore: cast_nullable_to_non_nullable
                      as String,
            amount: null == amount
                ? _value.amount
                : amount // ignore: cast_nullable_to_non_nullable
                      as int,
            isProxy: null == isProxy
                ? _value.isProxy
                : isProxy // ignore: cast_nullable_to_non_nullable
                      as bool,
            maxProxyAmount: freezed == maxProxyAmount
                ? _value.maxProxyAmount
                : maxProxyAmount // ignore: cast_nullable_to_non_nullable
                      as int?,
            createdAt: null == createdAt
                ? _value.createdAt
                : createdAt // ignore: cast_nullable_to_non_nullable
                      as DateTime,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$BidModelImplCopyWith<$Res>
    implements $BidModelCopyWith<$Res> {
  factory _$$BidModelImplCopyWith(
    _$BidModelImpl value,
    $Res Function(_$BidModelImpl) then,
  ) = __$$BidModelImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    String id,
    String bidderId,
    int amount,
    bool isProxy,
    int? maxProxyAmount,
    @TimestampConverter() DateTime createdAt,
  });
}

/// @nodoc
class __$$BidModelImplCopyWithImpl<$Res>
    extends _$BidModelCopyWithImpl<$Res, _$BidModelImpl>
    implements _$$BidModelImplCopyWith<$Res> {
  __$$BidModelImplCopyWithImpl(
    _$BidModelImpl _value,
    $Res Function(_$BidModelImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of BidModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? bidderId = null,
    Object? amount = null,
    Object? isProxy = null,
    Object? maxProxyAmount = freezed,
    Object? createdAt = null,
  }) {
    return _then(
      _$BidModelImpl(
        id: null == id
            ? _value.id
            : id // ignore: cast_nullable_to_non_nullable
                  as String,
        bidderId: null == bidderId
            ? _value.bidderId
            : bidderId // ignore: cast_nullable_to_non_nullable
                  as String,
        amount: null == amount
            ? _value.amount
            : amount // ignore: cast_nullable_to_non_nullable
                  as int,
        isProxy: null == isProxy
            ? _value.isProxy
            : isProxy // ignore: cast_nullable_to_non_nullable
                  as bool,
        maxProxyAmount: freezed == maxProxyAmount
            ? _value.maxProxyAmount
            : maxProxyAmount // ignore: cast_nullable_to_non_nullable
                  as int?,
        createdAt: null == createdAt
            ? _value.createdAt
            : createdAt // ignore: cast_nullable_to_non_nullable
                  as DateTime,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$BidModelImpl implements _BidModel {
  const _$BidModelImpl({
    required this.id,
    required this.bidderId,
    required this.amount,
    this.isProxy = false,
    this.maxProxyAmount,
    @TimestampConverter() required this.createdAt,
  });

  factory _$BidModelImpl.fromJson(Map<String, dynamic> json) =>
      _$$BidModelImplFromJson(json);

  @override
  final String id;
  @override
  final String bidderId;
  @override
  final int amount;
  @override
  @JsonKey()
  final bool isProxy;
  @override
  final int? maxProxyAmount;
  @override
  @TimestampConverter()
  final DateTime createdAt;

  @override
  String toString() {
    return 'BidModel(id: $id, bidderId: $bidderId, amount: $amount, isProxy: $isProxy, maxProxyAmount: $maxProxyAmount, createdAt: $createdAt)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$BidModelImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.bidderId, bidderId) ||
                other.bidderId == bidderId) &&
            (identical(other.amount, amount) || other.amount == amount) &&
            (identical(other.isProxy, isProxy) || other.isProxy == isProxy) &&
            (identical(other.maxProxyAmount, maxProxyAmount) ||
                other.maxProxyAmount == maxProxyAmount) &&
            (identical(other.createdAt, createdAt) ||
                other.createdAt == createdAt));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
    runtimeType,
    id,
    bidderId,
    amount,
    isProxy,
    maxProxyAmount,
    createdAt,
  );

  /// Create a copy of BidModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$BidModelImplCopyWith<_$BidModelImpl> get copyWith =>
      __$$BidModelImplCopyWithImpl<_$BidModelImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$BidModelImplToJson(this);
  }
}

abstract class _BidModel implements BidModel {
  const factory _BidModel({
    required final String id,
    required final String bidderId,
    required final int amount,
    final bool isProxy,
    final int? maxProxyAmount,
    @TimestampConverter() required final DateTime createdAt,
  }) = _$BidModelImpl;

  factory _BidModel.fromJson(Map<String, dynamic> json) =
      _$BidModelImpl.fromJson;

  @override
  String get id;
  @override
  String get bidderId;
  @override
  int get amount;
  @override
  bool get isProxy;
  @override
  int? get maxProxyAmount;
  @override
  @TimestampConverter()
  DateTime get createdAt;

  /// Create a copy of BidModel
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$BidModelImplCopyWith<_$BidModelImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
