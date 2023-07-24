import 'package:expandable/expandable.dart';
import 'package:flutter/material.dart' hide DrawerHeader;
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:pizza/admin/widgets/sub_item.dart';

import '../../../constant/data.dart';
import '../../../constant/icon.dart';
import '../../../models/page_type.dart';
import '../../../models/rbpoint.dart';
import '../controller/admin_login_controller.dart';
import '../controller/admin_ui_controller.dart';
import '../utils/space.dart';
import 'bottom_header.dart';
import 'drawer_header.dart';
import 'drawer_item.dart';

class DrawerItems extends GetView<AdminLoginController> {
  const DrawerItems({
    super.key,
    required this.textTheme,
  });

  final TextTheme textTheme;

  @override
  Widget build(BuildContext context) {
    final AdminLoginController alController = Get.find();
    final AdminUiController adminUiController = Get.find();
    final pageType = adminUiController.pageType.value;
    return Expanded(
      flex: adminUiController.rbPoint.value!.getOrElse(() => RBPoint.xl()).map(
          xl: (_) => 2, desktop: (_) => 2, tablet: (_) => 1, mobile: (_) => 1),
      child: LayoutBuilder(builder: (context, constraints) {
        final height = constraints.maxHeight;
        final width = constraints.maxWidth;
        return Container(
          color: Theme.of(context).cardTheme.color,
          height: height,
          width: width,
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                verticalSpace(),
                //DrawerHeader
                DrawerHeader(textTheme: textTheme),
                verticalSpace(),
                Divider(),
                //DrawerItems
                verticalSpace(v: 15),

                verticalSpace(v: 10),
                //Overview
                Obx(() {
                  final pageType = adminUiController.pageType.value!
                      .getOrElse(() => PageType.initial());
                  return DrawerItem(
                    isSvg: false,
                    onTap: () =>
                        adminUiController.changePageType(PageType.initial()),
                    textTheme: textTheme,
                    isSelected: pageType == PageType.initial(),
                    imageIcon: AdminIcon.overview,
                    label: "Overview",
                  );
                }),
                verticalSpace(v: 10),
                //Courses
                Obx(() {
                  final pageType = adminUiController.pageType.value!
                      .getOrElse(() => PageType.initial());
                  return DrawerItem(
                    isSvg: false,
                    onTap: () =>
                        adminUiController.changePageType(PageType.course()),
                    textTheme: textTheme,
                    isSelected: pageType == PageType.course(),
                    imageIcon: AdminIcon.course,
                    label: "Courses",
                  );
                }),
                verticalSpace(v: 10),
                //Reward Product
                Obx(() {
                  final pageType = adminUiController.pageType.value!
                      .getOrElse(() => PageType.initial());
                  return DrawerItem(
                    isSvg: false,
                    onTap: () => adminUiController
                        .changePageType(PageType.rewardProduct()),
                    textTheme: textTheme,
                    isSelected: pageType == PageType.rewardProduct(),
                    imageIcon: AdminIcon.product,
                    label: "Reward Products",
                  );
                }),
                verticalSpace(v: 10),
                //Questioins
                Obx(() {
                  final pageType = adminUiController.pageType.value!
                      .getOrElse(() => PageType.initial());
                  return DrawerItem(
                    isSvg: false,
                    onTap: () =>
                        adminUiController.changePageType(PageType.questions()),
                    textTheme: textTheme,
                    isSelected: pageType == const PageType.questions(),
                    imageIcon: AdminIcon.question,
                    label: "Questions",
                  );
                }),
                verticalSpace(v: 10),
                //GuideLine Categories
                Obx(() {
                  final pageType = adminUiController.pageType.value!
                      .getOrElse(() => PageType.initial());
                  return DrawerItem(
                    isSvg: false,
                    onTap: () => adminUiController
                        .changePageType(PageType.guideLineCategory()),
                    textTheme: textTheme,
                    isSelected: pageType == const PageType.guideLineCategory(),
                    imageIcon: AdminIcon.guideLine,
                    label: "GuideLine Categories",
                  );
                }),
                verticalSpace(v: 10),
                //GuideLine Item
                Obx(() {
                  final pageType = adminUiController.pageType.value!
                      .getOrElse(() => PageType.initial());
                  return DrawerItem(
                    isSvg: false,
                    onTap: () => adminUiController
                        .changePageType(PageType.guideLineItem()),
                    textTheme: textTheme,
                    isSelected: pageType == const PageType.guideLineItem(),
                    imageIcon: AdminIcon.guideLine,
                    label: "GuideLine Items",
                  );
                }),
                verticalSpace(v: 10),
                //Driving Licence Price
                Obx(() {
                  final pageType = adminUiController.pageType.value!
                      .getOrElse(() => PageType.initial());
                  return DrawerItem(
                    isSvg: false,
                    onTap: () => adminUiController
                        .changePageType(PageType.drivingLicencePrice()),
                    textTheme: textTheme,
                    isSelected:
                        pageType == const PageType.drivingLicencePrice(),
                    imageIcon: AdminIcon.guideLine,
                    label: "Driving Licence Price",
                  );
                }),
                verticalSpace(v: 10),
                //Car Licence Price
                Obx(() {
                  final pageType = adminUiController.pageType.value!
                      .getOrElse(() => PageType.initial());
                  return DrawerItem(
                    isSvg: false,
                    onTap: () => adminUiController
                        .changePageType(PageType.carLicencePrice()),
                    textTheme: textTheme,
                    isSelected: pageType == const PageType.carLicencePrice(),
                    imageIcon: AdminIcon.guideLine,
                    label: "Car Licence Price",
                  );
                }),
                verticalSpace(v: 10),
                //Users
                Obx(() {
                  final pageType = adminUiController.pageType.value!
                      .getOrElse(() => PageType.initial());
                  return DrawerItem(
                    isSvg: false,
                    onTap: () => adminUiController
                        .changePageType(PageType.addCustomer()),
                    textTheme: textTheme,
                    isSelected: pageType == PageType.addCustomer(),
                    imageIcon: AdminIcon.users,
                    label: "Users",
                  );
                }),
                verticalSpace(v: 10),
                Divider(),
                verticalSpace(),
                DrawerItem(
                  isSvg: false,
                  onTap: () => alController.signOut(),
                  textTheme: textTheme,
                  isSelected: false,
                  imageIcon: AdminIcon.logout,
                  label: "Log out",
                ),
              ],
            ),
          ),
          /*  ), */
        );
      }),
    );
  }
}
