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

class RewardPurchaseDetailPage extends StatelessWidget {
  const RewardPurchaseDetailPage({super.key});

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
    final rewardPurchase =
        purchaseController.selectedRewardPurchase.getOrElse(() => null);
    return LayoutBuilder(builder: (context, constraints) {
      final width = constraints.maxWidth;
      return Card(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: ListView(
            children: [
              RichText(
                text: TextSpan(
                  text: "← Product Purchase/",
                  style: textTheme.displayMedium?.copyWith(
                    fontSize: 25,
                    color: Colors.blue,
                  ),
                  recognizer: TapGestureRecognizer()
                    ..onTap = () {
                      controller.changePageType(PageType.productPurchase());
                    },
                ),
              ),

              //Name
              rowText(
                left: "နာမည်:",
                right: rewardPurchase?.name ?? "",
                width: width,
              ),
              verticalSpace(),

              //ID-NO
              rowText(
                  left: "အီးမေးလ်:",
                  right: rewardPurchase?.email ?? "",
                  width: width),
              verticalSpace(),
              //Address
              rowText(
                  left: "နေရပ်လိပ်စာ:",
                  right: rewardPurchase?.address ?? "",
                  width: width),
              verticalSpace(),
              //Phone Number
              rowText(
                  left: "တိုင်း:",
                  right: rewardPurchase?.deliveryTownshipInfo?[0] ?? "",
                  width: width),
              verticalSpace(),
              //Course
              rowText(left: "Products:", right: "", width: width),

              rowThreeColumnsText(
                left: "Kyats",
                middle: "Points",
                right: "Count",
                width: width,
                fontWeight: FontWeight.bold,
              ),
              ListView.builder(
                shrinkWrap: true,
                primary: false,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: rewardPurchase?.rewardProductList?.length ?? 0,
                itemBuilder: (context, index) {
                  final reward = rewardPurchase?.rewardProductList?[index];
                  return rowThreeColumnsText(
                    left: "${reward?.description}",
                    middle: "${reward?.requirePoint}",
                    right: "${reward?.count}",
                    width: width,
                    fontWeight: FontWeight.normal,
                  );
                },
              )
            ],
          ),
        ),
      );
    });
  }
}
