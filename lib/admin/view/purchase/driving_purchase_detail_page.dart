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

class DrivingPurchaseDetailPage extends StatelessWidget {
  const DrivingPurchaseDetailPage({super.key});

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
    final drivingLicencePurchase =
        purchaseController.selectedDrivingForm.getOrElse(() => null);
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
                    text: "← Driving Licence Purchase/",
                    style: textTheme.displayMedium?.copyWith(
                      fontSize: 25,
                      color: Colors.blue,
                    ),
                    recognizer: TapGestureRecognizer()
                      ..onTap = () {
                        controller
                            .changePageType(PageType.drivingLicencePurchase());
                      },
                  ),
                ),
                //paytype
                rowWidget(
                    left: "Payment Type",
                    right: getPayType(
                        !(drivingLicencePurchase?.bankSlipImage == null)),
                    width: width),
                verticalSpace(),
                !(drivingLicencePurchase?.bankSlipImage == null)
                    ? rowWidget(
                        left: "Bank Slip Screenshot",
                        right: bankSlipImageWidget(
                            drivingLicencePurchase?.bankSlipImage, context),
                        width: width,
                      )
                    : const SizedBox(),
                !(drivingLicencePurchase?.bankSlipImage == null)
                    ? verticalSpace()
                    : const SizedBox(),
                //Name
                rowText(
                  left: "နာမည်:",
                  right: drivingLicencePurchase?.name ?? "",
                  width: width,
                ),
                verticalSpace(),
                //Father Name
                rowText(
                    left: "အဖအမည်:",
                    right: drivingLicencePurchase?.fatherName ?? "",
                    width: width),
                verticalSpace(),
                rowText(
                    left: "မွေးနှစ်:",
                    right: drivingLicencePurchase?.dateOfBirth ?? "",
                    width: width),
                verticalSpace(),
                //ID-NO
                rowText(
                    left: "မှတ်ပုံတင်အမှတ်:",
                    right: drivingLicencePurchase?.idNo ?? "",
                    width: width),
                verticalSpace(),
                //Address
                rowText(
                    left: "နေရပ်လိပ်စာ:",
                    right: drivingLicencePurchase?.address ?? "",
                    width: width),
                verticalSpace(),
                //Phone Number
                rowText(
                    left: "ဖုန်းနံပါတ်:",
                    right: drivingLicencePurchase?.phoneNumber ?? "",
                    width: width),
                verticalSpace(),
                //Course
                rowText(
                    left: "လိုင်စင်အမှတ်:",
                    right: drivingLicencePurchase?.licenceNo ?? "",
                    width: width),
                verticalSpace(),
                //car gear
                rowText(
                    left: "လိုင်စင်ကုန်ဆုံးရက်:",
                    right: drivingLicencePurchase?.licenceExpiredDate ?? "",
                    width: width),
                verticalSpace(),
                //class date
                rowText(
                    left: "ဆောင်ရွက်လိုသောလိုင်စင်:",
                    right: drivingLicencePurchase?.licenceType ?? "",
                    width: width),
                verticalSpace(),
                //time
                rowText(
                    left: "ဆောင်ရွက်လိုသောဝန်ဆောင်မှု:",
                    right: drivingLicencePurchase?.serviceType ?? "",
                    width: width),
                verticalSpace(),

                //course fee
                rowText(
                    left: "သင်တန်းကြေး:",
                    right: "${drivingLicencePurchase?.cost}Ks",
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
