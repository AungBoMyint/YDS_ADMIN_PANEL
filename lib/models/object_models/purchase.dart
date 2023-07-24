import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:pizza/models/object_models/reward_product.dart';

import 'purchase_item.dart';

part 'purchase.freezed.dart';
part 'purchase.g.dart';

@freezed
class PurchaseModel with _$PurchaseModel {
  @JsonSerializable(explicitToJson: true)
  factory PurchaseModel({
    required String id,
    @JsonKey(nullable: true) required List<PurchaseItem>? items,
    @JsonKey(nullable: true) List<RewardProduct>? rewardProductList,
    required String name,
    required String email,
    required String phone,
    required String address,
    required String userId,
    List? deliveryTownshipInfo,
    @JsonKey(nullable: true) String? bankSlipImage,
    required String dateTime,
  }) = _PurchaseModel;
  factory PurchaseModel.fromJson(Map<String, dynamic> json) =>
      _$PurchaseModelFromJson(json);
}
