// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'purchase.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

PurchaseModel _$PurchaseModelFromJson(Map<String, dynamic> json) {
  return _PurchaseModel.fromJson(json);
}

/// @nodoc
mixin _$PurchaseModel {
  String get id => throw _privateConstructorUsedError;
  @JsonKey(nullable: true)
  List<PurchaseItem>? get items => throw _privateConstructorUsedError;
  @JsonKey(nullable: true)
  List<RewardProduct>? get rewardProductList =>
      throw _privateConstructorUsedError;
  String get name => throw _privateConstructorUsedError;
  String get email => throw _privateConstructorUsedError;
  String get phone => throw _privateConstructorUsedError;
  String get address => throw _privateConstructorUsedError;
  String get userId => throw _privateConstructorUsedError;
  List<dynamic>? get deliveryTownshipInfo => throw _privateConstructorUsedError;
  @JsonKey(nullable: true)
  String? get bankSlipImage => throw _privateConstructorUsedError;
  String get dateTime => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $PurchaseModelCopyWith<PurchaseModel> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $PurchaseModelCopyWith<$Res> {
  factory $PurchaseModelCopyWith(
          PurchaseModel value, $Res Function(PurchaseModel) then) =
      _$PurchaseModelCopyWithImpl<$Res, PurchaseModel>;
  @useResult
  $Res call(
      {String id,
      @JsonKey(nullable: true) List<PurchaseItem>? items,
      @JsonKey(nullable: true) List<RewardProduct>? rewardProductList,
      String name,
      String email,
      String phone,
      String address,
      String userId,
      List<dynamic>? deliveryTownshipInfo,
      @JsonKey(nullable: true) String? bankSlipImage,
      String dateTime});
}

/// @nodoc
class _$PurchaseModelCopyWithImpl<$Res, $Val extends PurchaseModel>
    implements $PurchaseModelCopyWith<$Res> {
  _$PurchaseModelCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? items = freezed,
    Object? rewardProductList = freezed,
    Object? name = null,
    Object? email = null,
    Object? phone = null,
    Object? address = null,
    Object? userId = null,
    Object? deliveryTownshipInfo = freezed,
    Object? bankSlipImage = freezed,
    Object? dateTime = null,
  }) {
    return _then(_value.copyWith(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      items: freezed == items
          ? _value.items
          : items // ignore: cast_nullable_to_non_nullable
              as List<PurchaseItem>?,
      rewardProductList: freezed == rewardProductList
          ? _value.rewardProductList
          : rewardProductList // ignore: cast_nullable_to_non_nullable
              as List<RewardProduct>?,
      name: null == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      email: null == email
          ? _value.email
          : email // ignore: cast_nullable_to_non_nullable
              as String,
      phone: null == phone
          ? _value.phone
          : phone // ignore: cast_nullable_to_non_nullable
              as String,
      address: null == address
          ? _value.address
          : address // ignore: cast_nullable_to_non_nullable
              as String,
      userId: null == userId
          ? _value.userId
          : userId // ignore: cast_nullable_to_non_nullable
              as String,
      deliveryTownshipInfo: freezed == deliveryTownshipInfo
          ? _value.deliveryTownshipInfo
          : deliveryTownshipInfo // ignore: cast_nullable_to_non_nullable
              as List<dynamic>?,
      bankSlipImage: freezed == bankSlipImage
          ? _value.bankSlipImage
          : bankSlipImage // ignore: cast_nullable_to_non_nullable
              as String?,
      dateTime: null == dateTime
          ? _value.dateTime
          : dateTime // ignore: cast_nullable_to_non_nullable
              as String,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$_PurchaseModelCopyWith<$Res>
    implements $PurchaseModelCopyWith<$Res> {
  factory _$$_PurchaseModelCopyWith(
          _$_PurchaseModel value, $Res Function(_$_PurchaseModel) then) =
      __$$_PurchaseModelCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String id,
      @JsonKey(nullable: true) List<PurchaseItem>? items,
      @JsonKey(nullable: true) List<RewardProduct>? rewardProductList,
      String name,
      String email,
      String phone,
      String address,
      String userId,
      List<dynamic>? deliveryTownshipInfo,
      @JsonKey(nullable: true) String? bankSlipImage,
      String dateTime});
}

/// @nodoc
class __$$_PurchaseModelCopyWithImpl<$Res>
    extends _$PurchaseModelCopyWithImpl<$Res, _$_PurchaseModel>
    implements _$$_PurchaseModelCopyWith<$Res> {
  __$$_PurchaseModelCopyWithImpl(
      _$_PurchaseModel _value, $Res Function(_$_PurchaseModel) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? items = freezed,
    Object? rewardProductList = freezed,
    Object? name = null,
    Object? email = null,
    Object? phone = null,
    Object? address = null,
    Object? userId = null,
    Object? deliveryTownshipInfo = freezed,
    Object? bankSlipImage = freezed,
    Object? dateTime = null,
  }) {
    return _then(_$_PurchaseModel(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      items: freezed == items
          ? _value._items
          : items // ignore: cast_nullable_to_non_nullable
              as List<PurchaseItem>?,
      rewardProductList: freezed == rewardProductList
          ? _value._rewardProductList
          : rewardProductList // ignore: cast_nullable_to_non_nullable
              as List<RewardProduct>?,
      name: null == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      email: null == email
          ? _value.email
          : email // ignore: cast_nullable_to_non_nullable
              as String,
      phone: null == phone
          ? _value.phone
          : phone // ignore: cast_nullable_to_non_nullable
              as String,
      address: null == address
          ? _value.address
          : address // ignore: cast_nullable_to_non_nullable
              as String,
      userId: null == userId
          ? _value.userId
          : userId // ignore: cast_nullable_to_non_nullable
              as String,
      deliveryTownshipInfo: freezed == deliveryTownshipInfo
          ? _value._deliveryTownshipInfo
          : deliveryTownshipInfo // ignore: cast_nullable_to_non_nullable
              as List<dynamic>?,
      bankSlipImage: freezed == bankSlipImage
          ? _value.bankSlipImage
          : bankSlipImage // ignore: cast_nullable_to_non_nullable
              as String?,
      dateTime: null == dateTime
          ? _value.dateTime
          : dateTime // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc

@JsonSerializable(explicitToJson: true)
class _$_PurchaseModel implements _PurchaseModel {
  _$_PurchaseModel(
      {required this.id,
      @JsonKey(nullable: true) required final List<PurchaseItem>? items,
      @JsonKey(nullable: true) final List<RewardProduct>? rewardProductList,
      required this.name,
      required this.email,
      required this.phone,
      required this.address,
      required this.userId,
      final List<dynamic>? deliveryTownshipInfo,
      @JsonKey(nullable: true) this.bankSlipImage,
      required this.dateTime})
      : _items = items,
        _rewardProductList = rewardProductList,
        _deliveryTownshipInfo = deliveryTownshipInfo;

  factory _$_PurchaseModel.fromJson(Map<String, dynamic> json) =>
      _$$_PurchaseModelFromJson(json);

  @override
  final String id;
  final List<PurchaseItem>? _items;
  @override
  @JsonKey(nullable: true)
  List<PurchaseItem>? get items {
    final value = _items;
    if (value == null) return null;
    if (_items is EqualUnmodifiableListView) return _items;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(value);
  }

  final List<RewardProduct>? _rewardProductList;
  @override
  @JsonKey(nullable: true)
  List<RewardProduct>? get rewardProductList {
    final value = _rewardProductList;
    if (value == null) return null;
    if (_rewardProductList is EqualUnmodifiableListView)
      return _rewardProductList;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(value);
  }

  @override
  final String name;
  @override
  final String email;
  @override
  final String phone;
  @override
  final String address;
  @override
  final String userId;
  final List<dynamic>? _deliveryTownshipInfo;
  @override
  List<dynamic>? get deliveryTownshipInfo {
    final value = _deliveryTownshipInfo;
    if (value == null) return null;
    if (_deliveryTownshipInfo is EqualUnmodifiableListView)
      return _deliveryTownshipInfo;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(value);
  }

  @override
  @JsonKey(nullable: true)
  final String? bankSlipImage;
  @override
  final String dateTime;

  @override
  String toString() {
    return 'PurchaseModel(id: $id, items: $items, rewardProductList: $rewardProductList, name: $name, email: $email, phone: $phone, address: $address, userId: $userId, deliveryTownshipInfo: $deliveryTownshipInfo, bankSlipImage: $bankSlipImage, dateTime: $dateTime)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_PurchaseModel &&
            (identical(other.id, id) || other.id == id) &&
            const DeepCollectionEquality().equals(other._items, _items) &&
            const DeepCollectionEquality()
                .equals(other._rewardProductList, _rewardProductList) &&
            (identical(other.name, name) || other.name == name) &&
            (identical(other.email, email) || other.email == email) &&
            (identical(other.phone, phone) || other.phone == phone) &&
            (identical(other.address, address) || other.address == address) &&
            (identical(other.userId, userId) || other.userId == userId) &&
            const DeepCollectionEquality()
                .equals(other._deliveryTownshipInfo, _deliveryTownshipInfo) &&
            (identical(other.bankSlipImage, bankSlipImage) ||
                other.bankSlipImage == bankSlipImage) &&
            (identical(other.dateTime, dateTime) ||
                other.dateTime == dateTime));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      id,
      const DeepCollectionEquality().hash(_items),
      const DeepCollectionEquality().hash(_rewardProductList),
      name,
      email,
      phone,
      address,
      userId,
      const DeepCollectionEquality().hash(_deliveryTownshipInfo),
      bankSlipImage,
      dateTime);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_PurchaseModelCopyWith<_$_PurchaseModel> get copyWith =>
      __$$_PurchaseModelCopyWithImpl<_$_PurchaseModel>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$_PurchaseModelToJson(
      this,
    );
  }
}

abstract class _PurchaseModel implements PurchaseModel {
  factory _PurchaseModel(
      {required final String id,
      @JsonKey(nullable: true) required final List<PurchaseItem>? items,
      @JsonKey(nullable: true) final List<RewardProduct>? rewardProductList,
      required final String name,
      required final String email,
      required final String phone,
      required final String address,
      required final String userId,
      final List<dynamic>? deliveryTownshipInfo,
      @JsonKey(nullable: true) final String? bankSlipImage,
      required final String dateTime}) = _$_PurchaseModel;

  factory _PurchaseModel.fromJson(Map<String, dynamic> json) =
      _$_PurchaseModel.fromJson;

  @override
  String get id;
  @override
  @JsonKey(nullable: true)
  List<PurchaseItem>? get items;
  @override
  @JsonKey(nullable: true)
  List<RewardProduct>? get rewardProductList;
  @override
  String get name;
  @override
  String get email;
  @override
  String get phone;
  @override
  String get address;
  @override
  String get userId;
  @override
  List<dynamic>? get deliveryTownshipInfo;
  @override
  @JsonKey(nullable: true)
  String? get bankSlipImage;
  @override
  String get dateTime;
  @override
  @JsonKey(ignore: true)
  _$$_PurchaseModelCopyWith<_$_PurchaseModel> get copyWith =>
      throw _privateConstructorUsedError;
}
