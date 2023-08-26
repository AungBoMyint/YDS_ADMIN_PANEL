import 'dart:developer';
/* import 'dart:html' as html;
 */
import 'package:YDS/models/object_models/form/driving_licence_form.dart';
import 'package:YDS/models/object_models/purchase.dart';
import 'package:dropdown_textfield/dropdown_textfield.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutterfire_ui/firestore.dart';
import 'package:get/get.dart';
import 'package:hive/hive.dart';
import 'package:image_picker/image_picker.dart';
import 'package:uuid/uuid.dart';

import '../../constant/data.dart';
import '../../models/customer_role.dart';
import '../../models/object_models/form/car_licence_form.dart';
import '../../models/object_models/form/course_form.dart';
import '../../models/object_models/user.dart';
import '../../service/database.dart';
import '../../service/reference.dart';
import '../utils/debouncer.dart';
import '../utils/func.dart';
import '../utils/show_loading.dart';
import 'admin_login_controller.dart';
import 'admin_ui_controller.dart';

class CustomerRelatedController extends GetxController {
  RxList<CourseForm> coursePurchases = <CourseForm>[].obs;
  RxList<DrivingLicenceForm> drivingPurchases = <DrivingLicenceForm>[].obs;
  RxList<CarLicenceForm> carLicencerPurchases = <CarLicenceForm>[].obs;
  RxList<PurchaseModel> rewardPurchases = <PurchaseModel>[].obs;

  var pageStorageKey = PageStorageKey<String>('controllerA');

  final box = Hive.box(loginBox);
  final Database _database = Database();
  final AdminLoginController alController = Get.find();
  final AdminUiController adminUiController = Get.find();
  Rxn<Query<dynamic>> userQuery = Rxn<Query<dynamic>>();
  final debouncer = Debouncer(milliseconds: 800);
  RxList<AuthUser> users = <AuthUser>[].obs;
  TextEditingController searchController = TextEditingController();
  final Rxn<DocumentSnapshot<dynamic>> lastIndex =
      Rxn<DocumentSnapshot<dynamic>>(null);
  Rxn<AuthUser> editUser = Rxn<AuthUser>(null);
  SingleValueDropDownController ageController = SingleValueDropDownController();
  RxList<String> multiSelectedItems = <String>[].obs;

  void startSearch() {
    if (searchController.text.isNotEmpty) {
      getUsers(allUsersExceptCurrentQuery().where("nameList",
          arrayContains: searchController.text.toLowerCase()));
    } else {
      getUsers(allUsersExceptCurrentQuery());
    }
  }

  Query<dynamic> allUsersExceptCurrentQuery() => userCollectionReference()
      .orderBy("emailAddress")
      .orderBy("userName")
      .limit(20);

  var previousScrollOffset = 0.0;
  void setScrollListener(ScrollController scrollController) {
    scrollController.addListener(() {
      if (scrollController.position.pixels ==
          scrollController.position.maxScrollExtent) {
        allUsersExceptCurrentQuery()
            .startAfterDocument(lastIndex.value!)
            .get()
            .then((value) {
          if (value.docs.isNotEmpty) {
            lastIndex.value = value.docs.last;
          }
          users.addAll(
              value.docs.map((e) => AuthUser.fromJson(e.data())).toList());
        });
      }
    });
  }

  void startGetUsers() {
    if (users.isEmpty) {
      getUsers(allUsersExceptCurrentQuery());
    }
  }

  Future<void> getUsers(Query<dynamic> query) async {
    userQuery.value = query;
    final value = await query.get();
    users.value = value.docs.map((e) => AuthUser.fromJson(e.data())).toList();

    lastIndex.value = value.docs.last;
  }

  //---------------------For Adding Customer-----------------
  var isFileImage = true.obs;
  var pickedImage = "".obs;
  var pickedImageError = "".obs;

  /* final Database _database = Database(); */
  final ImagePicker _imagePicker = ImagePicker();
  Rxn<Role> role = Rxn<Role>(null);
  var roleError = "".obs;
  final GlobalKey<FormState> form = GlobalKey();
  TextEditingController userNameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController locationController = TextEditingController();
  TextEditingController pointController = TextEditingController();

  void setEditUser(AuthUser? user, double scrollOffset) {
    previousScrollOffset = scrollOffset;
    reset();
    if (user == null) {
      editUser.value = null;
    } else {
      editUser.value = user;
      //Make initialization
      userNameController.text = user.userName ?? "";
      emailController.text = user.emailAddress ?? '';
      pointController.text = "${user.points}";
      pickedImage.value = user.image ?? '';
      role.value = user.status == 0 ? Role.customer : Role.admin;
      getAllCurrentUserPurchase(user.id);
    }
  }

  void reset() {}

  void changeRole(Role r) {
    role.value = r;
    roleError.value = "";
  }

  Future<void> pickImage() async {
    try {
      final XFile? _file =
          await _imagePicker.pickImage(source: ImageSource.gallery);
      if (!(_file == null)) {
        pickedImage.value = _file.path;
        pickedImageError.value = "";
        isFileImage.value = true;
      }
    } catch (e) {
      print("pickImage error $e");
    }
  }

  String? validator(String? data, String key) =>
      data?.isEmpty == true ? '$key is required.' : null;
  bool checkPickImage() {
    if (pickedImage.value.isNotEmpty) {
      pickedImageError.value = "";
      return true;
    } else {
      pickedImageError.value = "Image must be picked.";
      return false;
    }
  }

  bool checkRole() {
    if (role.value == null) {
      roleError.value = "User Role must be selected at least one";
      log("Role Error: ${roleError.value}");
      return false;
    } else {
      roleError.value = "";
      return true;
    }
  }

  //TODO:TO MAKE LOGIC FOR UPDATE USE
  Future<void> updateUser() async {
    final checkImage = checkPickImage();
    final checkRoleError = checkRole();
    if ((form.currentState?.validate() == true) &&
        checkImage &&
        checkRoleError) {
      List<String> subName = [];
      var subList = userNameController.text.split('');
      for (var i = 0; i < subList.length; i++) {
        subName.add(userNameController.text.substring(0, i + 1).toLowerCase());
      }
      log("Form is valid");
      showLoading(Get.context!);
      await Future.delayed(Duration.zero);
      var updateUser = AuthUser(
        id: editUser.value!.id,
        userName: userNameController.text,
        image: pickedImage.value,
        emailAddress: emailController.text,
        points: int.tryParse(pointController.text) ?? 0,
        status: role.value == Role.customer ? 0 : 1,
        nameList: subName,
        token: editUser.value?.token,
      );
      await userDocumentReference(updateUser.id).set(updateUser.toJson());
      final index = users.indexWhere((element) => element.id == updateUser.id);
      users[index] = updateUser;
      hideLoading(Get.context!);
      successSnap("Success", message: "User Updating is successful");
    } else {
      log("Form is not valid");
    }
  }

  Future<void> updateProfile() async {
    final checkImage = checkPickImage();

    if ((form.currentState?.validate() == true) && checkImage) {
      try {
        showLoading(Get.context!);
        final User user = FirebaseAuth.instance.currentUser!;
        await user.updateDisplayName(userNameController.text);
        /* await user.updateEmail(emailController.text);
        await user.updatePassword(passwordController.text); */
        log("Form is valid");
        final url = await _database.uploadImage("users", pickedImage.value);
        print("=============User Uploaded Image: $url");
        await user.updatePhotoURL(url);
        final r = role.value == Role.customer ? 0 : 1;
        var nameList = getNameList(
            userNameController.text.toLowerCase().removeAllWhitespace);
        final authUser = AuthUser(
          id: alController.currentUser.value!.id,
          userName: userNameController.text,
          image: url,
          emailAddress: emailController.text,
          status: r,
          points: int.tryParse(pointController.text) ?? 0,
          token: editUser.value?.token ?? "",
          nameList: nameList,
        );
        await userDocumentReference(authUser.id).update(authUser.toJson());
        alController.currentUser.value = authUser;
        hideLoading(Get.context!);
        reset();
        successSnap("Success", message: "Profile updating is successful");

        /* adminUiController.setPageType(const PageType.overview()); */
      } on FirebaseAuthException catch (e) {
        hideLoading(Get.context!);
        errorSnack("${e.message}");
      } catch (e) {
        hideLoading(Get.context!);
        errorSnack("$e");
      }
    } else {
      log("Form is not valid");
    }
  }

  Future<void> deleteUser(String id) async {
    try {
      debugPrint("************Delete User ID: $id");
      showLoading(Get.context!);
      await userDocumentReference(id).delete();
      try {
        await FirebaseAuth.instance.currentUser!.delete();
      } catch (e) {
        errorSnack("$e");
      }
      //we also delete document

      hideLoading(Get.context!);
    } on FirebaseAuthException catch (e) {
      hideLoading(Get.context!);
      if (e.code == 'requires-recent-login') {
        errorSnack(
            'The user must reauthenticate before this operation can be executed.');
      }
    } catch (e) {
      hideLoading(Get.context!);
      errorSnack("$e");
    }
  }

  //Get current user's course purchase,car purchase,driving purchase and
  //reward purchase
  Future<void> getAllCurrentUserPurchase(String userId) async {
    //Course Purchases
    final snapshot = await courseFormPurchaseCollection()
        .where("userID", isEqualTo: userId)
        .get();
    coursePurchases.value = snapshot.docs.map((e) => e.data()).toList();
    log("===========Course Purchases: ${coursePurchases.length}");
    //Driving Purchases
    final drivingSnap = await drivingLicenceFormPurchaseCollection()
        .where("userId", isEqualTo: userId)
        .get();
    drivingPurchases.value = drivingSnap.docs.map((e) => e.data()).toList();
    log("===========Driving Purchases: ${drivingPurchases.length}");
    //CarLicence Purchases
    final carSnap = await carLicenceFormPurchaseCollection()
        .where("userId", isEqualTo: userId)
        .get();
    carLicencerPurchases.value = carSnap.docs.map((e) => e.data()).toList();
    log("===========Car Licence Purchases: ${carLicencerPurchases.length}");
    //Reward Purchases
    final rewardSnap = await productPurchaseCollection()
        .where("userId", isEqualTo: userId)
        .get();
    rewardPurchases.value = rewardSnap.docs.map((e) => e.data()).toList();
    log("===========Reward Purchases: ${rewardPurchases.length}");
  }
}
