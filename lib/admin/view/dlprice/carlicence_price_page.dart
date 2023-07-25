import 'package:YDS/admin/controller/car_licence_price_controller.dart';
import 'package:YDS/admin/controller/driving_licence_price_controller.dart';
import 'package:YDS/admin/widgets/price/dirvinglicence_add_form.dart';
import 'package:YDS/models/object_models/price/cost.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:data_table_2/data_table_2.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:YDS/admin/controller/course_controller.dart';
import 'package:YDS/admin/widgets/course/add_course_form.dart';
import 'package:YDS/models/object_models/item.dart';
import 'package:YDS/service/reference.dart';
import '../../../models/rbpoint.dart';
import '../../controller/admin_ui_controller.dart';
import '../../utils/func.dart';
import '../../utils/space.dart';
import '../../utils/widgets.dart';
import '../../widgets/price/carlicence_add_form.dart';

class CarLicencePricePage extends StatefulWidget {
  const CarLicencePricePage({super.key});

  @override
  State<CarLicencePricePage> createState() => _CarLicencePricePageState();
}

class _CarLicencePricePageState extends State<CarLicencePricePage> {
  final CarLicencePriceController dlPController = Get.find();
  @override
  void initState() {
    dlPController.startGetItems();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final AdminUiController controller = Get.find();
    final textTheme = Theme.of(context).textTheme;
    final titleTextStyle = textTheme.displayMedium?.copyWith(fontSize: 22);
    final bodyTextStyle = textTheme.displayMedium;
    final size = MediaQuery.of(context).size;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        //Table
        Expanded(
          flex: controller.rbPoint.value!.fold(
            (l) => 0,
            (r) => r.map(
              xl: (_) => 7,
              desktop: (_) => 7,
              tablet: (_) => 8,
              mobile: (_) => 8,
            ),
          ),
          child: Card(
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
                        //action
                        GestureDetector(
                          onTapDown: (TapDownDetails details) {
                            showPopupMenu(context, details.globalPosition);
                          },
                          child: SizedBox(
                            height: 50,
                            child: Card(
                                shape: const RoundedRectangleBorder(
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(
                                  10,
                                ))),
                                child: Padding(
                                  padding: const EdgeInsets.all(10.0),
                                  child: Text(
                                    "Action",
                                    style: textTheme.displayLarge,
                                  ),
                                )),
                          ),
                        ),

                        Expanded(child: Container()),
                        CreateButton(
                          title: "Create Car Licence Price",
                          onPressed: () {
                            //TODO:CREATE ITEM
                            Get.dialog(
                              Center(
                                child: SizedBox(
                                  height: size.height * 0.4,
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
                                        child: CarLicencePriceAddForm()),
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
                    final courses = dlPController.dlCosts;
                    final selectedAll = dlPController.itemsSelectedAll.value;
                    final selectedRow = dlPController.itemsSelectedRow;
                    return DataTable2(
                      showCheckboxColumn: true,
                      columnSpacing: 20,
                      horizontalMargin: 20,
                      minWidth: 600,
                      /* onSelectAll: (v) => newsController.setSli, */
                      columns: [
                        DataColumn2(
                          label: Checkbox(
                            value: selectedAll,
                            activeColor: Theme.of(context).primaryColor,
                            onChanged: (_) {
                              if (!selectedAll) {
                                dlPController.setItemsSelectedAll(courses);
                              } else {
                                dlPController.setItemsSelectedAll(null);
                              }
                            },
                            side: BorderSide(
                              color: Colors.black,
                              width: 2,
                            ),
                          ),
                          fixedWidth: 80,
                        ),

                        DataColumn(
                          label: Text(
                            'Description',
                            style: titleTextStyle,
                          ),
                        ),
                        //Out of stock
                        DataColumn2(
                          label: Text(
                            'Price',
                            style: titleTextStyle,
                          ),
                          size: ColumnSize.L,
                        ),

                        DataColumn2(
                          label: Text(
                            'Actions',
                            style: titleTextStyle,
                            textAlign: TextAlign.center,
                          ),
                          fixedWidth: 135,
                        ),
                      ],
                      rows: List.generate(
                        courses.length,
                        (index) {
                          final item = courses[index];
                          return DataRow(
                            cells: [
                              DataCell(
                                Checkbox(
                                  activeColor: Theme.of(context).primaryColor,
                                  value: selectedRow.contains(item.id),
                                  onChanged: (_) =>
                                      dlPController.setItemsSelectedRow(item),
                                  side: const BorderSide(
                                    color: Colors.black,
                                    width: 1.5,
                                  ),
                                ),
                              ),
                              DataCell(
                                Text(
                                  item.desc,
                                  style: bodyTextStyle,
                                ),
                              ),
                              DataCell(
                                Text(
                                  "${item.cost}Ks",
                                  style: bodyTextStyle,
                                ),
                              ),
                              DataCell(Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  IconButton(
                                    iconSize: 25,
                                    onPressed: () {
                                      delete<Cost>(
                                              carLicencePriceDocument(item.id),
                                              "Car Licence Price deleting is successful.",
                                              "Car Licence Price deleting is failed.")
                                          .then((value) {
                                        dlPController.dlCosts.removeWhere(
                                            (element) => element.id == item.id);
                                      });
                                    },
                                    icon: Icon(
                                      FontAwesomeIcons.trash,
                                      color: Colors.grey.shade600,
                                    ),
                                  ),
                                  IconButton(
                                    iconSize: 25,
                                    onPressed: () {
                                      //TODO:EDIT MUSIC
                                      Get.dialog(
                                        Center(
                                          child: SizedBox(
                                            height: size.height * 0.4,
                                            width: size.width * 0.5,
                                            child: Material(
                                              borderRadius: BorderRadius.all(
                                                  Radius.circular(20)),
                                              child: Padding(
                                                padding: const EdgeInsets.only(
                                                  left: 20,
                                                  right: 20,
                                                  top: 20,
                                                  bottom: 10,
                                                ),
                                                child: CarLicencePriceAddForm(
                                                    cost: item),
                                              ),
                                            ),
                                          ),
                                        ),
                                        barrierColor:
                                            Colors.black.withOpacity(0.2),
                                      );
                                    },
                                    icon: Icon(
                                      FontAwesomeIcons.pen,
                                      color: Colors.grey.shade600,
                                    ),
                                  ),
                                ],
                              )),
                            ],
                          );
                        },
                      ),
                    );
                  }),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}

void showPopupMenu(BuildContext context, Offset position) async {
  final DrivingLicencePriceController dlpController = Get.find();
  final textTheme = Theme.of(context).textTheme;
  final RenderBox overlay =
      Overlay.of(context).context.findRenderObject() as RenderBox;
  final RenderBox popupButton = context.findRenderObject() as RenderBox;
  final Offset targetPosition =
      popupButton.localToGlobal(Offset.zero, ancestor: overlay);
  final result = await showMenu(
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
        value: 'delete',
        onTap: () {
          deleteItems<Cost>(
            dlpController.itemsSelectedRow,
            drivingLicencePriceCollection(),
          ).then((value) {
            for (var element in dlpController.itemsSelectedRow) {
              dlpController.dlCosts.removeWhere((e) => e.id == element);
            }
          });
        },
        child: Text(
          "Delete",
          style: textTheme.displayMedium?.copyWith(
            color: Colors.green,
          ),
        ),
      ),
    ],
  );
}
