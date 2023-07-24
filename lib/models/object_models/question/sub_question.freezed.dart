// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'sub_question.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

SubQuestion _$SubQuestionFromJson(Map<String, dynamic> json) {
  return _SubQuestion.fromJson(json);
}

/// @nodoc
mixin _$SubQuestion {
  String get id => throw _privateConstructorUsedError;
  int get qNo => throw _privateConstructorUsedError;
  int? get mainQNo => throw _privateConstructorUsedError;
  String get title => throw _privateConstructorUsedError;
  String get description => throw _privateConstructorUsedError;
  String get answer => throw _privateConstructorUsedError;
  DateTime get dateTime => throw _privateConstructorUsedError;
  @JsonKey(nullable: true, defaultValue: false)
  bool? get isExpanable => throw _privateConstructorUsedError;
  List<String>? get nameList => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $SubQuestionCopyWith<SubQuestion> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $SubQuestionCopyWith<$Res> {
  factory $SubQuestionCopyWith(
          SubQuestion value, $Res Function(SubQuestion) then) =
      _$SubQuestionCopyWithImpl<$Res, SubQuestion>;
  @useResult
  $Res call(
      {String id,
      int qNo,
      int? mainQNo,
      String title,
      String description,
      String answer,
      DateTime dateTime,
      @JsonKey(nullable: true, defaultValue: false) bool? isExpanable,
      List<String>? nameList});
}

/// @nodoc
class _$SubQuestionCopyWithImpl<$Res, $Val extends SubQuestion>
    implements $SubQuestionCopyWith<$Res> {
  _$SubQuestionCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? qNo = null,
    Object? mainQNo = freezed,
    Object? title = null,
    Object? description = null,
    Object? answer = null,
    Object? dateTime = null,
    Object? isExpanable = freezed,
    Object? nameList = freezed,
  }) {
    return _then(_value.copyWith(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      qNo: null == qNo
          ? _value.qNo
          : qNo // ignore: cast_nullable_to_non_nullable
              as int,
      mainQNo: freezed == mainQNo
          ? _value.mainQNo
          : mainQNo // ignore: cast_nullable_to_non_nullable
              as int?,
      title: null == title
          ? _value.title
          : title // ignore: cast_nullable_to_non_nullable
              as String,
      description: null == description
          ? _value.description
          : description // ignore: cast_nullable_to_non_nullable
              as String,
      answer: null == answer
          ? _value.answer
          : answer // ignore: cast_nullable_to_non_nullable
              as String,
      dateTime: null == dateTime
          ? _value.dateTime
          : dateTime // ignore: cast_nullable_to_non_nullable
              as DateTime,
      isExpanable: freezed == isExpanable
          ? _value.isExpanable
          : isExpanable // ignore: cast_nullable_to_non_nullable
              as bool?,
      nameList: freezed == nameList
          ? _value.nameList
          : nameList // ignore: cast_nullable_to_non_nullable
              as List<String>?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$_SubQuestionCopyWith<$Res>
    implements $SubQuestionCopyWith<$Res> {
  factory _$$_SubQuestionCopyWith(
          _$_SubQuestion value, $Res Function(_$_SubQuestion) then) =
      __$$_SubQuestionCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String id,
      int qNo,
      int? mainQNo,
      String title,
      String description,
      String answer,
      DateTime dateTime,
      @JsonKey(nullable: true, defaultValue: false) bool? isExpanable,
      List<String>? nameList});
}

/// @nodoc
class __$$_SubQuestionCopyWithImpl<$Res>
    extends _$SubQuestionCopyWithImpl<$Res, _$_SubQuestion>
    implements _$$_SubQuestionCopyWith<$Res> {
  __$$_SubQuestionCopyWithImpl(
      _$_SubQuestion _value, $Res Function(_$_SubQuestion) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? qNo = null,
    Object? mainQNo = freezed,
    Object? title = null,
    Object? description = null,
    Object? answer = null,
    Object? dateTime = null,
    Object? isExpanable = freezed,
    Object? nameList = freezed,
  }) {
    return _then(_$_SubQuestion(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      qNo: null == qNo
          ? _value.qNo
          : qNo // ignore: cast_nullable_to_non_nullable
              as int,
      mainQNo: freezed == mainQNo
          ? _value.mainQNo
          : mainQNo // ignore: cast_nullable_to_non_nullable
              as int?,
      title: null == title
          ? _value.title
          : title // ignore: cast_nullable_to_non_nullable
              as String,
      description: null == description
          ? _value.description
          : description // ignore: cast_nullable_to_non_nullable
              as String,
      answer: null == answer
          ? _value.answer
          : answer // ignore: cast_nullable_to_non_nullable
              as String,
      dateTime: null == dateTime
          ? _value.dateTime
          : dateTime // ignore: cast_nullable_to_non_nullable
              as DateTime,
      isExpanable: freezed == isExpanable
          ? _value.isExpanable
          : isExpanable // ignore: cast_nullable_to_non_nullable
              as bool?,
      nameList: freezed == nameList
          ? _value._nameList
          : nameList // ignore: cast_nullable_to_non_nullable
              as List<String>?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$_SubQuestion implements _SubQuestion {
  _$_SubQuestion(
      {required this.id,
      required this.qNo,
      this.mainQNo,
      required this.title,
      required this.description,
      required this.answer,
      required this.dateTime,
      @JsonKey(nullable: true, defaultValue: false) this.isExpanable,
      final List<String>? nameList})
      : _nameList = nameList;

  factory _$_SubQuestion.fromJson(Map<String, dynamic> json) =>
      _$$_SubQuestionFromJson(json);

  @override
  final String id;
  @override
  final int qNo;
  @override
  final int? mainQNo;
  @override
  final String title;
  @override
  final String description;
  @override
  final String answer;
  @override
  final DateTime dateTime;
  @override
  @JsonKey(nullable: true, defaultValue: false)
  final bool? isExpanable;
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
    return 'SubQuestion(id: $id, qNo: $qNo, mainQNo: $mainQNo, title: $title, description: $description, answer: $answer, dateTime: $dateTime, isExpanable: $isExpanable, nameList: $nameList)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_SubQuestion &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.qNo, qNo) || other.qNo == qNo) &&
            (identical(other.mainQNo, mainQNo) || other.mainQNo == mainQNo) &&
            (identical(other.title, title) || other.title == title) &&
            (identical(other.description, description) ||
                other.description == description) &&
            (identical(other.answer, answer) || other.answer == answer) &&
            (identical(other.dateTime, dateTime) ||
                other.dateTime == dateTime) &&
            (identical(other.isExpanable, isExpanable) ||
                other.isExpanable == isExpanable) &&
            const DeepCollectionEquality().equals(other._nameList, _nameList));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      id,
      qNo,
      mainQNo,
      title,
      description,
      answer,
      dateTime,
      isExpanable,
      const DeepCollectionEquality().hash(_nameList));

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_SubQuestionCopyWith<_$_SubQuestion> get copyWith =>
      __$$_SubQuestionCopyWithImpl<_$_SubQuestion>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$_SubQuestionToJson(
      this,
    );
  }
}

abstract class _SubQuestion implements SubQuestion {
  factory _SubQuestion(
      {required final String id,
      required final int qNo,
      final int? mainQNo,
      required final String title,
      required final String description,
      required final String answer,
      required final DateTime dateTime,
      @JsonKey(nullable: true, defaultValue: false) final bool? isExpanable,
      final List<String>? nameList}) = _$_SubQuestion;

  factory _SubQuestion.fromJson(Map<String, dynamic> json) =
      _$_SubQuestion.fromJson;

  @override
  String get id;
  @override
  int get qNo;
  @override
  int? get mainQNo;
  @override
  String get title;
  @override
  String get description;
  @override
  String get answer;
  @override
  DateTime get dateTime;
  @override
  @JsonKey(nullable: true, defaultValue: false)
  bool? get isExpanable;
  @override
  List<String>? get nameList;
  @override
  @JsonKey(ignore: true)
  _$$_SubQuestionCopyWith<_$_SubQuestion> get copyWith =>
      throw _privateConstructorUsedError;
}
