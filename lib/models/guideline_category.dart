import 'package:json_annotation/json_annotation.dart';

part 'guideline_category.g.dart';

@JsonSerializable()
class GuideLineCategory {
  final String id;
  final String title;
  final String color;
  final String image;
  final DateTime dateTime;
  List<String>? nameList;
  GuideLineCategory({
    required this.id,
    required this.title,
    required this.color,
    required this.image,
    required this.dateTime,
    this.nameList,
  });

  factory GuideLineCategory.fromJson(Map<String, dynamic> json) =>
      _$GuideLineCategoryFromJson(json);

  Map<String, dynamic> toJson() => _$GuideLineCategoryToJson(this);
}
