import 'package:YDS/admin/utils/show_loading.dart';
import 'package:YDS/service/api.dart';
import 'package:YDS/service/reference.dart';
import 'package:get/get.dart';

class PushNotificationController extends GetxController {
  RxList<Map<String, dynamic>> notificaiton = <Map<String, dynamic>>[].obs;
  var notificationLoading = false.obs;

  startGetNotification() async {
    if (notificaiton.isEmpty) {
      notificationLoading.value = true;
      final snapshot = await notificationCollection().get();
      notificaiton.value =
          snapshot.docs.map((e) => e.data() as Map<String, dynamic>).toList();
      notificationLoading.value = false;
    }
  }

  Future<void> sentNotification(String title, String body) async {
    showLoading(Get.context!);
    await Future.delayed(Duration.zero);
    Api.sendPushToAllUser(title, body).then((value) async {
      await notificationCollection().doc().set({
        "title": title,
        "body": body,
      });
      notificaiton.add({
        "title": title,
        "body": body,
      });
      hideLoading(Get.context!);
      if (Get.isDialogOpen == true) {
        hideLoading(Get.context!);
      }
      await Future.delayed(Duration.zero);
      successSnap("Push notificaitn is successful.");
    }).onError((error, stackTrace) {
      errorSnap("Push notificaitn is failed.");
      print("===========NotificationError:$error");
    });
  }
}
