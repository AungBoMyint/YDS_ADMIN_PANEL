import 'package:YDS/admin/view/dlprice/carlicence_price_page.dart';
import 'package:YDS/admin/view/dlprice/driving_licence_price_page.dart';
import 'package:YDS/admin/view/guide_line/allguideline_item_page.dart';
import 'package:YDS/admin/view/guide_line/guideline_item_page.dart';
import 'package:YDS/admin/view/notification/notification_page.dart';
import 'package:YDS/admin/view/purchase/car_purchase_detail_page.dart';
import 'package:YDS/admin/view/purchase/car_purchase_page.dart';
import 'package:YDS/admin/view/purchase/course_purchase_detail_page.dart';
import 'package:YDS/admin/view/purchase/course_purchase_page.dart';
import 'package:YDS/admin/view/purchase/driving_purchase_detail_page.dart';
import 'package:YDS/admin/view/purchase/driving_purchase_page.dart';
import 'package:YDS/admin/view/purchase/reward_purchase_detail_page.dart';
import 'package:YDS/admin/view/purchase/reward_purchase_page.dart';
import 'package:YDS/admin/view/user/customers_page.dart';
import 'package:YDS/admin/view/user/update_profile_page.dart';
import 'package:dartz/dartz.dart' hide State;
import 'package:flutter/material.dart' hide DrawerHeader;
import 'package:get/get.dart';
import 'package:YDS/admin/view/course/course_page.dart';
import 'package:YDS/admin/view/main_question/main_question_page.dart';
import 'package:YDS/admin/view/main_question/sub_question_page.dart';
import 'package:YDS/admin/view/reward/reward_product_page.dart';
import 'package:YDS/admin/view/user/add_customer_page.dart';
import 'dart:developer';
import '../../constant/icon.dart';
import '../../models/rbpoint.dart';
import '../../service/notification_service.dart';
import '../../theme/app_theme.dart';
import '../controller/admin_login_controller.dart';
import '../controller/admin_ui_controller.dart';
import '../utils/func.dart';
import '../utils/space.dart';
import '../widgets/body_action_bar.dart';
import '../widgets/drawer_items.dart';
import 'guide_line/guideline_category_page.dart';
import 'overview/overview_page.dart';
import 'user_profile_page.dart';

class AdminMainScreen extends StatefulWidget {
  const AdminMainScreen({super.key});

  @override
  State<AdminMainScreen> createState() => _AdminMainScreenState();
}

class _AdminMainScreenState extends State<AdminMainScreen> {
  @override
  void initState() {
    FirebaseMessagingService.getToken();
    FirebaseMessagingService.requestPermission();
    FirebaseMessagingService.setUpFullNotification();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final AdminUiController adminUiController = Get.find();
    final size = MediaQuery.of(context).size;
    log("Screen Width: ${size.width}\n Screen Height: ${size.height}");
    const girlNetworkImage =
        "https://images.unsplash.com/photo-1529626455594-4ff0802cfb7e?ixlib=rb-4.0.3&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=387&q=80";
    final textTheme = Theme.of(context).textTheme;

    return Scaffold(
        key: adminUiController.scaffoldKey,
        /* endDrawer: AddUser, */
        drawer: DrawerItems(
          textTheme: textTheme,
        ),
        body: SafeArea(
          child: LayoutBuilder(builder: (context, constraints) {
            adminUiController.setRBPoint(getRBPoint(constraints.maxWidth));
            return adminUiController.rbPoint.value!.fold(
              (l) => const SizedBox(),
              (r) => r.map(
                xl: (_) => DesktopXLSizeLayout(
                    textTheme: textTheme,
                    verticalSpace: verticalSpace,
                    horizontalSpace: horizontalSpace,
                    girlNetworkImage: girlNetworkImage,
                    adminUiController: adminUiController),
                desktop: (_) => DesktopXLSizeLayout(
                    textTheme: textTheme,
                    verticalSpace: verticalSpace,
                    horizontalSpace: horizontalSpace,
                    girlNetworkImage: girlNetworkImage,
                    adminUiController: adminUiController),
                tablet: (_) => DesktopXLSizeLayout(
                    textTheme: textTheme,
                    verticalSpace: verticalSpace,
                    horizontalSpace: horizontalSpace,
                    girlNetworkImage: girlNetworkImage,
                    adminUiController: adminUiController),
                mobile: (_) => DesktopXLSizeLayout(
                    textTheme: textTheme,
                    verticalSpace: verticalSpace,
                    horizontalSpace: horizontalSpace,
                    girlNetworkImage: girlNetworkImage,
                    adminUiController: adminUiController),
              ),
            );
          }),
        ));
  }
}

/* class MobileTabletSizeLayout extends StatelessWidget {
  const MobileTabletSizeLayout({
    super.key,
    required this.textTheme,
    required this.verticalSpace,
    required this.horizontalSpace,
    required this.girlNetworkImage,
    required this.adminUiController,
  });

  final TextTheme textTheme;
  final SizedBox Function({double? v}) verticalSpace;
  final SizedBox Function({double? v}) horizontalSpace;
  final String girlNetworkImage;
  final AdminUiController adminUiController;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(
        left: 40,
        right: 40,
      ),
      child: Column(
        children: [
          verticalSpace(
            v: 20,
          ),
          //Top Action Bar
          BodyActionBar(
              horizontalSpace: horizontalSpace,
              girlNetworkImage: girlNetworkImage,
              textTheme: textTheme),
          Expanded(
              child: Obx(
            () => adminUiController.pageType.value!.fold(
              (l) => const SizedBox(),
              (r) => r.map(
                initial: (_) => Container(),
                news: (_) => Container(),
                newsSlider: (_) => Container(),
                newsType: (_) => Container(),
                newsItems: (_) => Container(),
                newsItemsAdd: (_) => Container(),
                vlog: (_) => Container(),
                vlogAdd: (_) => Container(),
                customers: (_) => Container(),
                addCustomer: (_) => Container(),
                learning: (_) => Container(),
                therapy: (_) => Container(),
                therapyCategory: (_) => Container(),
                therapyItems: (_) => Container(),
                therapyItemsAdd: (_) => Container(),
                affirmations: (_) => Container(),
                affirmationsCategory: (_) => Container(),
                affirmationsType: (_) => Container(),
                affirmationsItems: (_) => Container(),
                affirmationsItemsAdd: (_) => Container(),
                settings: (_) => Container(),
                updateProfile: (_) => Container(),
              ),
            ),
          )),
        ],
      ),
    );
  }
}
 */
class DesktopXLSizeLayout extends StatelessWidget {
  const DesktopXLSizeLayout({
    super.key,
    required this.textTheme,
    required this.verticalSpace,
    required this.horizontalSpace,
    required this.girlNetworkImage,
    required this.adminUiController,
  });

  final TextTheme textTheme;
  final SizedBox Function({double? v}) verticalSpace;
  final SizedBox Function({double? v}) horizontalSpace;
  final String girlNetworkImage;
  final AdminUiController adminUiController;

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        DrawerItems(
          textTheme: textTheme,
        ),
        //Body
        Expanded(
          flex: 8,
          child: Padding(
            padding: const EdgeInsets.only(
              left: 20,
              right: 20,
            ),
            child: Column(
              children: [
                //Top Action Bar
                BodyActionBar(
                    horizontalSpace: horizontalSpace,
                    girlNetworkImage: girlNetworkImage,
                    textTheme: textTheme),
                Expanded(
                  child: Obx(() => adminUiController.pageType.value!.fold(
                        (l) => const SizedBox(),
                        (r) => r.map(
                          initial: (_) => OverviewPage(
                              verticalSpace: verticalSpace,
                              horizontalSpace: horizontalSpace,
                              girlNetworkImage: girlNetworkImage,
                              textTheme: textTheme),
                          course: (_) => CoursePage(),
                          addCourse: (_) => Container(),
                          rewardProduct: (_) => RewardProductPage(),
                          questions: (_) => MainQuestion(),
                          subQuestions: (_) => SubQuestionPage(),
                          guideLineCategory: (_) => GuidelineCategoryPage(),
                          guideLineItem: (_) => GuideLineItemPage(),
                          allGuideLineItem: (_) => AllGuideLineItemPage(),
                          drivingLicencePrice: (_) => DrivingLicencePricePage(),
                          carLicencePrice: (_) => CarLicencePricePage(),
                          carLicencePurchase: (_) =>
                              CarLicenceFormPurchasePage(),
                          drivingLicencePurchase: (_) =>
                              DrivingLicenceFormPurchasePage(),
                          coursePurchase: (_) => CourseFormPurchasePage(),
                          coursePurchaseDetail: (_) =>
                              CoursePurchaseDetailPage(),
                          drivingLicencePurchaseDetail: (_) =>
                              DrivingPurchaseDetailPage(),
                          carLicencePurchaseDetail: (_) =>
                              CarPurchaseDetailPage(),
                          productPurchase: (_) => RewardPurchasePage(),
                          productPurchaseDetail: (_) =>
                              RewardPurchaseDetailPage(),
                          customer: (_) => CustomersPage(),
                          addCustomer: (_) => AddCustomerPage(),
                          /*  addCustomer: (_) => AddCustomerPage(), */
                          settings: (_) => Container(),
                          updateProfile: (_) => UpdateProfilePage(),
                          sendPushNotification: (_) => NotificationPage(),
                        ),
                      )),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
