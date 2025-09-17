// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'order_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
  'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models',
);

OrderModel _$OrderModelFromJson(Map<String, dynamic> json) {
  return _OrderModel.fromJson(json);
}

/// @nodoc
mixin _$OrderModel {
  String get id => throw _privateConstructorUsedError;
  String get itemId => throw _privateConstructorUsedError;
  String get buyerId => throw _privateConstructorUsedError;
  int get finalPrice => throw _privateConstructorUsedError;
  int get buyerPremium => throw _privateConstructorUsedError;
  int get sellerFee => throw _privateConstructorUsedError;
  int get vat => throw _privateConstructorUsedError;
  PaymentMethod get paymentMethod => throw _privateConstructorUsedError;
  PaymentStatus get paymentStatus => throw _privateConstructorUsedError;
  int get depositAmount => throw _privateConstructorUsedError;
  String get depositCode => throw _privateConstructorUsedError;
  @TimestampConverter()
  DateTime get depositDeadline => throw _privateConstructorUsedError;
  String? get depositorNameInput => throw _privateConstructorUsedError;
  String? get receiptUrl => throw _privateConstructorUsedError;
  @TimestampConverter()
  DateTime get createdAt => throw _privateConstructorUsedError;
  @TimestampConverter()
  DateTime get updatedAt => throw _privateConstructorUsedError;
  @TimestampConverter()
  DateTime? get settledAt => throw _privateConstructorUsedError;

  /// Serializes this OrderModel to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of OrderModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $OrderModelCopyWith<OrderModel> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $OrderModelCopyWith<$Res> {
  factory $OrderModelCopyWith(
    OrderModel value,
    $Res Function(OrderModel) then,
  ) = _$OrderModelCopyWithImpl<$Res, OrderModel>;
  @useResult
  $Res call({
    String id,
    String itemId,
    String buyerId,
    int finalPrice,
    int buyerPremium,
    int sellerFee,
    int vat,
    PaymentMethod paymentMethod,
    PaymentStatus paymentStatus,
    int depositAmount,
    String depositCode,
    @TimestampConverter() DateTime depositDeadline,
    String? depositorNameInput,
    String? receiptUrl,
    @TimestampConverter() DateTime createdAt,
    @TimestampConverter() DateTime updatedAt,
    @TimestampConverter() DateTime? settledAt,
  });
}

/// @nodoc
class _$OrderModelCopyWithImpl<$Res, $Val extends OrderModel>
    implements $OrderModelCopyWith<$Res> {
  _$OrderModelCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of OrderModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? itemId = null,
    Object? buyerId = null,
    Object? finalPrice = null,
    Object? buyerPremium = null,
    Object? sellerFee = null,
    Object? vat = null,
    Object? paymentMethod = null,
    Object? paymentStatus = null,
    Object? depositAmount = null,
    Object? depositCode = null,
    Object? depositDeadline = null,
    Object? depositorNameInput = freezed,
    Object? receiptUrl = freezed,
    Object? createdAt = null,
    Object? updatedAt = null,
    Object? settledAt = freezed,
  }) {
    return _then(
      _value.copyWith(
            id: null == id
                ? _value.id
                : id // ignore: cast_nullable_to_non_nullable
                      as String,
            itemId: null == itemId
                ? _value.itemId
                : itemId // ignore: cast_nullable_to_non_nullable
                      as String,
            buyerId: null == buyerId
                ? _value.buyerId
                : buyerId // ignore: cast_nullable_to_non_nullable
                      as String,
            finalPrice: null == finalPrice
                ? _value.finalPrice
                : finalPrice // ignore: cast_nullable_to_non_nullable
                      as int,
            buyerPremium: null == buyerPremium
                ? _value.buyerPremium
                : buyerPremium // ignore: cast_nullable_to_non_nullable
                      as int,
            sellerFee: null == sellerFee
                ? _value.sellerFee
                : sellerFee // ignore: cast_nullable_to_non_nullable
                      as int,
            vat: null == vat
                ? _value.vat
                : vat // ignore: cast_nullable_to_non_nullable
                      as int,
            paymentMethod: null == paymentMethod
                ? _value.paymentMethod
                : paymentMethod // ignore: cast_nullable_to_non_nullable
                      as PaymentMethod,
            paymentStatus: null == paymentStatus
                ? _value.paymentStatus
                : paymentStatus // ignore: cast_nullable_to_non_nullable
                      as PaymentStatus,
            depositAmount: null == depositAmount
                ? _value.depositAmount
                : depositAmount // ignore: cast_nullable_to_non_nullable
                      as int,
            depositCode: null == depositCode
                ? _value.depositCode
                : depositCode // ignore: cast_nullable_to_non_nullable
                      as String,
            depositDeadline: null == depositDeadline
                ? _value.depositDeadline
                : depositDeadline // ignore: cast_nullable_to_non_nullable
                      as DateTime,
            depositorNameInput: freezed == depositorNameInput
                ? _value.depositorNameInput
                : depositorNameInput // ignore: cast_nullable_to_non_nullable
                      as String?,
            receiptUrl: freezed == receiptUrl
                ? _value.receiptUrl
                : receiptUrl // ignore: cast_nullable_to_non_nullable
                      as String?,
            createdAt: null == createdAt
                ? _value.createdAt
                : createdAt // ignore: cast_nullable_to_non_nullable
                      as DateTime,
            updatedAt: null == updatedAt
                ? _value.updatedAt
                : updatedAt // ignore: cast_nullable_to_non_nullable
                      as DateTime,
            settledAt: freezed == settledAt
                ? _value.settledAt
                : settledAt // ignore: cast_nullable_to_non_nullable
                      as DateTime?,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$OrderModelImplCopyWith<$Res>
    implements $OrderModelCopyWith<$Res> {
  factory _$$OrderModelImplCopyWith(
    _$OrderModelImpl value,
    $Res Function(_$OrderModelImpl) then,
  ) = __$$OrderModelImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    String id,
    String itemId,
    String buyerId,
    int finalPrice,
    int buyerPremium,
    int sellerFee,
    int vat,
    PaymentMethod paymentMethod,
    PaymentStatus paymentStatus,
    int depositAmount,
    String depositCode,
    @TimestampConverter() DateTime depositDeadline,
    String? depositorNameInput,
    String? receiptUrl,
    @TimestampConverter() DateTime createdAt,
    @TimestampConverter() DateTime updatedAt,
    @TimestampConverter() DateTime? settledAt,
  });
}

/// @nodoc
class __$$OrderModelImplCopyWithImpl<$Res>
    extends _$OrderModelCopyWithImpl<$Res, _$OrderModelImpl>
    implements _$$OrderModelImplCopyWith<$Res> {
  __$$OrderModelImplCopyWithImpl(
    _$OrderModelImpl _value,
    $Res Function(_$OrderModelImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of OrderModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? itemId = null,
    Object? buyerId = null,
    Object? finalPrice = null,
    Object? buyerPremium = null,
    Object? sellerFee = null,
    Object? vat = null,
    Object? paymentMethod = null,
    Object? paymentStatus = null,
    Object? depositAmount = null,
    Object? depositCode = null,
    Object? depositDeadline = null,
    Object? depositorNameInput = freezed,
    Object? receiptUrl = freezed,
    Object? createdAt = null,
    Object? updatedAt = null,
    Object? settledAt = freezed,
  }) {
    return _then(
      _$OrderModelImpl(
        id: null == id
            ? _value.id
            : id // ignore: cast_nullable_to_non_nullable
                  as String,
        itemId: null == itemId
            ? _value.itemId
            : itemId // ignore: cast_nullable_to_non_nullable
                  as String,
        buyerId: null == buyerId
            ? _value.buyerId
            : buyerId // ignore: cast_nullable_to_non_nullable
                  as String,
        finalPrice: null == finalPrice
            ? _value.finalPrice
            : finalPrice // ignore: cast_nullable_to_non_nullable
                  as int,
        buyerPremium: null == buyerPremium
            ? _value.buyerPremium
            : buyerPremium // ignore: cast_nullable_to_non_nullable
                  as int,
        sellerFee: null == sellerFee
            ? _value.sellerFee
            : sellerFee // ignore: cast_nullable_to_non_nullable
                  as int,
        vat: null == vat
            ? _value.vat
            : vat // ignore: cast_nullable_to_non_nullable
                  as int,
        paymentMethod: null == paymentMethod
            ? _value.paymentMethod
            : paymentMethod // ignore: cast_nullable_to_non_nullable
                  as PaymentMethod,
        paymentStatus: null == paymentStatus
            ? _value.paymentStatus
            : paymentStatus // ignore: cast_nullable_to_non_nullable
                  as PaymentStatus,
        depositAmount: null == depositAmount
            ? _value.depositAmount
            : depositAmount // ignore: cast_nullable_to_non_nullable
                  as int,
        depositCode: null == depositCode
            ? _value.depositCode
            : depositCode // ignore: cast_nullable_to_non_nullable
                  as String,
        depositDeadline: null == depositDeadline
            ? _value.depositDeadline
            : depositDeadline // ignore: cast_nullable_to_non_nullable
                  as DateTime,
        depositorNameInput: freezed == depositorNameInput
            ? _value.depositorNameInput
            : depositorNameInput // ignore: cast_nullable_to_non_nullable
                  as String?,
        receiptUrl: freezed == receiptUrl
            ? _value.receiptUrl
            : receiptUrl // ignore: cast_nullable_to_non_nullable
                  as String?,
        createdAt: null == createdAt
            ? _value.createdAt
            : createdAt // ignore: cast_nullable_to_non_nullable
                  as DateTime,
        updatedAt: null == updatedAt
            ? _value.updatedAt
            : updatedAt // ignore: cast_nullable_to_non_nullable
                  as DateTime,
        settledAt: freezed == settledAt
            ? _value.settledAt
            : settledAt // ignore: cast_nullable_to_non_nullable
                  as DateTime?,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$OrderModelImpl implements _OrderModel {
  const _$OrderModelImpl({
    required this.id,
    required this.itemId,
    required this.buyerId,
    required this.finalPrice,
    required this.buyerPremium,
    required this.sellerFee,
    required this.vat,
    required this.paymentMethod,
    required this.paymentStatus,
    required this.depositAmount,
    required this.depositCode,
    @TimestampConverter() required this.depositDeadline,
    this.depositorNameInput,
    this.receiptUrl,
    @TimestampConverter() required this.createdAt,
    @TimestampConverter() required this.updatedAt,
    @TimestampConverter() this.settledAt,
  });

  factory _$OrderModelImpl.fromJson(Map<String, dynamic> json) =>
      _$$OrderModelImplFromJson(json);

  @override
  final String id;
  @override
  final String itemId;
  @override
  final String buyerId;
  @override
  final int finalPrice;
  @override
  final int buyerPremium;
  @override
  final int sellerFee;
  @override
  final int vat;
  @override
  final PaymentMethod paymentMethod;
  @override
  final PaymentStatus paymentStatus;
  @override
  final int depositAmount;
  @override
  final String depositCode;
  @override
  @TimestampConverter()
  final DateTime depositDeadline;
  @override
  final String? depositorNameInput;
  @override
  final String? receiptUrl;
  @override
  @TimestampConverter()
  final DateTime createdAt;
  @override
  @TimestampConverter()
  final DateTime updatedAt;
  @override
  @TimestampConverter()
  final DateTime? settledAt;

  @override
  String toString() {
    return 'OrderModel(id: $id, itemId: $itemId, buyerId: $buyerId, finalPrice: $finalPrice, buyerPremium: $buyerPremium, sellerFee: $sellerFee, vat: $vat, paymentMethod: $paymentMethod, paymentStatus: $paymentStatus, depositAmount: $depositAmount, depositCode: $depositCode, depositDeadline: $depositDeadline, depositorNameInput: $depositorNameInput, receiptUrl: $receiptUrl, createdAt: $createdAt, updatedAt: $updatedAt, settledAt: $settledAt)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$OrderModelImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.itemId, itemId) || other.itemId == itemId) &&
            (identical(other.buyerId, buyerId) || other.buyerId == buyerId) &&
            (identical(other.finalPrice, finalPrice) ||
                other.finalPrice == finalPrice) &&
            (identical(other.buyerPremium, buyerPremium) ||
                other.buyerPremium == buyerPremium) &&
            (identical(other.sellerFee, sellerFee) ||
                other.sellerFee == sellerFee) &&
            (identical(other.vat, vat) || other.vat == vat) &&
            (identical(other.paymentMethod, paymentMethod) ||
                other.paymentMethod == paymentMethod) &&
            (identical(other.paymentStatus, paymentStatus) ||
                other.paymentStatus == paymentStatus) &&
            (identical(other.depositAmount, depositAmount) ||
                other.depositAmount == depositAmount) &&
            (identical(other.depositCode, depositCode) ||
                other.depositCode == depositCode) &&
            (identical(other.depositDeadline, depositDeadline) ||
                other.depositDeadline == depositDeadline) &&
            (identical(other.depositorNameInput, depositorNameInput) ||
                other.depositorNameInput == depositorNameInput) &&
            (identical(other.receiptUrl, receiptUrl) ||
                other.receiptUrl == receiptUrl) &&
            (identical(other.createdAt, createdAt) ||
                other.createdAt == createdAt) &&
            (identical(other.updatedAt, updatedAt) ||
                other.updatedAt == updatedAt) &&
            (identical(other.settledAt, settledAt) ||
                other.settledAt == settledAt));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
    runtimeType,
    id,
    itemId,
    buyerId,
    finalPrice,
    buyerPremium,
    sellerFee,
    vat,
    paymentMethod,
    paymentStatus,
    depositAmount,
    depositCode,
    depositDeadline,
    depositorNameInput,
    receiptUrl,
    createdAt,
    updatedAt,
    settledAt,
  );

  /// Create a copy of OrderModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$OrderModelImplCopyWith<_$OrderModelImpl> get copyWith =>
      __$$OrderModelImplCopyWithImpl<_$OrderModelImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$OrderModelImplToJson(this);
  }
}

abstract class _OrderModel implements OrderModel {
  const factory _OrderModel({
    required final String id,
    required final String itemId,
    required final String buyerId,
    required final int finalPrice,
    required final int buyerPremium,
    required final int sellerFee,
    required final int vat,
    required final PaymentMethod paymentMethod,
    required final PaymentStatus paymentStatus,
    required final int depositAmount,
    required final String depositCode,
    @TimestampConverter() required final DateTime depositDeadline,
    final String? depositorNameInput,
    final String? receiptUrl,
    @TimestampConverter() required final DateTime createdAt,
    @TimestampConverter() required final DateTime updatedAt,
    @TimestampConverter() final DateTime? settledAt,
  }) = _$OrderModelImpl;

  factory _OrderModel.fromJson(Map<String, dynamic> json) =
      _$OrderModelImpl.fromJson;

  @override
  String get id;
  @override
  String get itemId;
  @override
  String get buyerId;
  @override
  int get finalPrice;
  @override
  int get buyerPremium;
  @override
  int get sellerFee;
  @override
  int get vat;
  @override
  PaymentMethod get paymentMethod;
  @override
  PaymentStatus get paymentStatus;
  @override
  int get depositAmount;
  @override
  String get depositCode;
  @override
  @TimestampConverter()
  DateTime get depositDeadline;
  @override
  String? get depositorNameInput;
  @override
  String? get receiptUrl;
  @override
  @TimestampConverter()
  DateTime get createdAt;
  @override
  @TimestampConverter()
  DateTime get updatedAt;
  @override
  @TimestampConverter()
  DateTime? get settledAt;

  /// Create a copy of OrderModel
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$OrderModelImplCopyWith<_$OrderModelImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
