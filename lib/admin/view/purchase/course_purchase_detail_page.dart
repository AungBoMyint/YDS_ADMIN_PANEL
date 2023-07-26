import 'dart:developer';

import 'package:YDS/admin/utils/func.dart';
import 'package:YDS/admin/utils/space.dart';
import 'package:YDS/admin/utils/widgets.dart';
import 'package:data_table_2/data_table_2.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:get/get.dart';

import '../../../models/page_type.dart';
import '../../controller/admin_ui_controller.dart';
import '../../controller/purchase_controller.dart';

class CoursePurchaseDetailPage extends StatelessWidget {
  const CoursePurchaseDetailPage({super.key});

  @override
  Widget build(BuildContext context) {
    final PurchaseController purchaseController = Get.find();
    final size = MediaQuery.of(context).size;
    final AdminUiController controller = Get.find();
    final textTheme = Theme.of(context).textTheme;
    final titleTextStyle = textTheme.displayMedium?.copyWith(fontSize: 22);
    final bodyTextStyle = textTheme.displayMedium;
    dropDownBorder() => const OutlineInputBorder(
            borderSide: BorderSide(
          color: Colors.black,
        ));
    final course = purchaseController.selectedCourseForm.getOrElse(() => null);
    return LayoutBuilder(builder: (context, constraints) {
      final width = constraints.maxWidth;
      return Card(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                RichText(
                  text: TextSpan(
                    text: "← Course Purchase/",
                    style: textTheme.displayMedium?.copyWith(
                      fontSize: 25,
                      color: Colors.blue,
                    ),
                    recognizer: TapGestureRecognizer()
                      ..onTap = () {
                        controller.changePageType(PageType.coursePurchase());
                      },
                  ),
                ),
                //paytype
                rowWidget(
                    left: "Payment Type",
                    right: getPayType(!(course?.bankSlipImage == null)),
                    width: width),
                verticalSpace(),
                !(course?.bankSlipImage == null)
                    ? rowWidget(
                        left: "Bank Slip Screenshot",
                        right:
                            bankSlipImageWidget(course?.bankSlipImage, context),
                        width: width,
                      )
                    : const SizedBox(),
                !(course?.bankSlipImage == null)
                    ? verticalSpace()
                    : const SizedBox(),
                //Name
                rowText(
                  left: "နာမည်:",
                  right: course?.name ?? "",
                  width: width,
                ),
                verticalSpace(),
                //Father Name
                rowText(
                    left: "အဖအမည်:",
                    right: course?.fatherName ?? "",
                    width: width),
                verticalSpace(),
                //ID-NO
                rowText(
                    left: "မှတ်ပုံတင်အမှတ်:",
                    right: course?.idNo ?? "",
                    width: width),
                verticalSpace(),
                //Address
                rowText(
                    left: "နေရပ်လိပ်စာ:",
                    right: course?.address ?? "",
                    width: width),
                verticalSpace(),
                //Phone Number
                rowText(
                    left: "ဖုန်းနံပါတ်:",
                    right: course?.phoneNumber ?? "",
                    width: width),
                verticalSpace(),
                //Course
                rowText(
                    left: "သင်တန်း:",
                    right: course?.courseType ?? "",
                    width: width),
                verticalSpace(),
                //car gear
                rowText(
                    left: "ကား gear:",
                    right: course?.carType ?? "",
                    width: width),
                verticalSpace(),
                //class date
                rowText(
                    left: "သင်တန်းရက်:",
                    right: course?.dayType ?? "",
                    width: width),
                verticalSpace(),
                //time
                rowText(
                    left: "အချိန်:",
                    right: course?.timeType ?? "",
                    width: width),
                verticalSpace(),
                //initial time
                rowText(
                    left: "စတင်မည့်ရက်:",
                    right: getDateTime(course?.initialDay ?? DateTime.now()),
                    width: width),
                verticalSpace(),
                //course fee
                rowText(
                    left: "သင်တန်းကြေး:",
                    right: "${course?.price.desc} ${course?.price.price}Ks",
                    width: width),
                verticalSpace(),
              ],
            ),
          ),
        ),
      );
    });
  }
}
