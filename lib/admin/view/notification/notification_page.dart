import 'package:YDS/admin/widgets/add_notification/add_notification_form.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../controller/admin_ui_controller.dart';
import '../../controller/push_notification_controller.dart';
import '../../utils/space.dart';
import '../../utils/widgets.dart';

class NotificationPage extends StatefulWidget {
  const NotificationPage({super.key});

  @override
  State<NotificationPage> createState() => _NotificationPageState();
}

class _NotificationPageState extends State<NotificationPage> {
  @override
  Widget build(BuildContext context) {
    final PushNotificationController pnController = Get.find();
    final AdminUiController controller = Get.find();
    final textTheme = Theme.of(context).textTheme;
    final titleTextStyle = textTheme.displayMedium?.copyWith(fontSize: 22);
    final bodyTextStyle = textTheme.displayMedium;
    final size = MediaQuery.of(context).size;
    return Card(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          verticalSpace(),
          //Head Actions
          Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: 20,
            ),
            child: SizedBox(
              height: 80,
              child: Row(
                /*  mainAxisAlignment: MainAxisAlignment.spaceBetween, */
                children: [
                  Expanded(child: Container()),
                  CreateButton(
                    title: "Create Notification",
                    onPressed: () {
                      //TODO:CREATE ITEM
                      Get.dialog(
                        Center(
                          child: SizedBox(
                            height: size.height * 0.45,
                            width: size.width * 0.5,
                            child: Material(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(20)),
                              child: Padding(
                                padding: const EdgeInsets.only(
                                  left: 20,
                                  right: 20,
                                  top: 20,
                                  bottom: 10,
                                ),
                                child: AddPushNotificationForm(),
                              ),
                            ),
                          ),
                        ),
                        barrierColor: Colors.black.withOpacity(0.2),
                      );
                    },
                  ),
                ],
              ),
            ),
          ),
          //Table
          const Divider(),
          Expanded(
            child: Obx(() {
              final notiList = pnController.notificaiton;
              final isLoading = pnController.notificationLoading.value;
              if (isLoading) {
                return loadingWidget();
              }
              if (notiList.isEmpty) {
                return Center(
                  child: Text(
                    'No notifications created yet.',
                    style: TextStyle(fontSize: 18),
                  ),
                );
              }

              return ListView.separated(
                itemBuilder: (context, index) {
                  final data = notiList[index];
                  return ListTile(
                    leading: CircleAvatar(
                      radius: 20,
                      backgroundColor: Color(0xFF5E8F94),
                      child: Center(
                        child: Text(
                          "${index + 1}",
                          style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                    title: Text(
                      data["title"],
                      style: TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    subtitle: Text(
                      data["body"],
                      style: TextStyle(
                        color: Colors.black,
                      ),
                    ),
                  );
                },
                separatorBuilder: (context, index) {
                  return const Divider();
                },
                itemCount: notiList.length,
              );
            }),
          ),
        ],
      ),
    );
  }
}
