// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'purchase_item.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

PurchaseItem _$PurchaseItemFromJson(Map<String, dynamic> json) {
  return _PurchaseItem.fromJson(json);
}

/// @nodoc
mixin _$PurchaseItem {
  String get id => throw _privateConstructorUsedError;
  String get itemName => throw _privateConstructorUsedError;
  int get count => throw _privateConstructorUsedError;
  String get size => throw _privateConstructorUsedError;
  String get color => throw _privateConstructorUsedError;
  String get priceType => throw _privateConstructorUsedError;
  int get price => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $PurchaseItemCopyWith<PurchaseItem> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $PurchaseItemCopyWith<$Res> {
  factory $PurchaseItemCopyWith(
          PurchaseItem value, $Res Function(PurchaseItem) then) =
      _$PurchaseItemCopyWithImpl<$Res, PurchaseItem>;
  @useResult
  $Res call(
      {String id,
      String itemName,
      int count,
      String size,
      String color,
      String priceType,
      int price});
}

/// @nodoc
class _$PurchaseItemCopyWithImpl<$Res, $Val extends PurchaseItem>
    implements $PurchaseItemCopyWith<$Res> {
  _$PurchaseItemCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? itemName = null,
    Object? count = null,
    Object? size = null,
    Object? color = null,
    Object? priceType = null,
    Object? price = null,
  }) {
    return _then(_value.copyWith(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      itemName: null == itemName
          ? _value.itemName
          : itemName // ignore: cast_nullable_to_non_nullable
              as String,
      count: null == count
          ? _value.count
          : count // ignore: cast_nullable_to_non_nullable
              as int,
      size: null == size
          ? _value.size
          : size // ignore: cast_nullable_to_non_nullable
              as String,
      color: null == color
          ? _value.color
          : color // ignore: cast_nullable_to_non_nullable
              as String,
      priceType: null == priceType
          ? _value.priceType
          : priceType // ignore: cast_nullable_to_non_nullable
              as String,
      price: null == price
          ? _value.price
          : price // ignore: cast_nullable_to_non_nullable
              as int,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$_PurchaseItemCopyWith<$Res>
    implements $PurchaseItemCopyWith<$Res> {
  factory _$$_PurchaseItemCopyWith(
          _$_PurchaseItem value, $Res Function(_$_PurchaseItem) then) =
      __$$_PurchaseItemCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String id,
      String itemName,
      int count,
      String size,
      String color,
      String priceType,
      int price});
}

/// @nodoc
class __$$_PurchaseItemCopyWithImpl<$Res>
    extends _$PurchaseItemCopyWithImpl<$Res, _$_PurchaseItem>
    implements _$$_PurchaseItemCopyWith<$Res> {
  __$$_PurchaseItemCopyWithImpl(
      _$_PurchaseItem _value, $Res Function(_$_PurchaseItem) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? itemName = null,
    Object? count = null,
    Object? size = null,
    Object? color = null,
    Object? priceType = null,
    Object? price = null,
  }) {
    return _then(_$_PurchaseItem(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      itemName: null == itemName
          ? _value.itemName
          : itemName // ignore: cast_nullable_to_non_nullable
              as String,
      count: null == count
          ? _value.count
          : count // ignore: cast_nullable_to_non_nullable
              as int,
      size: null == size
          ? _value.size
          : size // ignore: cast_nullable_to_non_nullable
              as String,
      color: null == color
          ? _value.color
          : color // ignore: cast_nullable_to_non_nullable
              as String,
      priceType: null == priceType
          ? _value.priceType
          : priceType // ignore: cast_nullable_to_non_nullable
              as String,
      price: null == price
          ? _value.price
          : price // ignore: cast_nullable_to_non_nullable
              as int,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$_PurchaseItem implements _PurchaseItem {
  _$_PurchaseItem(
      {required this.id,
      required this.itemName,
      required this.count,
      required this.size,
      required this.color,
      required this.priceType,
      required this.price});

  factory _$_PurchaseItem.fromJson(Map<String, dynamic> json) =>
      _$$_PurchaseItemFromJson(json);

  @override
  final String id;
  @override
  final String itemName;
  @override
  final int count;
  @override
  final String size;
  @override
  final String color;
  @override
  final String priceType;
  @override
  final int price;

  @override
  String toString() {
    return 'PurchaseItem(id: $id, itemName: $itemName, count: $count, size: $size, color: $color, priceType: $priceType, price: $price)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_PurchaseItem &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.itemName, itemName) ||
                other.itemName == itemName) &&
            (identical(other.count, count) || other.count == count) &&
            (identical(other.size, size) || other.size == size) &&
            (identical(other.color, color) || other.color == color) &&
            (identical(other.priceType, priceType) ||
                other.priceType == priceType) &&
            (identical(other.price, price) || other.price == price));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(
      runtimeType, id, itemName, count, size, color, priceType, price);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_PurchaseItemCopyWith<_$_PurchaseItem> get copyWith =>
      __$$_PurchaseItemCopyWithImpl<_$_PurchaseItem>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$_PurchaseItemToJson(
      this,
    );
  }
}

abstract class _PurchaseItem implements PurchaseItem {
  factory _PurchaseItem(
      {required final String id,
      required final String itemName,
      required final int count,
      required final String size,
      required final String color,
      required final String priceType,
      required final int price}) = _$_PurchaseItem;

  factory _PurchaseItem.fromJson(Map<String, dynamic> json) =
      _$_PurchaseItem.fromJson;

  @override
  String get id;
  @override
  String get itemName;
  @override
  int get count;
  @override
  String get size;
  @override
  String get color;
  @override
  String get priceType;
  @override
  int get price;
  @override
  @JsonKey(ignore: true)
  _$$_PurchaseItemCopyWith<_$_PurchaseItem> get copyWith =>
      throw _privateConstructorUsedError;
}
