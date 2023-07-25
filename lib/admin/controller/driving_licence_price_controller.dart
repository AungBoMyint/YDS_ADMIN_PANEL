import 'dart:async';
import 'dart:developer';
import 'package:YDS/models/object_models/price/cost.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dartz/dartz.dart';
import 'package:get/get.dart';
import '../../service/query.dart';

class DrivingLicencePriceController extends GetxController {
  Either<Cost, Cost?> selectedDLCost = right(null);
  //Left refer to View
  //Right refer to Upload,Update
  RxList<Cost> dlCosts = <Cost>[].obs;

  Rxn<Query<Cost>> dlCostQuery = Rxn<Query<Cost>>();

  var itemsFetchLoading = false.obs;

  RxList<String> itemsSelectedRow = <String>[].obs;

  var itemsSelectedAll = false.obs;

  void setSelectedCourse(Either<Cost, Cost?> item) => selectedDLCost = item;

  void setItemsSelectedRow(Cost item) {
    if (itemsSelectedRow.contains(item.id)) {
      itemsSelectedRow.remove(item.id);
    } else {
      itemsSelectedRow.add(item.id);
    }
  }

  void setItemsSelectedAll(List<Cost>? items) {
    itemsSelectedAll.value = items == null ? false : true;
    itemsSelectedRow.value =
        items == null ? [] : items.map((e) => e.id).toList();
  }

  Future<void> getItems(Query<Cost> query) async {
    dlCostQuery.value = query;
    itemsFetchLoading.value = true;
    try {
      final value = await query.get();
      dlCosts.value = value.docs.map((e) => e.data()).toList();
      log("Total Costs: ${dlCosts.length}");
    } catch (e) {
      log("$e");
    }

    itemsFetchLoading.value = false;
  }

  Future<void> startGetItems() async {
    if (dlCosts.isEmpty) {
      await getItems(drivingLicenceCostQuery());
    }
  }
}
