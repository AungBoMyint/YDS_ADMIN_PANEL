import 'package:YDS/admin/controller/car_licence_price_controller.dart';
import 'package:YDS/admin/controller/driving_licence_price_controller.dart';
import 'package:YDS/admin/controller/purchase_controller.dart';
import 'package:get/get.dart';
import 'package:YDS/admin/controller/guideline_controller.dart';
import 'package:YDS/admin/controller/overview_related_controller.dart';
import 'package:YDS/admin/controller/question_controller.dart';
import 'package:YDS/admin/controller/reward_product_controller.dart';
import '../controller/admin_ui_controller.dart';
import '../controller/course_controller.dart';
import '../controller/customer_related_controller.dart';

class AdminBinding extends Bindings {
  @override
  void dependencies() {
    Get.put(AdminUiController());
    Get.put(CustomerRelatedController());
    Get.put(OverviewRelatedController());
    Get.put(CourseController());
    Get.put(RewardProductController());
    Get.put(QuestionController());
    Get.put(GuideLineController());
    Get.put(DrivingLicencePriceController());
    Get.put(CarLicencePriceController());
    Get.put(PurchaseController());
  }
}
