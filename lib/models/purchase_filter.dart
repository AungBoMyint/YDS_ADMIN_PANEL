import 'package:YDS/models/purchase_filter_type.dart';

class PurchaseFilter {
  final PurchaseFilterType pft;
  final String name;
  PurchaseFilter({required this.pft, required this.name});
}

List<PurchaseFilter> purchaseFilters = [
  PurchaseFilter(pft: PurchaseFilterType.cashon(), name: "Cash On"),
  PurchaseFilter(pft: PurchaseFilterType.prepay(), name: "Prepay"),
];
