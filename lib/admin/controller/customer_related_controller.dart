import 'dart:developer';
/* import 'dart:html' as html;
 */
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
import '../../models/object_models/user.dart';
import '../../service/database.dart';
import '../../service/reference.dart';
import '../utils/debouncer.dart';
import '../utils/func.dart';
import '../utils/show_loading.dart';
import 'admin_login_controller.dart';
import 'admin_ui_controller.dart';

class CustomerRelatedController extends GetxController {
  var pageStorageKey = PageStorageKey<String>('controllerA');
/*   ScrollController scrollController = ScrollController();
 */
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
    }
  }

  void reset() {
    /* isFileImage.value = true;
    pickedImage.value = "";
    pickedImageError.value = "";
    userNameController.clear();
    emailController.clear();
    passwordController.clear();
    locationController.clear();
    role.value = null;
    roleError.value = "";
    ageController.clearDropDown();
    multiSelectedItems.value = []; */
  }

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

  /*  Future<void> addUser() async {
    final checkImage = checkPickImage();
    final checkRoleError = checkRole();
    if ((form.currentState?.validate() == true) &&
        checkImage &&
        checkRoleError) {
      log("Form is valid");
      showLoading(Get.context!);
      await Future.delayed(Duration.zero);
      registerWithEmailAndPassword(
        email: emailController.text,
        password: passwordController.text,
      ).then((value) async {
        /*  final url = await _database.uploadImage("users", pickedImage.value); */
        final r = role.value == Role.customer ? 0 : 1;
        List<String> subName = [];
        var subList = userNameController.text.split('');
        for (var i = 0; i < subList.length; i++) {
          subName
              .add(userNameController.text.substring(0, i + 1).toLowerCase());
        }
        final authUser = AuthUser(
          id: Uuid().v1(),
          userName: userNameController.text,
          image: url,
          emailAddress: emailController.text,
          password: passwordController.text,
          location: locationController.text,
          area: multiSelectedItems.map((element) => element).toList(),
          lat: 0,
          long: 0,
          status: r,
          nameList: subName,
        );
        await userDocumentReference(authUser.id).set(authUser);
        users.add(authUser);
        hideLoading(Get.context!);
        reset();
        successSnap("Success", message: "User Adding is successful");
      }).catchError((o) {
        hideLoading(Get.context!);
        log("Register error: $o");
      });
    } else {
      log("Form is not valid");
    }
  } */

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
      //we need to first Login to get this user
      /* final userCredential =
          await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: emailController.text,
        password: passwordController.text,
      ); */
      //user name update
      /* if (updateUser.userName != editUser.value!.userName) {
        await userCredential.user?.updateDisplayName(updateUser.userName);
      }
      //user avatar update
      if (updateUser.image != editUser.value!.image) {
        final url =
            ""; /* await _database.uploadImage("users", updateUser.avatar!); */
        await userCredential.user?.updatePhotoURL(url);
        updateUser = updateUser.copyWith(image: url);
      }
      //user email update
      if (updateUser.email != editUser.value!.email) {
        await userCredential.user?.updateEmail(updateUser.email!);
      }
      //user password update
      if (updateUser.password != editUser.value!.password) {
        await userCredential.user?.updatePassword(updateUser.password!);
      } */

      await userDocumentReference(updateUser.id).set(updateUser.toJson());
      final index = users.indexWhere((element) => element.id == updateUser.id);
      users[index] = updateUser;
      hideLoading(Get.context!);
      successSnap("Success", message: "User Updating is successful");
    } else {
      log("Form is not valid");
    }
  }

/*
  Future<void> registerWithEmailAndPassword(
      {required String email, required String password}) async {
    try {
      await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        log('The password provided is too weak.');
      } else if (e.code == 'email-already-in-use') {
        log('The account already exists for that email.');
      }
    } catch (e) {
      log("$e");
    }
  }

  ///------UPDATE CURRENT USER PROFILE-------//
  void initializeUpdateProfile() {
    final password = alController.box.get(passwordKey, defaultValue: "");
    final currentUser = alController.currentUser.value!;
    userNameController.text = currentUser.userName;
    emailController.text = currentUser.email ?? "";
    passwordController.text = password;
    locationController.text = currentUser.location ?? "";
    role.value = currentUser.status == 0 ? Role.customer : Role.admin;
  }
 */
  Future<void> updateProfile() async {
    final checkImage = checkPickImage();
/*     final checkRoleError = checkRole();
 */
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
}
