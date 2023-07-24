import 'package:get/get.dart';
import 'package:pizza/admin/controller/overview_related_controller.dart';
import 'package:pizza/admin/controller/question_controller.dart';
import 'package:pizza/admin/controller/reward_product_controller.dart';
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
  }
}
