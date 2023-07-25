import 'dart:async';
import 'dart:developer';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../models/object_models/question/question.dart';
import '../../models/object_models/question/sub_question.dart';
import '../../service/query.dart';
import '../utils/debouncer.dart';

class QuestionController extends GetxController {
  Either<Question, Question?> selectedQuestion = right(null);
  Either<SubQuestion, SubQuestion?> selectedSubQuestion = right(null);
  //Left refer to View
  //Right refer to Upload,Update
  RxList<Question> questions = <Question>[].obs;
  RxList<Question> searchQuestion = <Question>[].obs;
  RxList<SubQuestion> subQuestions = <SubQuestion>[].obs;
  RxList<SubQuestion> searchSubQuestion = <SubQuestion>[].obs;

  Rxn<Query<Question>> mainQuestionQuery = Rxn<Query<Question>>();
  Rxn<Query<SubQuestion>> sQuestionQuery = Rxn<Query<SubQuestion>>();
  final debouncer = Debouncer(milliseconds: 800);
  /* FirestoreQueryBuilderSnapshot<Category>? sliderSnapshot;
  FirestoreQueryBuilderSnapshot<ItemType>? typeSnapshot;
  FirestoreQueryBuilderSnapshot<ExpertModel>? itemsSnapshot; */

  var subQuestionScrollLoading = false.obs;
  var itemsScrollLoading = false.obs;
  var subQuestionFetchLoading = false.obs;
  var itemsFetchLoading = false.obs;

  RxList<String> subQuestionSelectedRow = <String>[].obs;
  RxList<String> itemsSelectedRow = <String>[].obs;

  var subQuestionSelectedAll = false.obs;
  var itemsSelectedAll = false.obs;

  void setSelectedQuestion(Either<Question, Question?> item) =>
      selectedQuestion = item;
  void setSelectedSubQuestion(Either<SubQuestion, SubQuestion?> item) =>
      selectedSubQuestion = item;

  void startQuestionSearch(String value) {
    if (value.isNotEmpty) {
      getItems(questionQuery()
          .where("nameList", arrayContainsAny: [value.toLowerCase()]));
    } else {
      getItems(questionQuery());
    }
  }

  void startSubQuestionSearch(String value) {
    if (value.isNotEmpty) {
      getSubQuestion(
          subQuestionQuery(selectedQuestion.getOrElse(() => null)?.id ?? "")
              .where("nameList", arrayContainsAny: [value.toLowerCase()]));
    } else {
      getSubQuestion(
          subQuestionQuery(selectedQuestion.getOrElse(() => null)?.id ?? ""));
    }
  }

  void setItemsSelectedRow(Question item) {
    if (itemsSelectedRow.contains(item.id)) {
      itemsSelectedRow.remove(item.id);
    } else {
      itemsSelectedRow.add(item.id);
    }
  }

  void setSubQuestionSelectedRow(SubQuestion item) {
    if (subQuestionSelectedRow.contains(item.id)) {
      subQuestionSelectedRow.remove(item.id);
    } else {
      subQuestionSelectedRow.add(item.id);
    }
  }

  void setItemsSelectedAll(List<Question>? items) {
    itemsSelectedAll.value = items == null ? false : true;
    itemsSelectedRow.value =
        items == null ? [] : items.map((e) => e.id).toList();
  }

  void setSubQuestionSelectedAll(List<SubQuestion>? items) {
    subQuestionSelectedAll.value = items == null ? false : true;
    subQuestionSelectedRow.value =
        items == null ? [] : items.map((e) => e.id).toList();
  }

  Future<void> getItems(Query<Question> query) async {
    mainQuestionQuery.value = query;
    itemsFetchLoading.value = true;
    try {
      final value = await query.get();
      questions.value = value.docs.map((e) => e.data()).toList();
      log("Total Main Question: ${questions.length}");
    } catch (e) {
      print("========$e");
    }

    itemsFetchLoading.value = false;
  }

  Future<void> getSubQuestion(Query<SubQuestion> query) async {
    sQuestionQuery.value = query;
    subQuestionFetchLoading.value = true;
    try {
      final value = await query.get();
      subQuestions.value = value.docs.map((e) => e.data()).toList();
      log("Total Sub Question: ${questions.length}");
    } catch (e) {
      print("====$e");
    }

    subQuestionFetchLoading.value = false;
  }

  void setMainQuestionScrollControllerListener(ScrollController scroll) {
    scroll.addListener(() {
      if (scroll.position.pixels == scroll.position.maxScrollExtent) {
        if (!(itemsScrollLoading.value)) {
          itemsScrollLoading.value = true;
          debugPrint("************Course Pagination are fetching......");
          questionQuery()
              .startAfter([questions.last.qNo])
              .get()
              .then((value) {
                questions.addAll(value.docs.map((e) => e.data()).toList());
                itemsScrollLoading.value = false;
              })
              .onError((error, stackTrace) {
                debugPrint("$error");
              });
        }
      }
    });
  }

  void setSubQuestionScrollControllerListener(ScrollController scroll) {
    scroll.addListener(() {
      if (scroll.position.pixels == scroll.position.maxScrollExtent) {
        if (!(subQuestionScrollLoading.value)) {
          subQuestionScrollLoading.value = true;
          debugPrint("************Sub Question Pagination are fetching......");
          sQuestionQuery.value!
              .startAfter([subQuestions.last.qNo])
              .get()
              .then((value) {
                subQuestions.addAll(value.docs.map((e) => e.data()).toList());
                subQuestionScrollLoading.value = false;
              })
              .onError((error, stackTrace) {
                debugPrint("$error");
              });
        }
      }
    });
  }

  Future<void> startGetItems() async {
    if (questions.isEmpty) {
      await getItems(questionQuery());
    }
  }

  Future<void> startGetSubQuestion() async {
    if (subQuestions.isEmpty) {
      await getSubQuestion(
          subQuestionQuery(selectedQuestion.getOrElse(() => null)?.id ?? ""));
    }
  }
}
