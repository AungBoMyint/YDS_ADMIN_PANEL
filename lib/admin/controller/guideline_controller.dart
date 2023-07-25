import 'dart:async';
import 'dart:developer';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:YDS/models/object_models/question/question.dart';
import 'package:YDS/models/object_models/question/sub_question.dart';
import '../../models/guideline_category.dart';
import '../../models/guideline_item.dart';
import '../../service/query.dart';
import '../utils/debouncer.dart';

class GuideLineController extends GetxController {
  Either<GuideLineCategory, GuideLineCategory?> selectedGuideLineCategory =
      right(null);
  Either<GuideLineItem, GuideLineItem?> selectedGuideLineItem = right(null);
  //Left refer to View
  //Right refer to Upload,Update
  RxList<GuideLineCategory> guideLineCategories = <GuideLineCategory>[].obs;
  RxList<GuideLineCategory> searchGuideLineCategory = <GuideLineCategory>[].obs;
  RxList<GuideLineItem> guideLineItems = <GuideLineItem>[].obs;
  RxList<GuideLineItem> searchGuideLineItem = <GuideLineItem>[].obs;

  Rxn<Query<GuideLineCategory>> guideLineCategoryQuery =
      Rxn<Query<GuideLineCategory>>();
  Rxn<Query<GuideLineItem>> guideLineItemQuery = Rxn<Query<GuideLineItem>>();
  final debouncer = Debouncer(milliseconds: 800);
  /* FirestoreQueryBuilderSnapshot<Category>? sliderSnapshot;
  FirestoreQueryBuilderSnapshot<ItemType>? typeSnapshot;
  FirestoreQueryBuilderSnapshot<ExpertModel>? itemsSnapshot; */

  var guideLineItemScrollLoading = false.obs;
  var guideLineCategoryScrollLoading = false.obs;
  var guideLineItemFetchLoading = false.obs;
  var guideLineCategoryFetchLoading = false.obs;

  RxList<String> guideLineItemSelectedRow = <String>[].obs;
  RxList<String> guideLineCategorySelectedRow = <String>[].obs;

  var guideLineItemSelectedAll = false.obs;
  var guideLineCategorySelectedAll = false.obs;

  void setSelectedGuideLineCategory(
          Either<GuideLineCategory, GuideLineCategory?> item) =>
      selectedGuideLineCategory = item;
  void setSelectedGuideLineItem(Either<GuideLineItem, GuideLineItem?> item) =>
      selectedGuideLineItem = item;

  void startGuideLineCategorySearch(String value) {
    if (value.isNotEmpty) {
      getGuideLineCategory(glCategoryQuery()
          .where("nameList", arrayContainsAny: [value.toLowerCase()]));
    } else {
      getGuideLineCategory(glCategoryQuery());
    }
  }

  void startGuideLineItemSearch(String value) {
    if (value.isNotEmpty) {
      getGuideLineItem(
          glItemQuery(selectedGuideLineCategory.getOrElse(() => null)?.id ?? "")
              .where("nameList", arrayContainsAny: [value.toLowerCase()]));
    } else {
      getGuideLineItem(
        glItemQuery(selectedGuideLineCategory.getOrElse(() => null)?.id ?? ""),
      );
    }
  }

  void setGuideLineCategorySelectedRow(GuideLineCategory item) {
    if (guideLineCategorySelectedRow.contains(item.id)) {
      guideLineCategorySelectedRow.remove(item.id);
    } else {
      guideLineCategorySelectedRow.add(item.id);
    }
  }

  void setGuideLineItemSelectedRow(GuideLineItem item) {
    if (guideLineItemSelectedRow.contains(item.id)) {
      guideLineItemSelectedRow.remove(item.id);
    } else {
      guideLineItemSelectedRow.add(item.id);
    }
  }

  void setGuideLineCategorySelectedAll(List<GuideLineCategory>? items) {
    guideLineCategorySelectedAll.value = items == null ? false : true;
    guideLineCategorySelectedRow.value =
        items == null ? [] : items.map((e) => e.id).toList();
  }

  void setGuideLineItemSelectedAll(List<GuideLineItem>? items) {
    guideLineItemSelectedAll.value = items == null ? false : true;
    guideLineItemSelectedRow.value =
        items == null ? [] : items.map((e) => e.id).toList();
  }

  Future<void> getGuideLineCategory(Query<GuideLineCategory> query) async {
    guideLineCategoryQuery.value = query;
    guideLineCategoryFetchLoading.value = true;
    try {
      final value = await query.get();
      guideLineCategories.value = value.docs.map((e) => e.data()).toList();
      log("Total GuideLineCategories: ${guideLineCategories.length}");
    } catch (e) {
      print("========$e");
    }

    guideLineCategoryFetchLoading.value = false;
  }

  Future<void> getGuideLineItem(Query<GuideLineItem> query) async {
    guideLineItemQuery.value = query;
    guideLineItemFetchLoading.value = true;
    try {
      final value = await query.get();
      guideLineItems.value = value.docs.map((e) => e.data()).toList();
      log("Total Guide Line Items: ${guideLineItems.length}");
    } catch (e) {
      print("====$e");
    }

    guideLineItemFetchLoading.value = false;
  }

  void setGuideLineCategoryScrollControllerListener(ScrollController scroll) {
    scroll.addListener(() {
      if (scroll.position.pixels == scroll.position.maxScrollExtent) {
        if (!(guideLineCategoryScrollLoading.value)) {
          guideLineCategoryScrollLoading.value = true;
          debugPrint(
              "************GuideLineCategory Pagination are fetching......");
          glCategoryQuery()
              .startAfter([guideLineCategories.last.dateTime])
              .get()
              .then((value) {
                guideLineCategories
                    .addAll(value.docs.map((e) => e.data()).toList());
                guideLineCategoryScrollLoading.value = false;
              })
              .onError((error, stackTrace) {
                debugPrint("$error");
              });
        }
      }
    });
  }

  void setGuideLineItemScrollControllerListener(ScrollController scroll) {
    scroll.addListener(() {
      if (scroll.position.pixels == scroll.position.maxScrollExtent) {
        if (!(guideLineItemScrollLoading.value)) {
          guideLineItemScrollLoading.value = true;
          debugPrint(
              "************Guide Line Item Pagination are fetching......");
          guideLineItemQuery.value!
              .startAfter([guideLineItems.last.dateTime])
              .get()
              .then((value) {
                guideLineItems.addAll(value.docs.map((e) => e.data()).toList());
                guideLineItemScrollLoading.value = false;
              })
              .onError((error, stackTrace) {
                debugPrint("$error");
              });
        }
      }
    });
  }

  Future<void> startGetGuideLineCategory() async {
    if (guideLineCategories.isEmpty) {
      await getGuideLineCategory(glCategoryQuery());
    }
  }

  Future<void> startGetGuideLineItem() async {
    if (guideLineItems.isEmpty) {
      await getGuideLineItem(glItemQuery(
          selectedGuideLineCategory.getOrElse(() => null)?.id ?? ""));
    }
  }
}
