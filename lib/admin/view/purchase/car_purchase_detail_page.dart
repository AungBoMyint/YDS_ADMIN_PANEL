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

class CarPurchaseDetailPage extends StatelessWidget {
  const CarPurchaseDetailPage({super.key});

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
    final carLicencePurchase =
        purchaseController.selectedCarForm.getOrElse(() => null);
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
                    text: "← Car Licence Purchase/",
                    style: textTheme.displayMedium?.copyWith(
                      fontSize: 25,
                      color: Colors.blue,
                    ),
                    recognizer: TapGestureRecognizer()
                      ..onTap = () {
                        controller
                            .changePageType(PageType.carLicencePurchase());
                      },
                  ),
                ),
                //paytype
                rowWidget(
                    left: "Payment Type",
                    right: getPayType(
                        !(carLicencePurchase?.bankSlipImage == null)),
                    width: width),
                verticalSpace(),
                !(carLicencePurchase?.bankSlipImage == null)
                    ? rowWidget(
                        left: "Bank Slip Screenshot",
                        right: bankSlipImageWidget(
                            carLicencePurchase?.bankSlipImage, context),
                        width: width,
                      )
                    : const SizedBox(),
                !(carLicencePurchase?.bankSlipImage == null)
                    ? verticalSpace()
                    : const SizedBox(),
                //Name
                rowText(
                  left: "နာမည်:",
                  right: carLicencePurchase?.name ?? "",
                  width: width,
                ),
                verticalSpace(),

                //ID-NO
                rowText(
                    left: "မှတ်ပုံတင်အမှတ်:",
                    right: carLicencePurchase?.idNo ?? "",
                    width: width),
                verticalSpace(),
                //Address
                rowText(
                    left: "နေရပ်လိပ်စာ:",
                    right: carLicencePurchase?.address ?? "",
                    width: width),
                verticalSpace(),
                //Phone Number
                rowText(
                    left: "ဖုန်းနံပါတ်:",
                    right: carLicencePurchase?.phoneNumber ?? "",
                    width: width),
                verticalSpace(),
                //Course
                rowText(
                    left: "ကားအမှတ်:",
                    right: carLicencePurchase?.carNo ?? "",
                    width: width),
                verticalSpace(),
                //car gear
                rowText(
                    left: "လိုင်စင်ကုန်ဆုံးရက်:",
                    right: carLicencePurchase?.carExpiredDate ?? "",
                    width: width),
                verticalSpace(),
                //class date

                //time
                rowText(
                    left: "ကား engin power:",
                    right: carLicencePurchase?.enginPowerType ?? "",
                    width: width),
                verticalSpace(),

                //course fee
                rowText(
                    left: "သင်တန်းကြေး:",
                    right: "${carLicencePurchase?.cost}Ks",
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
