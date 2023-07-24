import 'package:json_annotation/json_annotation.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'reward_product.freezed.dart';
part 'reward_product.g.dart';

@freezed
class RewardProduct with _$RewardProduct {
  factory RewardProduct({
    required String id,
    required String name,
    @JsonKey(nullable: true) String? description,
    required String image,
    required int requirePoint,
    @JsonKey(nullable: true, defaultValue: 0) int? count,
    DateTime? dateTime,
    List<String>? nameList,
  }) = _RewardProduct;

  factory RewardProduct.fromJson(Map<String, dynamic> json) =>
      _$RewardProductFromJson(json);
}
