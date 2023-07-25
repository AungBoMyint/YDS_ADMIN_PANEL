import 'dart:async';
import 'dart:developer';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:YDS/models/object_models/item.dart';
import '../../service/query.dart';
import '../utils/debouncer.dart';

class CourseController extends GetxController {
  Either<ItemModel, ItemModel?> selectedCourse = right(null);
  //Left refer to View
  //Right refer to Upload,Update
  RxList<ItemModel> courses = <ItemModel>[].obs;
  RxList<ItemModel> searchCourse = <ItemModel>[].obs;

  Rxn<Query<ItemModel>> itemsQuery = Rxn<Query<ItemModel>>();
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

  void setSelectedCourse(Either<ItemModel, ItemModel?> item) =>
      selectedCourse = item;
  void removeSelectedRow() {}
  void startItemSearch(String value) {
    if (value.isNotEmpty) {
      getItems(allCourseQuery()
          .where("nameList", arrayContainsAny: [value.toLowerCase()]));
    } else {
      getItems(allCourseQuery());
    }
  }

  void setItemsSelectedRow(ItemModel item) {
    if (itemsSelectedRow.contains(item.id)) {
      itemsSelectedRow.remove(item.id);
    } else {
      itemsSelectedRow.add(item.id);
    }
  }

  void setItemsSelectedAll(List<ItemModel>? items) {
    itemsSelectedAll.value = items == null ? false : true;
    itemsSelectedRow.value =
        items == null ? [] : items.map((e) => e.id).toList();
  }

  Future<void> getItems(Query<ItemModel> query) async {
    itemsQuery.value = query;
    itemsFetchLoading.value = true;
    try {
      final value = await query.get();
      courses.value = value.docs.map((e) => e.data()).toList();
      log("Total Courses: ${courses.length}");
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
          allCourseQuery()
              .startAfter([courses.last.deliverytime])
              .get()
              .then((value) {
                courses.addAll(value.docs.map((e) => e.data()).toList());
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
    if (courses.isEmpty) {
      await getItems(allCourseQuery());
    }
  }
}
