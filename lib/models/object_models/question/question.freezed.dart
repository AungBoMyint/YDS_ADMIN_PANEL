// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'question.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

Question _$QuestionFromJson(Map<String, dynamic> json) {
  return _Question.fromJson(json);
}

/// @nodoc
mixin _$Question {
  String get id => throw _privateConstructorUsedError;
  int get qNo => throw _privateConstructorUsedError;
  String get title => throw _privateConstructorUsedError;
  @JsonKey(nullable: true, defaultValue: false)
  bool? get isExpanded => throw _privateConstructorUsedError;
  List<String>? get nameList => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $QuestionCopyWith<Question> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $QuestionCopyWith<$Res> {
  factory $QuestionCopyWith(Question value, $Res Function(Question) then) =
      _$QuestionCopyWithImpl<$Res, Question>;
  @useResult
  $Res call(
      {String id,
      int qNo,
      String title,
      @JsonKey(nullable: true, defaultValue: false) bool? isExpanded,
      List<String>? nameList});
}

/// @nodoc
class _$QuestionCopyWithImpl<$Res, $Val extends Question>
    implements $QuestionCopyWith<$Res> {
  _$QuestionCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? qNo = null,
    Object? title = null,
    Object? isExpanded = freezed,
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
      title: null == title
          ? _value.title
          : title // ignore: cast_nullable_to_non_nullable
              as String,
      isExpanded: freezed == isExpanded
          ? _value.isExpanded
          : isExpanded // ignore: cast_nullable_to_non_nullable
              as bool?,
      nameList: freezed == nameList
          ? _value.nameList
          : nameList // ignore: cast_nullable_to_non_nullable
              as List<String>?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$_QuestionCopyWith<$Res> implements $QuestionCopyWith<$Res> {
  factory _$$_QuestionCopyWith(
          _$_Question value, $Res Function(_$_Question) then) =
      __$$_QuestionCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String id,
      int qNo,
      String title,
      @JsonKey(nullable: true, defaultValue: false) bool? isExpanded,
      List<String>? nameList});
}

/// @nodoc
class __$$_QuestionCopyWithImpl<$Res>
    extends _$QuestionCopyWithImpl<$Res, _$_Question>
    implements _$$_QuestionCopyWith<$Res> {
  __$$_QuestionCopyWithImpl(
      _$_Question _value, $Res Function(_$_Question) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? qNo = null,
    Object? title = null,
    Object? isExpanded = freezed,
    Object? nameList = freezed,
  }) {
    return _then(_$_Question(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      qNo: null == qNo
          ? _value.qNo
          : qNo // ignore: cast_nullable_to_non_nullable
              as int,
      title: null == title
          ? _value.title
          : title // ignore: cast_nullable_to_non_nullable
              as String,
      isExpanded: freezed == isExpanded
          ? _value.isExpanded
          : isExpanded // ignore: cast_nullable_to_non_nullable
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
class _$_Question implements _Question {
  _$_Question(
      {required this.id,
      required this.qNo,
      required this.title,
      @JsonKey(nullable: true, defaultValue: false) this.isExpanded,
      final List<String>? nameList})
      : _nameList = nameList;

  factory _$_Question.fromJson(Map<String, dynamic> json) =>
      _$$_QuestionFromJson(json);

  @override
  final String id;
  @override
  final int qNo;
  @override
  final String title;
  @override
  @JsonKey(nullable: true, defaultValue: false)
  final bool? isExpanded;
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
    return 'Question(id: $id, qNo: $qNo, title: $title, isExpanded: $isExpanded, nameList: $nameList)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_Question &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.qNo, qNo) || other.qNo == qNo) &&
            (identical(other.title, title) || other.title == title) &&
            (identical(other.isExpanded, isExpanded) ||
                other.isExpanded == isExpanded) &&
            const DeepCollectionEquality().equals(other._nameList, _nameList));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, id, qNo, title, isExpanded,
      const DeepCollectionEquality().hash(_nameList));

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_QuestionCopyWith<_$_Question> get copyWith =>
      __$$_QuestionCopyWithImpl<_$_Question>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$_QuestionToJson(
      this,
    );
  }
}

abstract class _Question implements Question {
  factory _Question(
      {required final String id,
      required final int qNo,
      required final String title,
      @JsonKey(nullable: true, defaultValue: false) final bool? isExpanded,
      final List<String>? nameList}) = _$_Question;

  factory _Question.fromJson(Map<String, dynamic> json) = _$_Question.fromJson;

  @override
  String get id;
  @override
  int get qNo;
  @override
  String get title;
  @override
  @JsonKey(nullable: true, defaultValue: false)
  bool? get isExpanded;
  @override
  List<String>? get nameList;
  @override
  @JsonKey(ignore: true)
  _$$_QuestionCopyWith<_$_Question> get copyWith =>
      throw _privateConstructorUsedError;
}
