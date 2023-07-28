import 'package:freezed_annotation/freezed_annotation.dart';

part 'purchase_filter_type.freezed.dart';

@freezed
class PurchaseFilterType with _$PurchaseFilterType {
  factory PurchaseFilterType.initial() = _Initial;
  factory PurchaseFilterType.prepay() = _Prepay;
  factory PurchaseFilterType.cashon() = _Cashon;
  factory PurchaseFilterType.new() = _New;
  factory PurchaseFilterType.confirm() = _Confirm;
}
