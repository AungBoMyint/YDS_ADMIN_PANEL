import 'dart:async';
import 'dart:developer';
import 'package:YDS/models/object_models/form/car_licence_form.dart';
import 'package:YDS/models/object_models/form/course_form.dart';
import 'package:YDS/models/object_models/form/driving_licence_form.dart';
import 'package:YDS/models/object_models/purchase.dart';
import 'package:YDS/models/purchase_filter_type.dart';
import 'package:YDS/service/collection_name.dart';
import 'package:YDS/service/reference.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:YDS/models/object_models/item.dart';
import '../../service/api.dart';
import '../../service/query.dart';
import '../utils/debouncer.dart';

class PurchaseController extends GetxController {
  Rxn<PurchaseFilterType> purchaseFilterType = Rxn<PurchaseFilterType>(null);
  Rxn<PurchaseFilterType> drivingPurchaseFilterType =
      Rxn<PurchaseFilterType>(null);
  Rxn<PurchaseFilterType> carPurchaseFilterType = Rxn<PurchaseFilterType>(null);
  Either<CourseForm, CourseForm?> selectedCourseForm = right(null);
  Either<DrivingLicenceForm, DrivingLicenceForm?> selectedDrivingForm =
      right(null);
  Either<PurchaseModel, PurchaseModel?> selectedRewardPurchase = right(null);

  Either<CarLicenceForm, CarLicenceForm?> selectedCarForm = right(null);

  var courseFormNewOrders = 0.obs;
  var drivingFormNewOrders = 0.obs;
  var carFormNewOrders = 0.obs;
  //Left refer to View
  //Right refer to Upload,Update
  RxList<CourseForm> courseForms = <CourseForm>[].obs;
  RxList<CourseForm> searchCourseForms = <CourseForm>[].obs;
  //DirvingLicenceForm
  RxList<DrivingLicenceForm> drivingLicenceForms = <DrivingLicenceForm>[].obs;
  RxList<DrivingLicenceForm> searchDrivingLicenceForms =
      <DrivingLicenceForm>[].obs;
  //CarLicenceForm
  RxList<CarLicenceForm> carLicenceForms = <CarLicenceForm>[].obs;
  RxList<CarLicenceForm> searchCarLicenceForms = <CarLicenceForm>[].obs;
  RxList<PurchaseModel> rewardPurchases = <PurchaseModel>[].obs;

  final debouncer = Debouncer(milliseconds: 800);

  RxList<String> courseFormsSelectedRow = <String>[].obs;

  var courseFormsSelectedAll = false.obs;

  void setPurchaseFilterType(PurchaseFilterType? p) {
    purchaseFilterType.value = p;
    var list = List.from(courseForms).map((e) => e as CourseForm).toList();
    if (p == null) {
      searchCourseForms.clear();
      searchCourseForms.value = list;
    } else if (!(p == null) && p == PurchaseFilterType.cashon()) {
      searchCourseForms.clear();
      searchCourseForms.value =
          list.where((e) => e.bankSlipImage == null).toList();
    } else if (!(p == null) && p == PurchaseFilterType.prepay()) {
      searchCourseForms.clear();
      searchCourseForms.value =
          list.where((e) => e.bankSlipImage != null).toList();
    } else if (!(p == null) && p == PurchaseFilterType.new()) {
      searchCourseForms.clear();
      searchCourseForms.value =
          list.where((e) => e.isConfirmed == false).toList();
    } else if (!(p == null) && p == PurchaseFilterType.confirm()) {
      searchCourseForms.clear();
      searchCourseForms.value =
          list.where((e) => e.isConfirmed == true).toList();
    }
    print("============SearchCourseForm:${searchCourseForms.length}");
    print("============CourseForm:${courseForms.length}");
  }

  //driving purchase filter
  void setDrivingPurchaseFilterType(PurchaseFilterType? p) {
    drivingPurchaseFilterType.value = p;
    var list = List.from(drivingLicenceForms)
        .map((e) => e as DrivingLicenceForm)
        .toList();
    if (p == null) {
      searchDrivingLicenceForms.clear();
      searchDrivingLicenceForms.value = list;
    } else if (!(p == null) && p == PurchaseFilterType.cashon()) {
      searchDrivingLicenceForms.clear();
      searchDrivingLicenceForms.value =
          list.where((e) => e.bankSlipImage == null).toList();
    } else if (!(p == null) && p == PurchaseFilterType.prepay()) {
      searchDrivingLicenceForms.clear();
      searchDrivingLicenceForms.value =
          list.where((e) => e.bankSlipImage != null).toList();
    } else if (!(p == null) && p == PurchaseFilterType.new()) {
      searchDrivingLicenceForms.clear();
      searchDrivingLicenceForms.value =
          list.where((e) => e.isConfirmed == false).toList();
    } else if (!(p == null) && p == PurchaseFilterType.confirm()) {
      searchDrivingLicenceForms.clear();
      searchDrivingLicenceForms.value =
          list.where((e) => e.isConfirmed == true).toList();
    }
  }

  //car purchase filter
  void setCarPurchaseFilterType(PurchaseFilterType? p) {
    carPurchaseFilterType.value = p;
    var list =
        List.from(carLicenceForms).map((e) => e as CarLicenceForm).toList();
    if (p == null) {
      searchCarLicenceForms.clear();
      searchCarLicenceForms.value = list;
    } else if (!(p == null) && p == PurchaseFilterType.cashon()) {
      searchCarLicenceForms.clear();
      searchCarLicenceForms.value =
          list.where((e) => e.bankSlipImage == null).toList();
    } else if (!(p == null) && p == PurchaseFilterType.prepay()) {
      searchCarLicenceForms.clear();
      searchCarLicenceForms.value =
          list.where((e) => e.bankSlipImage != null).toList();
    } else if (!(p == null) && p == PurchaseFilterType.new()) {
      searchCarLicenceForms.clear();
      searchCarLicenceForms.value =
          list.where((e) => e.isConfirmed == false).toList();
    } else if (!(p == null) && p == PurchaseFilterType.confirm()) {
      searchCarLicenceForms.clear();
      searchCarLicenceForms.value =
          list.where((e) => e.isConfirmed == true).toList();
    }
  }

  void setSelectedCourseForm(Either<CourseForm, CourseForm?> item) =>
      selectedCourseForm = item;
  void setSelectedDrivingForm(
          Either<DrivingLicenceForm, DrivingLicenceForm?> item) =>
      selectedDrivingForm = item;
  void setSelectedCarForm(Either<CarLicenceForm, CarLicenceForm?> item) =>
      selectedCarForm = item;
  void setRewardPurchase(Either<PurchaseModel, PurchaseModel?> item) =>
      selectedRewardPurchase = item;

  void startCourseFormsSearch(String value) {
    if (value.isNotEmpty) {
      searchCourseForms.value =
          courseForms.where((e) => e.name.contains(value)).toList();
    } else {
      searchCourseForms.clear();
    }
  }

  void startDrivingFormsSearch(String value) {
    if (value.isNotEmpty) {
      searchDrivingLicenceForms.value =
          drivingLicenceForms.where((e) => e.name.contains(value)).toList();
    } else {
      searchDrivingLicenceForms.clear();
    }
  }

  void startCarFormsSearch(String value) {
    if (value.isNotEmpty) {
      searchCarLicenceForms.value =
          carLicenceForms.where((e) => e.name.contains(value)).toList();
    } else {
      searchCarLicenceForms.clear();
    }
  }

  @override
  void onInit() {
    courseFormPurchaseCollection().snapshots().listen((event) {
      courseForms.value = event.docs.map((e) => e.data()).toList();
      courseFormNewOrders.value = event.docs
          .where((e) => e.data().isConfirmed == false)
          .toList()
          .length;
    });
    drivingLicenceFormPurchaseCollection().snapshots().listen((event) {
      drivingLicenceForms.value = event.docs.map((e) => e.data()).toList();
      drivingFormNewOrders.value = event.docs
          .where((e) => e.data().isConfirmed == false)
          .toList()
          .length;
    });
    carLicenceFormPurchaseCollection().snapshots().listen((event) {
      carLicenceForms.value = event.docs.map((e) => e.data()).toList();
      carFormNewOrders.value = event.docs
          .where((e) => e.data().isConfirmed == false)
          .toList()
          .length;
    });
    productPurchaseCollection().snapshots().listen((event) {
      rewardPurchases.value = event.docs.map((e) => e.data()).toList();
    });
    super.onInit();
  }

  Future<void> confirmEnrollment({
    required String collection,
    required String resourceId,
    required String userId,
    required int cost,
  }) async {
    FirebaseFirestore.instance.collection(collection).doc(resourceId).update({
      'isConfirmed': true,
    }).then((value) async {
      //Then we need to increase,enrolled user's point
      FirebaseFirestore.instance.runTransaction((transaction) async {
        final secureSnapshot = await FirebaseFirestore.instance
            .collection(normalUserCollection)
            .doc(userId)
            .get();
        final previousPoint = secureSnapshot.get("points") as int;
        transaction.update(secureSnapshot.reference, {
          "points": previousPoint + ((cost / 100).round() * 5),
          //If cost = 100 => 5 points
          //   cost = 1000 => 50 points
        });
      });
      await Api.sendPushToUser("သင်တန်းလက်ခံခြင်း",
          "You get ${(cost / 100).round() * 5} points", userId);
    });
  }
}
