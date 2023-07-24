import 'dart:async';
import 'dart:developer';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pizza/models/object_models/item.dart';
import 'package:pizza/models/object_models/reward_product.dart';
import '../../service/query.dart';
import '../utils/debouncer.dart';

class RewardProductController extends GetxController {
  Either<RewardProduct, RewardProduct?> selectedCourse = right(null);
  //Left refer to View
  //Right refer to Upload,Update
  RxList<RewardProduct> rewardProducts = <RewardProduct>[].obs;
  RxList<RewardProduct> searchRewardProducts = <RewardProduct>[].obs;

  Rxn<Query<RewardProduct>> itemsQuery = Rxn<Query<RewardProduct>>();
  final debouncer = Debouncer(milliseconds: 800);
  /* FirestoreQueryBuilderSnapshot<Category>? sliderSnapshot;
  FirestoreQueryBuilderSnapshot<ItemType>? typeSnapshot;
  FirestoreQueryBuilderSnapshot<ExpertModel>? itemsSnapshot; */

  var sliderScrollLoading = false.obs;
  var typeScrollLoading = false.obs;
  var itemsScrollLoading = false.obs;
  var sliderFetchLoading = false.obs;
  var typeFetchLoading = false.obs;
  var itemsFetchLoading = false.obs;

  RxList<String> sliderSelectedRow = <String>[].obs;
  RxList<String> typeSelectedRow = <String>[].obs;
  RxList<String> itemsSelectedRow = <String>[].obs;
  var sliderSelectedAll = false.obs;
  var typeSelectedAll = false.obs;
  var itemsSelectedAll = false.obs;

  void setSelectedCourse(Either<RewardProduct, RewardProduct?> item) =>
      selectedCourse = item;
  void removeSelectedRow() {}
  void startItemSearch(String value) {
    if (value.isNotEmpty) {
      getItems(rewardProductQuery()
          .where("nameList", arrayContainsAny: [value.toLowerCase()]));
    } else {
      getItems(rewardProductQuery());
    }
  }

  void setItemsSelectedRow(RewardProduct item) {
    if (itemsSelectedRow.contains(item.id)) {
      itemsSelectedRow.remove(item.id);
    } else {
      itemsSelectedRow.add(item.id);
    }
  }

  void setItemsSelectedAll(List<RewardProduct>? items) {
    itemsSelectedAll.value = items == null ? false : true;
    itemsSelectedRow.value =
        items == null ? [] : items.map((e) => e.id).toList();
  }

  Future<void> getItems(Query<RewardProduct> query) async {
    itemsQuery.value = query;
    itemsFetchLoading.value = true;
    try {
      final value = await query.get();
      rewardProducts.value = value.docs.map((e) => e.data()).toList();
      log("Total rewardProducts: ${rewardProducts.length}");
    } catch (e) {
      log("$e");
    }

    itemsFetchLoading.value = false;
  }

  void setItemScrollControllerListener(ScrollController scroll) {
    scroll.addListener(() {
      if (scroll.position.pixels == scroll.position.maxScrollExtent) {
        if (!(itemsScrollLoading.value)) {
          itemsScrollLoading.value = true;
          debugPrint("************Course Pagination are fetching......");
          rewardProductQuery()
              .startAfter([rewardProducts.last.dateTime])
              .get()
              .then((value) {
                rewardProducts.addAll(value.docs.map((e) => e.data()).toList());
                itemsScrollLoading.value = false;
              })
              .onError((error, stackTrace) {
                debugPrint("$error");
              });
        }
      }
    });
  }

  Future<void> startGetItems() async {
    if (rewardProducts.isEmpty) {
      await getItems(rewardProductQuery());
    }
  }
}
