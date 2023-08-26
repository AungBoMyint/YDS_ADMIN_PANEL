import 'dart:io';

import 'package:dropdown_textfield/dropdown_textfield.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:multi_select_flutter/dialog/multi_select_dialog_field.dart';
import 'package:multi_select_flutter/multi_select_flutter.dart';
import 'package:multi_select_flutter/util/multi_select_item.dart';

import '../../../models/customer_role.dart';
import '../../../models/page_type.dart';
import '../../controller/admin_login_controller.dart';
import '../../controller/admin_ui_controller.dart';
import '../../controller/customer_related_controller.dart';
import '../../utils/constant.dart';
import '../../utils/func.dart';
import '../../utils/space.dart';

class AddCustomerPage extends StatelessWidget {
  const AddCustomerPage({super.key});

  @override
  Widget build(BuildContext context) {
    final AdminLoginController alController = Get.find();
    final AdminUiController adminUiController = Get.find();
    dropDownBorder() => OutlineInputBorder(
            borderSide: BorderSide(
          color: alController.isLightTheme.value
              ? Theme.of(context).dividerColor
              : Colors.grey.shade100,
        ));
    const addImageIcon =
        "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcT7QsDfFzqYkAHGCjGUZI_Q6g27cdw7tF9DO3FveGM&s";
    const girlNetworkImage =
        "https://images.unsplash.com/photo-1529626455594-4ff0802cfb7e?ixlib=rb-4.0.3&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=387&q=80";
    final textTheme = Theme.of(context).textTheme;
    final titleTextStyle = textTheme.displayMedium?.copyWith(fontSize: 22);
    final bodyTextStyle = textTheme.displayMedium;
    final CustomerRelatedController crController = Get.find();
    var labelStyle = textTheme.displayMedium?.copyWith(
      color:
          alController.isLightTheme.value ? Colors.grey : Colors.grey.shade300,
    );
    var floatingLabelStyle = textTheme.displayMedium?.copyWith(
      color:
          alController.isLightTheme.value ? Colors.grey : Colors.grey.shade300,
    );
    return LayoutBuilder(builder: (context, constraints) {
      final width = constraints.maxWidth;
      final height = constraints.maxHeight;
      return Container(
        color: Theme.of(context).cardTheme.color,
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                RichText(
                  text: TextSpan(
                    text: "← Customers/",
                    style: textTheme.displayMedium?.copyWith(
                      fontSize: 25,
                      color: Colors.blue,
                    ),
                    recognizer: TapGestureRecognizer()
                      ..onTap = () {
                        adminUiController.changePageType(PageType.customer());
                      },
                  ),
                ),

                //Top Image,Name,
                Row(
                  children: [
                    //Product Image
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        InkWell(
                          onTap: () => crController.pickImage(),
                          child: Obx(() {
                            return crController.isFileImage.value &&
                                    crController.pickedImage.isNotEmpty
                                ? Image.network(
                                    crController.pickedImage.value,
                                    width: width *
                                        0.25, //for web width,height=> width*0.25,
                                    height: width * 0.25,
                                    fit: BoxFit.cover,
                                  )
                                : !crController.isFileImage.value &&
                                        crController.pickedImage.isNotEmpty
                                    ? Image.network(
                                        crController.pickedImage.value,
                                        /* width: width * 0.25,
                                            height: width * 0.25, */
                                        fit: BoxFit.cover,
                                      )
                                    : Image.network(
                                        addImageIcon,
                                        width: width * 0.25,
                                        height: width * 0.25,
                                        fit: BoxFit.cover,
                                      );
                          }),
                        ),
                        //Image Error
                        Obx(() {
                          return crController.pickedImageError.isNotEmpty
                              ? Padding(
                                  padding: const EdgeInsets.only(
                                    top: 10,
                                  ),
                                  child: Text(
                                    crController.pickedImageError.value,
                                    style: const TextStyle(
                                      color: Colors.red,
                                    ),
                                  ),
                                )
                              : const SizedBox();
                        }),
                      ],
                    ),
                    horizontalSpace(),
                    //Name Description
                    SizedBox(
                      height: height * 0.8,
                      width: width * 0.5,
                      child: Form(
                        key: crController.form,
                        child: SingleChildScrollView(
                          child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                //user name
                                SizedBox(
                                  child: TextFormField(
                                    validator: (v) =>
                                        crController.validator(v, "User Name"),
                                    controller: crController.userNameController,
                                    decoration: InputDecoration(
                                      border: dropDownBorder(),
                                      disabledBorder: dropDownBorder(),
                                      focusedBorder: dropDownBorder(),
                                      enabledBorder: dropDownBorder(),
                                      labelText: "User Name",
                                      labelStyle: labelStyle,
                                      floatingLabelStyle: floatingLabelStyle,
                                    ),
                                  ),
                                ),
                                verticalSpace(),
                                //email address
                                SizedBox(
                                  child: TextFormField(
                                    validator: (v) =>
                                        crController.validator(v, "Email"),
                                    controller: crController.emailController,
                                    decoration: InputDecoration(
                                      border: dropDownBorder(),
                                      disabledBorder: dropDownBorder(),
                                      focusedBorder: dropDownBorder(),
                                      enabledBorder: dropDownBorder(),
                                      labelText: "Email",
                                      labelStyle: labelStyle,
                                      floatingLabelStyle: floatingLabelStyle,
                                    ),
                                  ),
                                ),
                                verticalSpace(),
                                //Points
                                SizedBox(
                                  child: TextFormField(
                                    validator: (v) =>
                                        crController.validator(v, "Points"),
                                    controller: crController.pointController,
                                    decoration: InputDecoration(
                                      border: dropDownBorder(),
                                      disabledBorder: dropDownBorder(),
                                      focusedBorder: dropDownBorder(),
                                      enabledBorder: dropDownBorder(),
                                      labelText: "Points",
                                      labelStyle: labelStyle,
                                      floatingLabelStyle: floatingLabelStyle,
                                    ),
                                  ),
                                ),
                                verticalSpace(),
                                //Select Role, Admin or Customer
                                Obx(() {
                                  final r = crController.role.value;
                                  return LayoutBuilder(
                                      builder: (context, constraints) {
                                    final parentWidth = constraints.maxWidth;
                                    return DropdownButtonFormField<Role>(
                                      dropdownColor:
                                          Theme.of(context).cardTheme.color,
                                      value: r,
                                      alignment:
                                          AlignmentDirectional.centerStart,
                                      autofocus: false,
                                      decoration: InputDecoration(
                                        border: dropDownBorder(),
                                        disabledBorder: dropDownBorder(),
                                        focusedBorder: dropDownBorder(),
                                        enabledBorder: dropDownBorder(),
                                      ),
                                      hint: Align(
                                        alignment: Alignment.centerRight,
                                        child: Text(
                                          "Select Role",
                                          style:
                                              textTheme.displaySmall?.copyWith(
                                            color: Colors.grey.shade600,
                                          ),
                                          textAlign: TextAlign.left,
                                        ),
                                      ),
                                      items: customerRoles.map((e) {
                                        return DropdownMenuItem<Role>(
                                          value: e.role,
                                          child: Text(
                                            e.roleString,
                                            style: textTheme.displaySmall
                                                ?.copyWith(
                                              color: Colors.grey.shade600,
                                            ),
                                          ),
                                        );
                                      }).toList(),
                                      onChanged: (_) =>
                                          crController.changeRole(_!),
                                    );
                                  });
                                }),
                                //Role Error
                                Obx(() {
                                  return crController.roleError.isNotEmpty
                                      ? Padding(
                                          padding: const EdgeInsets.only(
                                            top: 10,
                                          ),
                                          child: Text(
                                            crController.roleError.value,
                                            style: const TextStyle(
                                              color: Colors.red,
                                            ),
                                          ),
                                        )
                                      : const SizedBox();
                                }),
                                verticalSpace(),
                                Align(
                                  alignment: Alignment.bottomRight,
                                  child: ElevatedButton(
                                    onPressed: () => crController.updateUser(),
                                    child: Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Text(
                                        "UPDATE",
                                        style: textTheme.displayMedium
                                            ?.copyWith(color: Colors.white),
                                      ),
                                    ),
                                  ),
                                ),
                                verticalSpace(),
                              ]),
                        ),
                      ),
                    ),
                  ],
                ),
                Obx(() {
                  final courses = crController.coursePurchases;

                  return courses.isNotEmpty ? Divider() : const SizedBox();
                }),
                //Course Purchases
                Obx(() {
                  final courses = crController.coursePurchases;

                  return courses.isNotEmpty
                      ? Text(
                          "Course Purchases: ",
                          style: textTheme.displayLarge,
                        )
                      : const SizedBox();
                }),
                //Course
                Obx(() {
                  final courses = crController.coursePurchases;

                  return courses.isEmpty
                      ? const SizedBox()
                      : ListView.separated(
                          separatorBuilder: (context, index) {
                            return verticalSpace();
                          },
                          shrinkWrap: true,
                          itemCount: crController.coursePurchases.length,
                          itemBuilder: (context, index) {
                            final course = crController.coursePurchases[index];
                            return ListTile(
                              title: Text(
                                course.courseType,
                                style: textTheme.displayMedium,
                              ),
                              trailing: Text(
                                "${course.price.price}Ks",
                                style: textTheme.displayMedium,
                              ),
                            );
                          },
                        );
                }),
                Obx(() {
                  final drivingPurchases = crController.drivingPurchases;
                  return drivingPurchases.isNotEmpty
                      ? Divider()
                      : const SizedBox();
                }),
                //Driving Purchase
                Obx(() {
                  final drivingPurchases = crController.drivingPurchases;
                  return drivingPurchases.isNotEmpty
                      ? Text(
                          "Driving Purchases: ",
                          style: textTheme.displayLarge,
                        )
                      : const SizedBox();
                }),
                //Driving
                Obx(() {
                  final drivingPurchases = crController.drivingPurchases;
                  return drivingPurchases.isEmpty
                      ? const SizedBox()
                      : ListView.separated(
                          separatorBuilder: (context, index) {
                            return verticalSpace();
                          },
                          shrinkWrap: true,
                          itemCount: crController.drivingPurchases.length,
                          itemBuilder: (context, index) {
                            final course = crController.drivingPurchases[index];
                            return ListTile(
                              title: Text(
                                course.licenceType,
                                style: textTheme.displayMedium,
                              ),
                              trailing: Text(
                                "${course.cost}Ks",
                                style: textTheme.displayMedium,
                              ),
                            );
                          },
                        );
                }),
                Obx(() {
                  final carPurchases = crController.carLicencerPurchases;
                  return carPurchases.isNotEmpty ? Divider() : const SizedBox();
                }),
                //Car Licence Purchase
                Obx(() {
                  final carPurchases = crController.carLicencerPurchases;
                  return carPurchases.isNotEmpty
                      ? Text(
                          "Car License Purchases: ",
                          style: textTheme.displayLarge,
                        )
                      : const SizedBox();
                }),
                //Car License
                Obx(() {
                  final carPurchases = crController.carLicencerPurchases;
                  return carPurchases.isEmpty
                      ? const SizedBox()
                      : ListView.separated(
                          separatorBuilder: (context, index) {
                            return verticalSpace();
                          },
                          shrinkWrap: true,
                          itemCount: carPurchases.length,
                          itemBuilder: (context, index) {
                            final course = carPurchases[index];
                            return ListTile(
                              title: Text(
                                course.enginPowerType,
                                style: textTheme.displayMedium,
                              ),
                              trailing: Text(
                                "${course.cost}Ks",
                                style: textTheme.displayMedium,
                              ),
                            );
                          },
                        );
                }),
                Obx(() {
                  final rewardPurchase = crController.rewardPurchases;
                  return rewardPurchase.isNotEmpty
                      ? Divider()
                      : const SizedBox();
                }),
                //Reward Purchase
                Obx(() {
                  final rewardPurchase = crController.rewardPurchases;
                  return rewardPurchase.isNotEmpty
                      ? Text(
                          "Product Purchases: ",
                          style: textTheme.displayLarge,
                        )
                      : const SizedBox();
                }),
                //Car License
                Obx(() {
                  final rewardPurchase = crController.rewardPurchases;
                  return rewardPurchase.isEmpty
                      ? const SizedBox()
                      : ListView.builder(
                          shrinkWrap: true,
                          itemCount: rewardPurchase.length,
                          itemBuilder: (context, index) {
                            final course = rewardPurchase[index];
                            return ListView.separated(
                              itemBuilder: (context, i) {
                                final re = course.rewardProductList?[i];
                                return ListTile(
                                  title: Text(
                                    re?.name ?? "",
                                    style: textTheme.displayMedium,
                                  ),
                                  trailing: Text(
                                    "${re?.requirePoint}Points",
                                    style: textTheme.displayMedium,
                                  ),
                                );
                              },
                              separatorBuilder: (context, index) {
                                return verticalSpace();
                              },
                              itemCount: course.rewardProductList?.length ?? 0,
                            );
                          },
                        );
                }),
              ],
            ),
          ),
        ),
      );
    });
  }
}
