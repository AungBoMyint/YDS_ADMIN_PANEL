import 'package:YDS/admin/controller/car_licence_price_controller.dart';
import 'package:YDS/admin/controller/driving_licence_price_controller.dart';
import 'package:YDS/admin/controller/push_notification_controller.dart';
import 'package:YDS/constant/icon.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:YDS/admin/controller/guideline_controller.dart';
import 'package:YDS/admin/utils/extensions.dart';
import 'package:YDS/service/reference.dart';
import 'package:uuid/uuid.dart';
import '../../../models/guideline_item.dart';
import '../../../models/object_models/price/cost.dart';
import '../../utils/func.dart';
import '../../utils/space.dart';
import '../../utils/widgets.dart';

class AddPushNotificationForm extends StatefulWidget {
  const AddPushNotificationForm({
    super.key,
  });

  @override
  State<AddPushNotificationForm> createState() =>
      _AddPushNotificationFormState();
}

class _AddPushNotificationFormState extends State<AddPushNotificationForm> {
  GlobalKey<FormState> formKey = GlobalKey();
  TextEditingController titleTextController = TextEditingController();
  TextEditingController bodyTextController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final PushNotificationController pnController = Get.find();
    return Form(
      key: formKey,
      child: SingleChildScrollView(
        child: Column(
          children: [
            //Title
            TextFormField(
              validator: (v) => stringValidator("Title", v),
              controller: titleTextController,
              decoration: InputDecoration(
                border: dropDownBorder(),
                disabledBorder: dropDownBorder(),
                focusedBorder: dropDownBorder(),
                enabledBorder: dropDownBorder(),
                labelText: "Title",
                floatingLabelBehavior: FloatingLabelBehavior.always,
              ),
            ),
            verticalSpace(),
            TextFormField(
              validator: (v) => stringValidator("Body", v),
              controller: bodyTextController,
              decoration: InputDecoration(
                border: dropDownBorder(),
                disabledBorder: dropDownBorder(),
                focusedBorder: dropDownBorder(),
                enabledBorder: dropDownBorder(),
                labelText: "Body",
                floatingLabelBehavior: FloatingLabelBehavior.always,
              ),
            ),
            verticalSpace(),

            LayoutBuilder(builder: (context, constraints) {
              final width = constraints.maxWidth;
              return SizedBox(
                width: width * 0.5,
                child: ElevatedButton(
                  onPressed: () {
                    if (formKey.currentState?.validate() == true) {
                      pnController.sentNotification(
                          titleTextController.text, bodyTextController.text);
                    }
                  },
                  child: Padding(
                    padding: const EdgeInsets.all(5.0),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Image.asset(
                          AdminIcon.send,
                          width: 30,
                          height: 30,
                        ),
                        horizontalSpace(),
                        Text(
                          "Send",
                          style: GoogleFonts.inter(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: 20,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              );
            }),
            verticalSpace(v: 10),
            ElevatedButton(
              onPressed: () {
                Get.back();
              },
              child: Padding(
                padding: const EdgeInsets.all(5.0),
                child: Text(
                  "Back",
                  style: GoogleFonts.inter(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 20,
                  ),
                ),
              ),
            ).withColor(Colors.red),
          ],
        ),
      ),
    );
  }
}
