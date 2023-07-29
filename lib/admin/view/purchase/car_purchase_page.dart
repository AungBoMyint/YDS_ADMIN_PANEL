import 'dart:developer';

import 'package:YDS/admin/controller/purchase_controller.dart';
import 'package:YDS/models/object_models/form/car_licence_form.dart';
import 'package:YDS/models/object_models/form/course_form.dart';
import 'package:YDS/models/object_models/form/driving_licence_form.dart';
import 'package:YDS/models/object_models/user.dart';
import 'package:YDS/models/page_type.dart';
import 'package:YDS/models/purchase_filter.dart';
import 'package:YDS/models/purchase_filter_type.dart';
import 'package:YDS/service/collection_name.dart';
import 'package:YDS/service/reference.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
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
import '../../utils/constant.dart';
import '../../utils/space.dart';
import '../../utils/widgets.dart';

class CarLicenceFormPurchasePage extends StatelessWidget {
  const CarLicenceFormPurchasePage({super.key});

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
        Row(
          children: [
            Text("Here is your car purchase list data",
                style: textTheme.displaySmall?.copyWith(
                  color: Colors.black,
                )),
            const Expanded(child: SizedBox()),
            Expanded(
              child: Card(
                child: Padding(
                  padding: const EdgeInsets.only(
                    left: 20,
                    right: 20,
                    top: 5,
                    bottom: 5,
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Filters",
                        style: textTheme.displayLarge,
                      ),
                      verticalSpace(v: 10),
                      //DropDown
                      Obx(() {
                        final pft =
                            purchaseController.carPurchaseFilterType.value;
                        return LayoutBuilder(builder: (context, constraints) {
                          final parentWidth = constraints.maxWidth;
                          return DropdownButtonFormField<PurchaseFilterType>(
                            value: pft,
                            alignment: AlignmentDirectional.centerStart,
                            autofocus: false,
                            dropdownColor: Theme.of(context).cardTheme.color,
                            decoration: InputDecoration(
                              border: dropDownBorder(),
                              disabledBorder: dropDownBorder(),
                              focusedBorder: dropDownBorder(),
                              enabledBorder: dropDownBorder(),
                            ),
                            hint: Align(
                              alignment: Alignment.centerRight,
                              child: Text(
                                "Select Filter Type",
                                style: textTheme.displaySmall?.copyWith(
                                  color: Colors.grey.shade600,
                                ),
                                textAlign: TextAlign.left,
                              ),
                            ),
                            selectedItemBuilder: (context) {
                              return purchaseFilters.map((e) {
                                return LayoutBuilder(
                                    builder: (context, constraints) {
                                  final height = constraints.maxHeight;
                                  return SizedBox(
                                    width: parentWidth * 0.85,
                                    height: height,
                                    child: Row(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      children: [
                                        Expanded(
                                          child: Text(
                                            e.name,
                                            style: textTheme.displaySmall
                                                ?.copyWith(
                                              color: Colors.grey.shade600,
                                            ),
                                          ),
                                        ),
                                        Align(
                                          alignment: Alignment.centerRight,
                                          child: InkWell(
                                            onTap: () => purchaseController
                                                .setCarPurchaseFilterType(null),
                                            child: Icon(
                                              Icons.close,
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  );
                                });
                              }).toList();
                            },
                            items: purchaseFilters.map((e) {
                              return DropdownMenuItem<PurchaseFilterType>(
                                value: e.pft,
                                child: Text(
                                  e.name,
                                  style: textTheme.displaySmall?.copyWith(
                                    color: Colors.grey.shade600,
                                  ),
                                ),
                              );
                            }).toList(),
                            onChanged: (_) =>
                                purchaseController.setCarPurchaseFilterType(_!),
                          );
                        });
                      }),
                    ],
                  ),
                ),
              ),
            )
          ],
        ),
        verticalSpace(),
        //Order Table
        Expanded(
          child: Card(
            child: Obx(() {
              final orders = purchaseController.searchCarLicenceForms.isNotEmpty
                  ? purchaseController.searchCarLicenceForms
                  : purchaseController.carLicenceForms;

              return LayoutBuilder(builder: (context, constraints) {
                final width = constraints.maxWidth;
                log("Max Width Of Order Table: $width");
                return DataTable2(
                  lmRatio: 0.8,
                  columnSpacing: 25,
                  horizontalMargin: 20,
                  minWidth: 200,
                  dataRowHeight: 150,
                  /* onSelectAll: (v) =>
                            adminUiController.setDataTableSelectAll(), */
                  columns: [
                    DataColumn2(
                      label: Text(
                        'STUDENT',
                        style: titleTextStyle,
                      ),
                    ),
                    DataColumn2(
                      label: Text(
                        'PHONE',
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
                        'CAR NO',
                        style: titleTextStyle,
                        textAlign: TextAlign.center,
                      ),
                    ),
                    DataColumn2(
                      label: Text(
                        'CAR EXPIRED DATE',
                        style: titleTextStyle,
                        textAlign: TextAlign.center,
                      ),
                    ),
                    DataColumn2(
                      label: Text(
                        'COURSE FEE',
                        style: titleTextStyle,
                        textAlign: TextAlign.center,
                      ),
                    ),
                    DataColumn2(
                      label: Text(
                        'STATUS',
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
                          DataCell(FutureBuilder<DocumentSnapshot<dynamic>>(
                                  future:
                                      userDocumentReference(order.userId).get(),
                                  builder: (context,
                                      AsyncSnapshot<DocumentSnapshot<dynamic>>
                                          snapshot) {
                                    if (snapshot.hasData) {
                                      AuthUser? user;
                                      if (snapshot.data?.data() == null) {
                                        user = null;
                                      } else {
                                        user = AuthUser.fromJson(snapshot.data
                                            ?.data() as Map<String, dynamic>);
                                      }
                                      return Row(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                        children: [
                                          CircleAvatar(
                                            radius: 20,
                                            backgroundImage: NetworkImage(
                                              user?.image ?? emptyProfile,
                                            ),
                                          ),
                                          horizontalSpace(v: 10),
                                          Expanded(
                                            child: Text(
                                              user?.userName ??
                                                  "Empty User Name",
                                              style: textTheme.displayMedium,
                                            ),
                                          )
                                        ],
                                      );
                                    }
                                    return Text(
                                      "",
                                      style: bodyTextStyle,
                                      maxLines: 3,
                                    );
                                  })
                              /* Text(
                              order.name,
                              style: textTheme.displayMedium,
                              overflow: TextOverflow.ellipsis,
                              maxLines: 3,
                            ), */
                              ),
                          DataCell(
                            Text(
                              order.phoneNumber,
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
                              order.carNo,
                              style: textTheme.displayMedium,
                              overflow: TextOverflow.ellipsis,
                              maxLines: 3,
                            ),
                          ),
                          DataCell(
                            Text(
                              order.carExpiredDate,
                              style: textTheme.displayMedium,
                              overflow: TextOverflow.ellipsis,
                              maxLines: 3,
                            ),
                          ),
                          //Amount
                          DataCell(Text(
                            "${order.cost}Ks",
                            style: textTheme.displayMedium,
                            overflow: TextOverflow.ellipsis,
                            maxLines: 3,
                          )),
                          //Status Order
                          DataCell(getStatusOrder(order.isConfirmed)), //Action
                          DataCell(
                            GestureDetector(
                              child: Icon(Icons.more_horiz),
                              onTapDown: (TapDownDetails details) {
                                showPopupMenu(
                                    context, details.globalPosition, order);
                              },
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

void showPopupMenu(
    BuildContext context, Offset position, CarLicenceForm order) async {
  final PurchaseController orController = Get.find();
  final AdminUiController adminUiController = Get.find();
  final textTheme = Theme.of(context).textTheme;
  final RenderBox overlay =
      Overlay.of(context).context.findRenderObject() as RenderBox;
  final RenderBox popupButton = context.findRenderObject() as RenderBox;
  final Offset targetPosition =
      popupButton.localToGlobal(Offset.zero, ancestor: overlay);
  final result = await showMenu(
    color: Theme.of(context).cardTheme.color,
    context: context,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.all(
        Radius.circular(20),
      ),
    ),
    position: RelativeRect.fromLTRB(
      position.dx,
      position.dy,
      targetPosition.dx + popupButton.size.width,
      targetPosition.dy + popupButton.size.height,
    ),
    items: [
      PopupMenuItem(
        onTap: () {
          if (order.isConfirmed) {
            //Cannot change status because
            //order have been already delivered.
            Get.snackbar(
              "Warning",
              "The order has already confirmed",
              backgroundColor: Colors.red,
              colorText: Colors.white,
              snackPosition: SnackPosition.BOTTOM,
            );
            return;
          }
          orController.confirmEnrollment(
            collection: carLicenceCollection,
            resourceId: order.id,
            userId: order.userId,
            cost: order.cost,
          );
          //TODO:Chage this form to Confirm = true
          /* orController.changeOrderStatua(1); */
        },
        value: 'confirm',
        child: Row(
          children: [
            Image.asset(
              AdminIcon.acceptOrder,
              width: 25,
              height: 25,
            ),
            horizontalSpace(v: 20),
            Text("Confirm Order",
                style: textTheme.displayMedium?.copyWith(
                  color: Colors.green,
                ))
          ],
        ),
      ),
      /* PopupMenuItem(
        onTap: () {
          orController.setSelectedOrder(order);
          if (order.status == 2 || order.status == 3) {
            //Cannot change status because
            //order have been already delivered.
            Get.snackbar(
              "Warning",
              "The order has already been ${order.status == 2 ? "delivered" : order.status == 3 ? "Cancelled" : "Undelivered"} and its status cannot be changed. Please confirm before proceeding.",
              backgroundColor: Colors.red,
              colorText: Colors.white,
              snackPosition: SnackPosition.BOTTOM,
            );
            return;
          }
          orController.changeOrderStatua(3);
        },
        value: 'reject',
        child: Row(
          children: [
            Image.asset(
              AdminIcon.rejectOrder,
              width: 25,
              height: 25,
            ),
            horizontalSpace(v: 20),
            Text("Reject Order",
                style: textTheme.displayMedium?.copyWith(
                  color: Colors.red,
                ))
          ],
        ),
      ), */
      //View Order
      PopupMenuItem(
        onTap: () {
          orController.setSelectedCarForm(right(order));
          //TODO:View Order
          adminUiController.changePageType(PageType.carLicencePurchaseDetail());
        },
        value: 'view order',
        child: Row(
          children: [
            Icon(
              FontAwesomeIcons.eye,
              size: 25,
              color: Theme.of(context).iconTheme.color,
            ),
            horizontalSpace(v: 20),
            Text("View Order",
                style: textTheme.displayMedium?.copyWith(
                  color: Theme.of(context).iconTheme.color,
                ))
          ],
        ),
      ),
    ],
  );
  /* // handle result of popup menu
  if (result == 'edit') {
    // edit action
  } else if (result == 'delete') {
    // delete action
  } */
}
