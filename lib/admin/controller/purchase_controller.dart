import 'dart:async';
import 'dart:developer';
import 'package:YDS/models/object_models/form/car_licence_form.dart';
import 'package:YDS/models/object_models/form/course_form.dart';
import 'package:YDS/models/object_models/form/driving_licence_form.dart';
import 'package:YDS/models/purchase_filter_type.dart';
import 'package:YDS/service/collection_name.dart';
import 'package:YDS/service/reference.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:YDS/models/object_models/item.dart';
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

  final debouncer = Debouncer(milliseconds: 800);

  RxList<String> courseFormsSelectedRow = <String>[].obs;

  var courseFormsSelectedAll = false.obs;

  void setPurchaseFilterType(PurchaseFilterType? p) {
    purchaseFilterType.value = p;
    if (p == null) {
      searchCourseForms.value = courseForms;
    } else if (!(p == null) && p == PurchaseFilterType.cashon()) {
      searchCourseForms.value =
          courseForms.where((e) => e.bankSlipImage == null).toList();
    } else if (!(p == null) && p == PurchaseFilterType.prepay()) {
      searchCourseForms.value =
          courseForms.where((e) => e.bankSlipImage != null).toList();
    }
  }

  //driving purchase filter
  void setDrivingPurchaseFilterType(PurchaseFilterType? p) {
    drivingPurchaseFilterType.value = p;
    if (p == null) {
      searchDrivingLicenceForms.value = drivingLicenceForms;
    } else if (!(p == null) && p == PurchaseFilterType.cashon()) {
      searchDrivingLicenceForms.value =
          drivingLicenceForms.where((e) => e.bankSlipImage == null).toList();
    } else if (!(p == null) && p == PurchaseFilterType.prepay()) {
      searchDrivingLicenceForms.value =
          drivingLicenceForms.where((e) => e.bankSlipImage != null).toList();
    }
  }

  //car purchase filter
  void setCarPurchaseFilterType(PurchaseFilterType? p) {
    carPurchaseFilterType.value = p;
    if (p == null) {
      searchCarLicenceForms.value = carLicenceForms;
    } else if (!(p == null) && p == PurchaseFilterType.cashon()) {
      searchCarLicenceForms.value =
          carLicenceForms.where((e) => e.bankSlipImage == null).toList();
    } else if (!(p == null) && p == PurchaseFilterType.prepay()) {
      searchCarLicenceForms.value =
          carLicenceForms.where((e) => e.bankSlipImage != null).toList();
    }
  }

  void setSelectedCourseForm(Either<CourseForm, CourseForm?> item) =>
      selectedCourseForm = item;
  void setSelectedDrivingForm(
          Either<DrivingLicenceForm, DrivingLicenceForm?> item) =>
      selectedDrivingForm = item;
  void setSelectedCarForm(Either<CarLicenceForm, CarLicenceForm?> item) =>
      selectedCarForm = item;

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
    super.onInit();
  }
}
