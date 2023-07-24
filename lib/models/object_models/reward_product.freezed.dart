// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'reward_product.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

RewardProduct _$RewardProductFromJson(Map<String, dynamic> json) {
  return _RewardProduct.fromJson(json);
}

/// @nodoc
mixin _$RewardProduct {
  String get id => throw _privateConstructorUsedError;
  String get name => throw _privateConstructorUsedError;
  @JsonKey(nullable: true)
  String? get description => throw _privateConstructorUsedError;
  String get image => throw _privateConstructorUsedError;
  int get requirePoint => throw _privateConstructorUsedError;
  @JsonKey(nullable: true, defaultValue: 0)
  int? get count => throw _privateConstructorUsedError;
  DateTime? get dateTime => throw _privateConstructorUsedError;
  List<String>? get nameList => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $RewardProductCopyWith<RewardProduct> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $RewardProductCopyWith<$Res> {
  factory $RewardProductCopyWith(
          RewardProduct value, $Res Function(RewardProduct) then) =
      _$RewardProductCopyWithImpl<$Res, RewardProduct>;
  @useResult
  $Res call(
      {String id,
      String name,
      @JsonKey(nullable: true) String? description,
      String image,
      int requirePoint,
      @JsonKey(nullable: true, defaultValue: 0) int? count,
      DateTime? dateTime,
      List<String>? nameList});
}

/// @nodoc
class _$RewardProductCopyWithImpl<$Res, $Val extends RewardProduct>
    implements $RewardProductCopyWith<$Res> {
  _$RewardProductCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? name = null,
    Object? description = freezed,
    Object? image = null,
    Object? requirePoint = null,
    Object? count = freezed,
    Object? dateTime = freezed,
    Object? nameList = freezed,
  }) {
    return _then(_value.copyWith(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      name: null == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      description: freezed == description
          ? _value.description
          : description // ignore: cast_nullable_to_non_nullable
              as String?,
      image: null == image
          ? _value.image
          : image // ignore: cast_nullable_to_non_nullable
              as String,
      requirePoint: null == requirePoint
          ? _value.requirePoint
          : requirePoint // ignore: cast_nullable_to_non_nullable
              as int,
      count: freezed == count
          ? _value.count
          : count // ignore: cast_nullable_to_non_nullable
              as int?,
      dateTime: freezed == dateTime
          ? _value.dateTime
          : dateTime // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      nameList: freezed == nameList
          ? _value.nameList
          : nameList // ignore: cast_nullable_to_non_nullable
              as List<String>?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$_RewardProductCopyWith<$Res>
    implements $RewardProductCopyWith<$Res> {
  factory _$$_RewardProductCopyWith(
          _$_RewardProduct value, $Res Function(_$_RewardProduct) then) =
      __$$_RewardProductCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String id,
      String name,
      @JsonKey(nullable: true) String? description,
      String image,
      int requirePoint,
      @JsonKey(nullable: true, defaultValue: 0) int? count,
      DateTime? dateTime,
      List<String>? nameList});
}

/// @nodoc
class __$$_RewardProductCopyWithImpl<$Res>
    extends _$RewardProductCopyWithImpl<$Res, _$_RewardProduct>
    implements _$$_RewardProductCopyWith<$Res> {
  __$$_RewardProductCopyWithImpl(
      _$_RewardProduct _value, $Res Function(_$_RewardProduct) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? name = null,
    Object? description = freezed,
    Object? image = null,
    Object? requirePoint = null,
    Object? count = freezed,
    Object? dateTime = freezed,
    Object? nameList = freezed,
  }) {
    return _then(_$_RewardProduct(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      name: null == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      description: freezed == description
          ? _value.description
          : description // ignore: cast_nullable_to_non_nullable
              as String?,
      image: null == image
          ? _value.image
          : image // ignore: cast_nullable_to_non_nullable
              as String,
      requirePoint: null == requirePoint
          ? _value.requirePoint
          : requirePoint // ignore: cast_nullable_to_non_nullable
              as int,
      count: freezed == count
          ? _value.count
          : count // ignore: cast_nullable_to_non_nullable
              as int?,
      dateTime: freezed == dateTime
          ? _value.dateTime
          : dateTime // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      nameList: freezed == nameList
          ? _value._nameList
          : nameList // ignore: cast_nullable_to_non_nullable
              as List<String>?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$_RewardProduct implements _RewardProduct {
  _$_RewardProduct(
      {required this.id,
      required this.name,
      @JsonKey(nullable: true) this.description,
      required this.image,
      required this.requirePoint,
      @JsonKey(nullable: true, defaultValue: 0) this.count,
      this.dateTime,
      final List<String>? nameList})
      : _nameList = nameList;

  factory _$_RewardProduct.fromJson(Map<String, dynamic> json) =>
      _$$_RewardProductFromJson(json);

  @override
  final String id;
  @override
  final String name;
  @override
  @JsonKey(nullable: true)
  final String? description;
  @override
  final String image;
  @override
  final int requirePoint;
  @override
  @JsonKey(nullable: true, defaultValue: 0)
  final int? count;
  @override
  final DateTime? dateTime;
  final List<String>? _nameList;
  @override
  List<String>? get nameList {
    final value = _nameList;
    if (value == null) return null;
    if (_nameList is EqualUnmodifiableListView) return _nameList;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(value);
  }

  @override
  String toString() {
    return 'RewardProduct(id: $id, name: $name, description: $description, image: $image, requirePoint: $requirePoint, count: $count, dateTime: $dateTime, nameList: $nameList)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_RewardProduct &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.name, name) || other.name == name) &&
            (identical(other.description, description) ||
                other.description == description) &&
            (identical(other.image, image) || other.image == image) &&
            (identical(other.requirePoint, requirePoint) ||
                other.requirePoint == requirePoint) &&
            (identical(other.count, count) || other.count == count) &&
            (identical(other.dateTime, dateTime) ||
                other.dateTime == dateTime) &&
            const DeepCollectionEquality().equals(other._nameList, _nameList));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      id,
      name,
      description,
      image,
      requirePoint,
      count,
      dateTime,
      const DeepCollectionEquality().hash(_nameList));

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_RewardProductCopyWith<_$_RewardProduct> get copyWith =>
      __$$_RewardProductCopyWithImpl<_$_RewardProduct>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$_RewardProductToJson(
      this,
    );
  }
}

abstract class _RewardProduct implements RewardProduct {
  factory _RewardProduct(
      {required final String id,
      required final String name,
      @JsonKey(nullable: true) final String? description,
      required final String image,
      required final int requirePoint,
      @JsonKey(nullable: true, defaultValue: 0) final int? count,
      final DateTime? dateTime,
      final List<String>? nameList}) = _$_RewardProduct;

  factory _RewardProduct.fromJson(Map<String, dynamic> json) =
      _$_RewardProduct.fromJson;

  @override
  String get id;
  @override
  String get name;
  @override
  @JsonKey(nullable: true)
  String? get description;
  @override
  String get image;
  @override
  int get requirePoint;
  @override
  @JsonKey(nullable: true, defaultValue: 0)
  int? get count;
  @override
  DateTime? get dateTime;
  @override
  List<String>? get nameList;
  @override
  @JsonKey(ignore: true)
  _$$_RewardProductCopyWith<_$_RewardProduct> get copyWith =>
      throw _privateConstructorUsedError;
}
