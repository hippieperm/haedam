// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'item_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
  'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models',
);

ItemModel _$ItemModelFromJson(Map<String, dynamic> json) {
  return _ItemModel.fromJson(json);
}

/// @nodoc
mixin _$ItemModel {
  String get id => throw _privateConstructorUsedError;
  String get sellerId => throw _privateConstructorUsedError;
  String get title => throw _privateConstructorUsedError;
  String get species => throw _privateConstructorUsedError;
  String get style => throw _privateConstructorUsedError;
  String get sizeClass => throw _privateConstructorUsedError;
  double get heightCm => throw _privateConstructorUsedError;
  double get crownWidthCm => throw _privateConstructorUsedError;
  int get ageYearsEst => throw _privateConstructorUsedError;
  String? get healthNotes => throw _privateConstructorUsedError;
  String? get originNotes => throw _privateConstructorUsedError;
  String? get careHistory => throw _privateConstructorUsedError;
  String get coverImageUrl => throw _privateConstructorUsedError;
  List<MediaItem> get media => throw _privateConstructorUsedError;
  ItemStatus get status => throw _privateConstructorUsedError;
  AuctionInfo? get auction => throw _privateConstructorUsedError;
  ShippingInfo? get shipping => throw _privateConstructorUsedError;
  @TimestampConverter()
  DateTime get createdAt => throw _privateConstructorUsedError;
  @TimestampConverter()
  DateTime get updatedAt => throw _privateConstructorUsedError;
  String? get approvedBy => throw _privateConstructorUsedError;
  @TimestampConverter()
  DateTime? get approvedAt => throw _privateConstructorUsedError;

  /// Serializes this ItemModel to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of ItemModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $ItemModelCopyWith<ItemModel> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ItemModelCopyWith<$Res> {
  factory $ItemModelCopyWith(ItemModel value, $Res Function(ItemModel) then) =
      _$ItemModelCopyWithImpl<$Res, ItemModel>;
  @useResult
  $Res call({
    String id,
    String sellerId,
    String title,
    String species,
    String style,
    String sizeClass,
    double heightCm,
    double crownWidthCm,
    int ageYearsEst,
    String? healthNotes,
    String? originNotes,
    String? careHistory,
    String coverImageUrl,
    List<MediaItem> media,
    ItemStatus status,
    AuctionInfo? auction,
    ShippingInfo? shipping,
    @TimestampConverter() DateTime createdAt,
    @TimestampConverter() DateTime updatedAt,
    String? approvedBy,
    @TimestampConverter() DateTime? approvedAt,
  });

  $AuctionInfoCopyWith<$Res>? get auction;
  $ShippingInfoCopyWith<$Res>? get shipping;
}

/// @nodoc
class _$ItemModelCopyWithImpl<$Res, $Val extends ItemModel>
    implements $ItemModelCopyWith<$Res> {
  _$ItemModelCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of ItemModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? sellerId = null,
    Object? title = null,
    Object? species = null,
    Object? style = null,
    Object? sizeClass = null,
    Object? heightCm = null,
    Object? crownWidthCm = null,
    Object? ageYearsEst = null,
    Object? healthNotes = freezed,
    Object? originNotes = freezed,
    Object? careHistory = freezed,
    Object? coverImageUrl = null,
    Object? media = null,
    Object? status = null,
    Object? auction = freezed,
    Object? shipping = freezed,
    Object? createdAt = null,
    Object? updatedAt = null,
    Object? approvedBy = freezed,
    Object? approvedAt = freezed,
  }) {
    return _then(
      _value.copyWith(
            id: null == id
                ? _value.id
                : id // ignore: cast_nullable_to_non_nullable
                      as String,
            sellerId: null == sellerId
                ? _value.sellerId
                : sellerId // ignore: cast_nullable_to_non_nullable
                      as String,
            title: null == title
                ? _value.title
                : title // ignore: cast_nullable_to_non_nullable
                      as String,
            species: null == species
                ? _value.species
                : species // ignore: cast_nullable_to_non_nullable
                      as String,
            style: null == style
                ? _value.style
                : style // ignore: cast_nullable_to_non_nullable
                      as String,
            sizeClass: null == sizeClass
                ? _value.sizeClass
                : sizeClass // ignore: cast_nullable_to_non_nullable
                      as String,
            heightCm: null == heightCm
                ? _value.heightCm
                : heightCm // ignore: cast_nullable_to_non_nullable
                      as double,
            crownWidthCm: null == crownWidthCm
                ? _value.crownWidthCm
                : crownWidthCm // ignore: cast_nullable_to_non_nullable
                      as double,
            ageYearsEst: null == ageYearsEst
                ? _value.ageYearsEst
                : ageYearsEst // ignore: cast_nullable_to_non_nullable
                      as int,
            healthNotes: freezed == healthNotes
                ? _value.healthNotes
                : healthNotes // ignore: cast_nullable_to_non_nullable
                      as String?,
            originNotes: freezed == originNotes
                ? _value.originNotes
                : originNotes // ignore: cast_nullable_to_non_nullable
                      as String?,
            careHistory: freezed == careHistory
                ? _value.careHistory
                : careHistory // ignore: cast_nullable_to_non_nullable
                      as String?,
            coverImageUrl: null == coverImageUrl
                ? _value.coverImageUrl
                : coverImageUrl // ignore: cast_nullable_to_non_nullable
                      as String,
            media: null == media
                ? _value.media
                : media // ignore: cast_nullable_to_non_nullable
                      as List<MediaItem>,
            status: null == status
                ? _value.status
                : status // ignore: cast_nullable_to_non_nullable
                      as ItemStatus,
            auction: freezed == auction
                ? _value.auction
                : auction // ignore: cast_nullable_to_non_nullable
                      as AuctionInfo?,
            shipping: freezed == shipping
                ? _value.shipping
                : shipping // ignore: cast_nullable_to_non_nullable
                      as ShippingInfo?,
            createdAt: null == createdAt
                ? _value.createdAt
                : createdAt // ignore: cast_nullable_to_non_nullable
                      as DateTime,
            updatedAt: null == updatedAt
                ? _value.updatedAt
                : updatedAt // ignore: cast_nullable_to_non_nullable
                      as DateTime,
            approvedBy: freezed == approvedBy
                ? _value.approvedBy
                : approvedBy // ignore: cast_nullable_to_non_nullable
                      as String?,
            approvedAt: freezed == approvedAt
                ? _value.approvedAt
                : approvedAt // ignore: cast_nullable_to_non_nullable
                      as DateTime?,
          )
          as $Val,
    );
  }

  /// Create a copy of ItemModel
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $AuctionInfoCopyWith<$Res>? get auction {
    if (_value.auction == null) {
      return null;
    }

    return $AuctionInfoCopyWith<$Res>(_value.auction!, (value) {
      return _then(_value.copyWith(auction: value) as $Val);
    });
  }

  /// Create a copy of ItemModel
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $ShippingInfoCopyWith<$Res>? get shipping {
    if (_value.shipping == null) {
      return null;
    }

    return $ShippingInfoCopyWith<$Res>(_value.shipping!, (value) {
      return _then(_value.copyWith(shipping: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$ItemModelImplCopyWith<$Res>
    implements $ItemModelCopyWith<$Res> {
  factory _$$ItemModelImplCopyWith(
    _$ItemModelImpl value,
    $Res Function(_$ItemModelImpl) then,
  ) = __$$ItemModelImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    String id,
    String sellerId,
    String title,
    String species,
    String style,
    String sizeClass,
    double heightCm,
    double crownWidthCm,
    int ageYearsEst,
    String? healthNotes,
    String? originNotes,
    String? careHistory,
    String coverImageUrl,
    List<MediaItem> media,
    ItemStatus status,
    AuctionInfo? auction,
    ShippingInfo? shipping,
    @TimestampConverter() DateTime createdAt,
    @TimestampConverter() DateTime updatedAt,
    String? approvedBy,
    @TimestampConverter() DateTime? approvedAt,
  });

  @override
  $AuctionInfoCopyWith<$Res>? get auction;
  @override
  $ShippingInfoCopyWith<$Res>? get shipping;
}

/// @nodoc
class __$$ItemModelImplCopyWithImpl<$Res>
    extends _$ItemModelCopyWithImpl<$Res, _$ItemModelImpl>
    implements _$$ItemModelImplCopyWith<$Res> {
  __$$ItemModelImplCopyWithImpl(
    _$ItemModelImpl _value,
    $Res Function(_$ItemModelImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of ItemModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? sellerId = null,
    Object? title = null,
    Object? species = null,
    Object? style = null,
    Object? sizeClass = null,
    Object? heightCm = null,
    Object? crownWidthCm = null,
    Object? ageYearsEst = null,
    Object? healthNotes = freezed,
    Object? originNotes = freezed,
    Object? careHistory = freezed,
    Object? coverImageUrl = null,
    Object? media = null,
    Object? status = null,
    Object? auction = freezed,
    Object? shipping = freezed,
    Object? createdAt = null,
    Object? updatedAt = null,
    Object? approvedBy = freezed,
    Object? approvedAt = freezed,
  }) {
    return _then(
      _$ItemModelImpl(
        id: null == id
            ? _value.id
            : id // ignore: cast_nullable_to_non_nullable
                  as String,
        sellerId: null == sellerId
            ? _value.sellerId
            : sellerId // ignore: cast_nullable_to_non_nullable
                  as String,
        title: null == title
            ? _value.title
            : title // ignore: cast_nullable_to_non_nullable
                  as String,
        species: null == species
            ? _value.species
            : species // ignore: cast_nullable_to_non_nullable
                  as String,
        style: null == style
            ? _value.style
            : style // ignore: cast_nullable_to_non_nullable
                  as String,
        sizeClass: null == sizeClass
            ? _value.sizeClass
            : sizeClass // ignore: cast_nullable_to_non_nullable
                  as String,
        heightCm: null == heightCm
            ? _value.heightCm
            : heightCm // ignore: cast_nullable_to_non_nullable
                  as double,
        crownWidthCm: null == crownWidthCm
            ? _value.crownWidthCm
            : crownWidthCm // ignore: cast_nullable_to_non_nullable
                  as double,
        ageYearsEst: null == ageYearsEst
            ? _value.ageYearsEst
            : ageYearsEst // ignore: cast_nullable_to_non_nullable
                  as int,
        healthNotes: freezed == healthNotes
            ? _value.healthNotes
            : healthNotes // ignore: cast_nullable_to_non_nullable
                  as String?,
        originNotes: freezed == originNotes
            ? _value.originNotes
            : originNotes // ignore: cast_nullable_to_non_nullable
                  as String?,
        careHistory: freezed == careHistory
            ? _value.careHistory
            : careHistory // ignore: cast_nullable_to_non_nullable
                  as String?,
        coverImageUrl: null == coverImageUrl
            ? _value.coverImageUrl
            : coverImageUrl // ignore: cast_nullable_to_non_nullable
                  as String,
        media: null == media
            ? _value._media
            : media // ignore: cast_nullable_to_non_nullable
                  as List<MediaItem>,
        status: null == status
            ? _value.status
            : status // ignore: cast_nullable_to_non_nullable
                  as ItemStatus,
        auction: freezed == auction
            ? _value.auction
            : auction // ignore: cast_nullable_to_non_nullable
                  as AuctionInfo?,
        shipping: freezed == shipping
            ? _value.shipping
            : shipping // ignore: cast_nullable_to_non_nullable
                  as ShippingInfo?,
        createdAt: null == createdAt
            ? _value.createdAt
            : createdAt // ignore: cast_nullable_to_non_nullable
                  as DateTime,
        updatedAt: null == updatedAt
            ? _value.updatedAt
            : updatedAt // ignore: cast_nullable_to_non_nullable
                  as DateTime,
        approvedBy: freezed == approvedBy
            ? _value.approvedBy
            : approvedBy // ignore: cast_nullable_to_non_nullable
                  as String?,
        approvedAt: freezed == approvedAt
            ? _value.approvedAt
            : approvedAt // ignore: cast_nullable_to_non_nullable
                  as DateTime?,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$ItemModelImpl implements _ItemModel {
  const _$ItemModelImpl({
    required this.id,
    required this.sellerId,
    required this.title,
    required this.species,
    required this.style,
    required this.sizeClass,
    required this.heightCm,
    required this.crownWidthCm,
    required this.ageYearsEst,
    this.healthNotes,
    this.originNotes,
    this.careHistory,
    required this.coverImageUrl,
    final List<MediaItem> media = const [],
    required this.status,
    this.auction,
    this.shipping,
    @TimestampConverter() required this.createdAt,
    @TimestampConverter() required this.updatedAt,
    this.approvedBy,
    @TimestampConverter() this.approvedAt,
  }) : _media = media;

  factory _$ItemModelImpl.fromJson(Map<String, dynamic> json) =>
      _$$ItemModelImplFromJson(json);

  @override
  final String id;
  @override
  final String sellerId;
  @override
  final String title;
  @override
  final String species;
  @override
  final String style;
  @override
  final String sizeClass;
  @override
  final double heightCm;
  @override
  final double crownWidthCm;
  @override
  final int ageYearsEst;
  @override
  final String? healthNotes;
  @override
  final String? originNotes;
  @override
  final String? careHistory;
  @override
  final String coverImageUrl;
  final List<MediaItem> _media;
  @override
  @JsonKey()
  List<MediaItem> get media {
    if (_media is EqualUnmodifiableListView) return _media;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_media);
  }

  @override
  final ItemStatus status;
  @override
  final AuctionInfo? auction;
  @override
  final ShippingInfo? shipping;
  @override
  @TimestampConverter()
  final DateTime createdAt;
  @override
  @TimestampConverter()
  final DateTime updatedAt;
  @override
  final String? approvedBy;
  @override
  @TimestampConverter()
  final DateTime? approvedAt;

  @override
  String toString() {
    return 'ItemModel(id: $id, sellerId: $sellerId, title: $title, species: $species, style: $style, sizeClass: $sizeClass, heightCm: $heightCm, crownWidthCm: $crownWidthCm, ageYearsEst: $ageYearsEst, healthNotes: $healthNotes, originNotes: $originNotes, careHistory: $careHistory, coverImageUrl: $coverImageUrl, media: $media, status: $status, auction: $auction, shipping: $shipping, createdAt: $createdAt, updatedAt: $updatedAt, approvedBy: $approvedBy, approvedAt: $approvedAt)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ItemModelImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.sellerId, sellerId) ||
                other.sellerId == sellerId) &&
            (identical(other.title, title) || other.title == title) &&
            (identical(other.species, species) || other.species == species) &&
            (identical(other.style, style) || other.style == style) &&
            (identical(other.sizeClass, sizeClass) ||
                other.sizeClass == sizeClass) &&
            (identical(other.heightCm, heightCm) ||
                other.heightCm == heightCm) &&
            (identical(other.crownWidthCm, crownWidthCm) ||
                other.crownWidthCm == crownWidthCm) &&
            (identical(other.ageYearsEst, ageYearsEst) ||
                other.ageYearsEst == ageYearsEst) &&
            (identical(other.healthNotes, healthNotes) ||
                other.healthNotes == healthNotes) &&
            (identical(other.originNotes, originNotes) ||
                other.originNotes == originNotes) &&
            (identical(other.careHistory, careHistory) ||
                other.careHistory == careHistory) &&
            (identical(other.coverImageUrl, coverImageUrl) ||
                other.coverImageUrl == coverImageUrl) &&
            const DeepCollectionEquality().equals(other._media, _media) &&
            (identical(other.status, status) || other.status == status) &&
            (identical(other.auction, auction) || other.auction == auction) &&
            (identical(other.shipping, shipping) ||
                other.shipping == shipping) &&
            (identical(other.createdAt, createdAt) ||
                other.createdAt == createdAt) &&
            (identical(other.updatedAt, updatedAt) ||
                other.updatedAt == updatedAt) &&
            (identical(other.approvedBy, approvedBy) ||
                other.approvedBy == approvedBy) &&
            (identical(other.approvedAt, approvedAt) ||
                other.approvedAt == approvedAt));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hashAll([
    runtimeType,
    id,
    sellerId,
    title,
    species,
    style,
    sizeClass,
    heightCm,
    crownWidthCm,
    ageYearsEst,
    healthNotes,
    originNotes,
    careHistory,
    coverImageUrl,
    const DeepCollectionEquality().hash(_media),
    status,
    auction,
    shipping,
    createdAt,
    updatedAt,
    approvedBy,
    approvedAt,
  ]);

  /// Create a copy of ItemModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$ItemModelImplCopyWith<_$ItemModelImpl> get copyWith =>
      __$$ItemModelImplCopyWithImpl<_$ItemModelImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$ItemModelImplToJson(this);
  }
}

abstract class _ItemModel implements ItemModel {
  const factory _ItemModel({
    required final String id,
    required final String sellerId,
    required final String title,
    required final String species,
    required final String style,
    required final String sizeClass,
    required final double heightCm,
    required final double crownWidthCm,
    required final int ageYearsEst,
    final String? healthNotes,
    final String? originNotes,
    final String? careHistory,
    required final String coverImageUrl,
    final List<MediaItem> media,
    required final ItemStatus status,
    final AuctionInfo? auction,
    final ShippingInfo? shipping,
    @TimestampConverter() required final DateTime createdAt,
    @TimestampConverter() required final DateTime updatedAt,
    final String? approvedBy,
    @TimestampConverter() final DateTime? approvedAt,
  }) = _$ItemModelImpl;

  factory _ItemModel.fromJson(Map<String, dynamic> json) =
      _$ItemModelImpl.fromJson;

  @override
  String get id;
  @override
  String get sellerId;
  @override
  String get title;
  @override
  String get species;
  @override
  String get style;
  @override
  String get sizeClass;
  @override
  double get heightCm;
  @override
  double get crownWidthCm;
  @override
  int get ageYearsEst;
  @override
  String? get healthNotes;
  @override
  String? get originNotes;
  @override
  String? get careHistory;
  @override
  String get coverImageUrl;
  @override
  List<MediaItem> get media;
  @override
  ItemStatus get status;
  @override
  AuctionInfo? get auction;
  @override
  ShippingInfo? get shipping;
  @override
  @TimestampConverter()
  DateTime get createdAt;
  @override
  @TimestampConverter()
  DateTime get updatedAt;
  @override
  String? get approvedBy;
  @override
  @TimestampConverter()
  DateTime? get approvedAt;

  /// Create a copy of ItemModel
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$ItemModelImplCopyWith<_$ItemModelImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

MediaItem _$MediaItemFromJson(Map<String, dynamic> json) {
  return _MediaItem.fromJson(json);
}

/// @nodoc
mixin _$MediaItem {
  String get url => throw _privateConstructorUsedError;
  String get type => throw _privateConstructorUsedError;
  int get sort => throw _privateConstructorUsedError;

  /// Serializes this MediaItem to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of MediaItem
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $MediaItemCopyWith<MediaItem> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $MediaItemCopyWith<$Res> {
  factory $MediaItemCopyWith(MediaItem value, $Res Function(MediaItem) then) =
      _$MediaItemCopyWithImpl<$Res, MediaItem>;
  @useResult
  $Res call({String url, String type, int sort});
}

/// @nodoc
class _$MediaItemCopyWithImpl<$Res, $Val extends MediaItem>
    implements $MediaItemCopyWith<$Res> {
  _$MediaItemCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of MediaItem
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({Object? url = null, Object? type = null, Object? sort = null}) {
    return _then(
      _value.copyWith(
            url: null == url
                ? _value.url
                : url // ignore: cast_nullable_to_non_nullable
                      as String,
            type: null == type
                ? _value.type
                : type // ignore: cast_nullable_to_non_nullable
                      as String,
            sort: null == sort
                ? _value.sort
                : sort // ignore: cast_nullable_to_non_nullable
                      as int,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$MediaItemImplCopyWith<$Res>
    implements $MediaItemCopyWith<$Res> {
  factory _$$MediaItemImplCopyWith(
    _$MediaItemImpl value,
    $Res Function(_$MediaItemImpl) then,
  ) = __$$MediaItemImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String url, String type, int sort});
}

/// @nodoc
class __$$MediaItemImplCopyWithImpl<$Res>
    extends _$MediaItemCopyWithImpl<$Res, _$MediaItemImpl>
    implements _$$MediaItemImplCopyWith<$Res> {
  __$$MediaItemImplCopyWithImpl(
    _$MediaItemImpl _value,
    $Res Function(_$MediaItemImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of MediaItem
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({Object? url = null, Object? type = null, Object? sort = null}) {
    return _then(
      _$MediaItemImpl(
        url: null == url
            ? _value.url
            : url // ignore: cast_nullable_to_non_nullable
                  as String,
        type: null == type
            ? _value.type
            : type // ignore: cast_nullable_to_non_nullable
                  as String,
        sort: null == sort
            ? _value.sort
            : sort // ignore: cast_nullable_to_non_nullable
                  as int,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$MediaItemImpl implements _MediaItem {
  const _$MediaItemImpl({
    required this.url,
    required this.type,
    required this.sort,
  });

  factory _$MediaItemImpl.fromJson(Map<String, dynamic> json) =>
      _$$MediaItemImplFromJson(json);

  @override
  final String url;
  @override
  final String type;
  @override
  final int sort;

  @override
  String toString() {
    return 'MediaItem(url: $url, type: $type, sort: $sort)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$MediaItemImpl &&
            (identical(other.url, url) || other.url == url) &&
            (identical(other.type, type) || other.type == type) &&
            (identical(other.sort, sort) || other.sort == sort));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, url, type, sort);

  /// Create a copy of MediaItem
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$MediaItemImplCopyWith<_$MediaItemImpl> get copyWith =>
      __$$MediaItemImplCopyWithImpl<_$MediaItemImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$MediaItemImplToJson(this);
  }
}

abstract class _MediaItem implements MediaItem {
  const factory _MediaItem({
    required final String url,
    required final String type,
    required final int sort,
  }) = _$MediaItemImpl;

  factory _MediaItem.fromJson(Map<String, dynamic> json) =
      _$MediaItemImpl.fromJson;

  @override
  String get url;
  @override
  String get type;
  @override
  int get sort;

  /// Create a copy of MediaItem
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$MediaItemImplCopyWith<_$MediaItemImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

AuctionInfo _$AuctionInfoFromJson(Map<String, dynamic> json) {
  return _AuctionInfo.fromJson(json);
}

/// @nodoc
mixin _$AuctionInfo {
  int get startPrice => throw _privateConstructorUsedError;
  int get bidStep => throw _privateConstructorUsedError;
  int? get reservePrice => throw _privateConstructorUsedError;
  int? get buyNowPrice => throw _privateConstructorUsedError;
  @TimestampConverter()
  DateTime get startsAt => throw _privateConstructorUsedError;
  @TimestampConverter()
  DateTime get endsAt => throw _privateConstructorUsedError;
  int get autoExtendMinutes => throw _privateConstructorUsedError;
  int get currentPrice => throw _privateConstructorUsedError;
  String? get currentBidId => throw _privateConstructorUsedError;
  String? get currentBidderId => throw _privateConstructorUsedError;
  int get bidCount => throw _privateConstructorUsedError;

  /// Serializes this AuctionInfo to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of AuctionInfo
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $AuctionInfoCopyWith<AuctionInfo> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $AuctionInfoCopyWith<$Res> {
  factory $AuctionInfoCopyWith(
    AuctionInfo value,
    $Res Function(AuctionInfo) then,
  ) = _$AuctionInfoCopyWithImpl<$Res, AuctionInfo>;
  @useResult
  $Res call({
    int startPrice,
    int bidStep,
    int? reservePrice,
    int? buyNowPrice,
    @TimestampConverter() DateTime startsAt,
    @TimestampConverter() DateTime endsAt,
    int autoExtendMinutes,
    int currentPrice,
    String? currentBidId,
    String? currentBidderId,
    int bidCount,
  });
}

/// @nodoc
class _$AuctionInfoCopyWithImpl<$Res, $Val extends AuctionInfo>
    implements $AuctionInfoCopyWith<$Res> {
  _$AuctionInfoCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of AuctionInfo
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? startPrice = null,
    Object? bidStep = null,
    Object? reservePrice = freezed,
    Object? buyNowPrice = freezed,
    Object? startsAt = null,
    Object? endsAt = null,
    Object? autoExtendMinutes = null,
    Object? currentPrice = null,
    Object? currentBidId = freezed,
    Object? currentBidderId = freezed,
    Object? bidCount = null,
  }) {
    return _then(
      _value.copyWith(
            startPrice: null == startPrice
                ? _value.startPrice
                : startPrice // ignore: cast_nullable_to_non_nullable
                      as int,
            bidStep: null == bidStep
                ? _value.bidStep
                : bidStep // ignore: cast_nullable_to_non_nullable
                      as int,
            reservePrice: freezed == reservePrice
                ? _value.reservePrice
                : reservePrice // ignore: cast_nullable_to_non_nullable
                      as int?,
            buyNowPrice: freezed == buyNowPrice
                ? _value.buyNowPrice
                : buyNowPrice // ignore: cast_nullable_to_non_nullable
                      as int?,
            startsAt: null == startsAt
                ? _value.startsAt
                : startsAt // ignore: cast_nullable_to_non_nullable
                      as DateTime,
            endsAt: null == endsAt
                ? _value.endsAt
                : endsAt // ignore: cast_nullable_to_non_nullable
                      as DateTime,
            autoExtendMinutes: null == autoExtendMinutes
                ? _value.autoExtendMinutes
                : autoExtendMinutes // ignore: cast_nullable_to_non_nullable
                      as int,
            currentPrice: null == currentPrice
                ? _value.currentPrice
                : currentPrice // ignore: cast_nullable_to_non_nullable
                      as int,
            currentBidId: freezed == currentBidId
                ? _value.currentBidId
                : currentBidId // ignore: cast_nullable_to_non_nullable
                      as String?,
            currentBidderId: freezed == currentBidderId
                ? _value.currentBidderId
                : currentBidderId // ignore: cast_nullable_to_non_nullable
                      as String?,
            bidCount: null == bidCount
                ? _value.bidCount
                : bidCount // ignore: cast_nullable_to_non_nullable
                      as int,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$AuctionInfoImplCopyWith<$Res>
    implements $AuctionInfoCopyWith<$Res> {
  factory _$$AuctionInfoImplCopyWith(
    _$AuctionInfoImpl value,
    $Res Function(_$AuctionInfoImpl) then,
  ) = __$$AuctionInfoImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    int startPrice,
    int bidStep,
    int? reservePrice,
    int? buyNowPrice,
    @TimestampConverter() DateTime startsAt,
    @TimestampConverter() DateTime endsAt,
    int autoExtendMinutes,
    int currentPrice,
    String? currentBidId,
    String? currentBidderId,
    int bidCount,
  });
}

/// @nodoc
class __$$AuctionInfoImplCopyWithImpl<$Res>
    extends _$AuctionInfoCopyWithImpl<$Res, _$AuctionInfoImpl>
    implements _$$AuctionInfoImplCopyWith<$Res> {
  __$$AuctionInfoImplCopyWithImpl(
    _$AuctionInfoImpl _value,
    $Res Function(_$AuctionInfoImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of AuctionInfo
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? startPrice = null,
    Object? bidStep = null,
    Object? reservePrice = freezed,
    Object? buyNowPrice = freezed,
    Object? startsAt = null,
    Object? endsAt = null,
    Object? autoExtendMinutes = null,
    Object? currentPrice = null,
    Object? currentBidId = freezed,
    Object? currentBidderId = freezed,
    Object? bidCount = null,
  }) {
    return _then(
      _$AuctionInfoImpl(
        startPrice: null == startPrice
            ? _value.startPrice
            : startPrice // ignore: cast_nullable_to_non_nullable
                  as int,
        bidStep: null == bidStep
            ? _value.bidStep
            : bidStep // ignore: cast_nullable_to_non_nullable
                  as int,
        reservePrice: freezed == reservePrice
            ? _value.reservePrice
            : reservePrice // ignore: cast_nullable_to_non_nullable
                  as int?,
        buyNowPrice: freezed == buyNowPrice
            ? _value.buyNowPrice
            : buyNowPrice // ignore: cast_nullable_to_non_nullable
                  as int?,
        startsAt: null == startsAt
            ? _value.startsAt
            : startsAt // ignore: cast_nullable_to_non_nullable
                  as DateTime,
        endsAt: null == endsAt
            ? _value.endsAt
            : endsAt // ignore: cast_nullable_to_non_nullable
                  as DateTime,
        autoExtendMinutes: null == autoExtendMinutes
            ? _value.autoExtendMinutes
            : autoExtendMinutes // ignore: cast_nullable_to_non_nullable
                  as int,
        currentPrice: null == currentPrice
            ? _value.currentPrice
            : currentPrice // ignore: cast_nullable_to_non_nullable
                  as int,
        currentBidId: freezed == currentBidId
            ? _value.currentBidId
            : currentBidId // ignore: cast_nullable_to_non_nullable
                  as String?,
        currentBidderId: freezed == currentBidderId
            ? _value.currentBidderId
            : currentBidderId // ignore: cast_nullable_to_non_nullable
                  as String?,
        bidCount: null == bidCount
            ? _value.bidCount
            : bidCount // ignore: cast_nullable_to_non_nullable
                  as int,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$AuctionInfoImpl implements _AuctionInfo {
  const _$AuctionInfoImpl({
    required this.startPrice,
    required this.bidStep,
    this.reservePrice,
    this.buyNowPrice,
    @TimestampConverter() required this.startsAt,
    @TimestampConverter() required this.endsAt,
    this.autoExtendMinutes = 2,
    this.currentPrice = 0,
    this.currentBidId,
    this.currentBidderId,
    this.bidCount = 0,
  });

  factory _$AuctionInfoImpl.fromJson(Map<String, dynamic> json) =>
      _$$AuctionInfoImplFromJson(json);

  @override
  final int startPrice;
  @override
  final int bidStep;
  @override
  final int? reservePrice;
  @override
  final int? buyNowPrice;
  @override
  @TimestampConverter()
  final DateTime startsAt;
  @override
  @TimestampConverter()
  final DateTime endsAt;
  @override
  @JsonKey()
  final int autoExtendMinutes;
  @override
  @JsonKey()
  final int currentPrice;
  @override
  final String? currentBidId;
  @override
  final String? currentBidderId;
  @override
  @JsonKey()
  final int bidCount;

  @override
  String toString() {
    return 'AuctionInfo(startPrice: $startPrice, bidStep: $bidStep, reservePrice: $reservePrice, buyNowPrice: $buyNowPrice, startsAt: $startsAt, endsAt: $endsAt, autoExtendMinutes: $autoExtendMinutes, currentPrice: $currentPrice, currentBidId: $currentBidId, currentBidderId: $currentBidderId, bidCount: $bidCount)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$AuctionInfoImpl &&
            (identical(other.startPrice, startPrice) ||
                other.startPrice == startPrice) &&
            (identical(other.bidStep, bidStep) || other.bidStep == bidStep) &&
            (identical(other.reservePrice, reservePrice) ||
                other.reservePrice == reservePrice) &&
            (identical(other.buyNowPrice, buyNowPrice) ||
                other.buyNowPrice == buyNowPrice) &&
            (identical(other.startsAt, startsAt) ||
                other.startsAt == startsAt) &&
            (identical(other.endsAt, endsAt) || other.endsAt == endsAt) &&
            (identical(other.autoExtendMinutes, autoExtendMinutes) ||
                other.autoExtendMinutes == autoExtendMinutes) &&
            (identical(other.currentPrice, currentPrice) ||
                other.currentPrice == currentPrice) &&
            (identical(other.currentBidId, currentBidId) ||
                other.currentBidId == currentBidId) &&
            (identical(other.currentBidderId, currentBidderId) ||
                other.currentBidderId == currentBidderId) &&
            (identical(other.bidCount, bidCount) ||
                other.bidCount == bidCount));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
    runtimeType,
    startPrice,
    bidStep,
    reservePrice,
    buyNowPrice,
    startsAt,
    endsAt,
    autoExtendMinutes,
    currentPrice,
    currentBidId,
    currentBidderId,
    bidCount,
  );

  /// Create a copy of AuctionInfo
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$AuctionInfoImplCopyWith<_$AuctionInfoImpl> get copyWith =>
      __$$AuctionInfoImplCopyWithImpl<_$AuctionInfoImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$AuctionInfoImplToJson(this);
  }
}

abstract class _AuctionInfo implements AuctionInfo {
  const factory _AuctionInfo({
    required final int startPrice,
    required final int bidStep,
    final int? reservePrice,
    final int? buyNowPrice,
    @TimestampConverter() required final DateTime startsAt,
    @TimestampConverter() required final DateTime endsAt,
    final int autoExtendMinutes,
    final int currentPrice,
    final String? currentBidId,
    final String? currentBidderId,
    final int bidCount,
  }) = _$AuctionInfoImpl;

  factory _AuctionInfo.fromJson(Map<String, dynamic> json) =
      _$AuctionInfoImpl.fromJson;

  @override
  int get startPrice;
  @override
  int get bidStep;
  @override
  int? get reservePrice;
  @override
  int? get buyNowPrice;
  @override
  @TimestampConverter()
  DateTime get startsAt;
  @override
  @TimestampConverter()
  DateTime get endsAt;
  @override
  int get autoExtendMinutes;
  @override
  int get currentPrice;
  @override
  String? get currentBidId;
  @override
  String? get currentBidderId;
  @override
  int get bidCount;

  /// Create a copy of AuctionInfo
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$AuctionInfoImplCopyWith<_$AuctionInfoImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

ShippingInfo _$ShippingInfoFromJson(Map<String, dynamic> json) {
  return _ShippingInfo.fromJson(json);
}

/// @nodoc
mixin _$ShippingInfo {
  ShippingMethod get method => throw _privateConstructorUsedError;
  String get feePolicy => throw _privateConstructorUsedError;

  /// Serializes this ShippingInfo to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of ShippingInfo
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $ShippingInfoCopyWith<ShippingInfo> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ShippingInfoCopyWith<$Res> {
  factory $ShippingInfoCopyWith(
    ShippingInfo value,
    $Res Function(ShippingInfo) then,
  ) = _$ShippingInfoCopyWithImpl<$Res, ShippingInfo>;
  @useResult
  $Res call({ShippingMethod method, String feePolicy});
}

/// @nodoc
class _$ShippingInfoCopyWithImpl<$Res, $Val extends ShippingInfo>
    implements $ShippingInfoCopyWith<$Res> {
  _$ShippingInfoCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of ShippingInfo
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({Object? method = null, Object? feePolicy = null}) {
    return _then(
      _value.copyWith(
            method: null == method
                ? _value.method
                : method // ignore: cast_nullable_to_non_nullable
                      as ShippingMethod,
            feePolicy: null == feePolicy
                ? _value.feePolicy
                : feePolicy // ignore: cast_nullable_to_non_nullable
                      as String,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$ShippingInfoImplCopyWith<$Res>
    implements $ShippingInfoCopyWith<$Res> {
  factory _$$ShippingInfoImplCopyWith(
    _$ShippingInfoImpl value,
    $Res Function(_$ShippingInfoImpl) then,
  ) = __$$ShippingInfoImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({ShippingMethod method, String feePolicy});
}

/// @nodoc
class __$$ShippingInfoImplCopyWithImpl<$Res>
    extends _$ShippingInfoCopyWithImpl<$Res, _$ShippingInfoImpl>
    implements _$$ShippingInfoImplCopyWith<$Res> {
  __$$ShippingInfoImplCopyWithImpl(
    _$ShippingInfoImpl _value,
    $Res Function(_$ShippingInfoImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of ShippingInfo
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({Object? method = null, Object? feePolicy = null}) {
    return _then(
      _$ShippingInfoImpl(
        method: null == method
            ? _value.method
            : method // ignore: cast_nullable_to_non_nullable
                  as ShippingMethod,
        feePolicy: null == feePolicy
            ? _value.feePolicy
            : feePolicy // ignore: cast_nullable_to_non_nullable
                  as String,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$ShippingInfoImpl implements _ShippingInfo {
  const _$ShippingInfoImpl({required this.method, required this.feePolicy});

  factory _$ShippingInfoImpl.fromJson(Map<String, dynamic> json) =>
      _$$ShippingInfoImplFromJson(json);

  @override
  final ShippingMethod method;
  @override
  final String feePolicy;

  @override
  String toString() {
    return 'ShippingInfo(method: $method, feePolicy: $feePolicy)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ShippingInfoImpl &&
            (identical(other.method, method) || other.method == method) &&
            (identical(other.feePolicy, feePolicy) ||
                other.feePolicy == feePolicy));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, method, feePolicy);

  /// Create a copy of ShippingInfo
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$ShippingInfoImplCopyWith<_$ShippingInfoImpl> get copyWith =>
      __$$ShippingInfoImplCopyWithImpl<_$ShippingInfoImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$ShippingInfoImplToJson(this);
  }
}

abstract class _ShippingInfo implements ShippingInfo {
  const factory _ShippingInfo({
    required final ShippingMethod method,
    required final String feePolicy,
  }) = _$ShippingInfoImpl;

  factory _ShippingInfo.fromJson(Map<String, dynamic> json) =
      _$ShippingInfoImpl.fromJson;

  @override
  ShippingMethod get method;
  @override
  String get feePolicy;

  /// Create a copy of ShippingInfo
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$ShippingInfoImplCopyWith<_$ShippingInfoImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
