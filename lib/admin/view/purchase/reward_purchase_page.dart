import 'dart:developer';

import 'package:YDS/admin/controller/purchase_controller.dart';
import 'package:YDS/models/object_models/form/car_licence_form.dart';
import 'package:YDS/models/object_models/form/course_form.dart';
import 'package:YDS/models/object_models/form/driving_licence_form.dart';
import 'package:YDS/models/page_type.dart';
import 'package:YDS/models/purchase_filter.dart';
import 'package:YDS/models/purchase_filter_type.dart';
import 'package:dartz/dartz.dart' hide State;
import 'package:data_table_2/data_table_2.dart';
import 'package:flutter/material.dart';
import 'package:flutterfire_ui/firestore.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:syncfusion_flutter_datepicker/datepicker.dart';

import '../../../constant/icon.dart';
import '../../controller/admin_login_controller.dart';
import '../../controller/admin_ui_controller.dart';
import '../../utils/space.dart';
import '../../utils/widgets.dart';

class RewardPurchasePage extends StatelessWidget {
  const RewardPurchasePage({super.key});

  @override
  Widget build(BuildContext context) {
    final PurchaseController purchaseController = Get.find();
    final size = MediaQuery.of(context).size;
    final AdminUiController auController = Get.find();
    final textTheme = Theme.of(context).textTheme;
    final titleTextStyle = textTheme.displayMedium?.copyWith(fontSize: 22);
    final bodyTextStyle = textTheme.displayMedium;
    dropDownBorder() => const OutlineInputBorder(
            borderSide: BorderSide(
          color: Colors.black,
        ));

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        verticalSpace(v: 15),

        Text("Here is your product purchase list data",
            style: textTheme.displaySmall?.copyWith(
              color: Colors.black,
            )),

        verticalSpace(),
        //Order Table
        Expanded(
          child: Card(
            child: Obx(() {
              final orders = purchaseController.rewardPurchases.isEmpty ||
                      purchaseController.rewardPurchases.isNotEmpty
                  ? purchaseController.rewardPurchases
                  : purchaseController.rewardPurchases;

              return LayoutBuilder(builder: (context, constraints) {
                final width = constraints.maxWidth;
                log("Max Width Of Order Table: $width");
                return DataTable2(
                  lmRatio: 0.8,
                  columnSpacing: 25,
                  horizontalMargin: 20,
                  minWidth: 200,
                  /* onSelectAll: (v) =>
                            adminUiController.setDataTableSelectAll(), */
                  columns: [
                    DataColumn2(
                      label: Text(
                        'CUSTOMER\nNAME',
                        style: titleTextStyle,
                      ),
                    ),
                    DataColumn2(
                      label: Text(
                        'EMAIL',
                        style: titleTextStyle,
                      ),
                    ),
                    DataColumn2(
                      label: Text(
                        'ADDRESS',
                        style: titleTextStyle,
                      ),
                    ),
                    DataColumn2(
                      label: Text(
                        'TOTAL PRODUCTS',
                        style: titleTextStyle,
                        textAlign: TextAlign.center,
                      ),
                    ),
                    //Action
                    DataColumn2(
                      label: Text(
                        '',
                        style: titleTextStyle,
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ],
                  rows: List.generate(
                    orders.length,
                    (index) {
                      final order = orders[index];
                      return DataRow(
                        cells: [
                          //order id
                          DataCell(
                            Text(
                              order.name,
                              style: textTheme.displayMedium,
                              overflow: TextOverflow.ellipsis,
                              maxLines: 3,
                            ),
                          ),
                          DataCell(
                            Text(
                              order.email,
                              style: textTheme.displayMedium,
                              overflow: TextOverflow.ellipsis,
                              maxLines: 3,
                            ),
                          ),
                          DataCell(
                            Text(
                              order.address,
                              style: textTheme.displayMedium,
                              overflow: TextOverflow.ellipsis,
                              maxLines: 3,
                            ),
                          ),
                          DataCell(
                            Text(
                              "${order.rewardProductList?.length}",
                              style: textTheme.displayMedium,
                              overflow: TextOverflow.ellipsis,
                              maxLines: 3,
                            ),
                          ),
                          DataCell(
                            IconButton(
                              iconSize: 25,
                              onPressed: () {
                                purchaseController
                                    .setRewardPurchase(right(order));
                                auController.changePageType(
                                    PageType.productPurchaseDetail());
                              },
                              icon: Icon(
                                FontAwesomeIcons.eye,
                                color: Colors.grey.shade600,
                              ),
                            ),
                          ),
                        ],
                      );
                    },
                  ),
                );
              });
            }),
          ),
        ),
      ],
    );
  }

  String getDateTimeString(RxList<DateTime> dateTimes) {
    final now = DateTime.now();
    final first = dateTimes.first;
    final last = dateTimes.last;
    if ((first.year == now.year &&
            first.month == now.month &&
            first.day == now.day) &&
        (last.year == now.year &&
            last.month == now.month &&
            last.day == now.day)) {
      //Todday
      return "TODAY";
    }
    var from = DateFormat.yMMMMd('en_US').format(dateTimes.first);
    var to = DateFormat.yMMMMd('en_US').format(dateTimes.last);
    return "From: $from\nTo: $to";
  }
}

class StatusOrderContainer extends StatelessWidget {
  const StatusOrderContainer({
    super.key,
    required this.status,
    required this.color,
  });

  final String status;
  final Color color;

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    return Container(
      padding: const EdgeInsets.all(5),
      color: color.withOpacity(0.2),
      child: Text(
        status,
        style: textTheme.displayMedium?.copyWith(
          color: color.withOpacity(0.8),
        ),
        overflow: TextOverflow.ellipsis,
        maxLines: 3,
      ),
    );
  }
}

Widget getStatusOrder(bool isConfirmed) {
  if (!isConfirmed) {
    return const StatusOrderContainer(
      status: "New",
      color: Colors.amber,
    );
  } else {
    return const StatusOrderContainer(
      status: "Confirmed",
      color: Color(0xFF5E8F94),
    );
  }
}
