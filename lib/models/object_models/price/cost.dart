import 'package:json_annotation/json_annotation.dart';

part 'cost.g.dart';

@JsonSerializable()
class Cost {
  final String id;
  final String desc;
  final int cost;
  DateTime? dateTime;
  Cost({
    required this.id,
    required this.desc,
    required this.cost,
    this.dateTime,
  });
  factory Cost.fromJson(Map<String, dynamic> json) => _$CostFromJson(json);

  Map<String, dynamic> toJson() => _$CostToJson(this);
}
