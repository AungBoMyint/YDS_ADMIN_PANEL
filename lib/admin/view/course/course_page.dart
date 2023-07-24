import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:data_table_2/data_table_2.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:pizza/admin/controller/course_controller.dart';
import 'package:pizza/admin/widgets/course/add_course_form.dart';
import 'package:pizza/models/object_models/item.dart';
import 'package:pizza/service/reference.dart';
import '../../../models/rbpoint.dart';
import '../../controller/admin_ui_controller.dart';
import '../../utils/func.dart';
import '../../utils/space.dart';
import '../../utils/widgets.dart';

class CoursePage extends StatefulWidget {
  const CoursePage({super.key});

  @override
  State<CoursePage> createState() => _CoursePageState();
}

class _CoursePageState extends State<CoursePage> {
  late ScrollController scrollController;
  final CourseController courseController = Get.find();
  @override
  void initState() {
    scrollController = ScrollController(initialScrollOffset: 0.0);
    courseController.setItemScrollControllerListener(scrollController);
    courseController.startGetItems();
    super.initState();
  }

  @override
  void dispose() {
    scrollController.removeListener(() {});
    scrollController.dispose();
    super.dispose();
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
        Card(
            child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Row(
            children: [
              //Search
              Expanded(
                flex: 1,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Search",
                      style: textTheme.displayLarge?.copyWith(
                        fontSize: controller.rbPoint.value!
                            .getOrElse(() => RBPoint.xl())
                            .map(
                                xl: (_) => 16,
                                desktop: (_) => 12,
                                tablet: (_) => 10,
                                mobile: (_) => 8),
                      ),
                    ),
                    verticalSpace(),
                    TextFormField(
                      onChanged: (v) => courseController.debouncer.run(() {
                        courseController.startItemSearch(v);
                      }),
                      decoration: InputDecoration(
                        border: dropDownBorder(),
                        disabledBorder: dropDownBorder(),
                        focusedBorder: dropDownBorder(),
                        enabledBorder: dropDownBorder(),
                        suffixIcon: Icon(Icons.search, color: Colors.black),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        )),

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
                          title: "Create Course",
                          onPressed: () {
                            //TODO:CREATE ITEM
                            Get.dialog(
                              Center(
                                child: SizedBox(
                                  height: size.height,
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
                                      child: AddCourseForm(),
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
                    final courses = courseController.courses;
                    final selectedAll = courseController.itemsSelectedAll.value;
                    final selectedRow = courseController.itemsSelectedRow;
                    return DataTable2(
                      showCheckboxColumn: true,
                      scrollController: scrollController,
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
                                courseController.setItemsSelectedAll(courses);
                              } else {
                                courseController.setItemsSelectedAll(null);
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
                            'Name',
                            style: titleTextStyle,
                          ),
                        ),
                        //Out of stock
                        DataColumn2(
                          label: Text(
                            'Image',
                            style: titleTextStyle,
                          ),
                          size: ColumnSize.L,
                        ),
                        DataColumn(
                          label: Text(
                            'Type',
                            style: titleTextStyle,
                          ),
                        ),
                        //Category
                        DataColumn(
                          label: Text(
                            'Price',
                            style: titleTextStyle,
                          ),
                        ),
                        //Type

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
                                  onChanged: (_) => courseController
                                      .setItemsSelectedRow(item),
                                  side: const BorderSide(
                                    color: Colors.black,
                                    width: 1.5,
                                  ),
                                ),
                              ),
                              DataCell(
                                Text(
                                  item.name,
                                  style: bodyTextStyle,
                                ),
                              ),
                              DataCell(Image.network(
                                item.photo,
                                width: 80,
                                height: 80,
                                fit: BoxFit.contain,
                              )),
                              DataCell(
                                Text(
                                  item.color,
                                  style: bodyTextStyle,
                                ),
                              ),
                              //Price
                              DataCell(
                                Text(
                                  "${item.price}Ks",
                                  style: bodyTextStyle,
                                ),
                              ),
                              DataCell(Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  IconButton(
                                    iconSize: 25,
                                    onPressed: () {
                                      delete<ItemModel>(
                                              courseDocument(item.id),
                                              "Item deleting is successful.",
                                              "Item deleting is failed.")
                                          .then((value) {
                                        courseController.courses.removeWhere(
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
                                            height: size.height,
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
                                                child: AddCourseForm(
                                                  course: item,
                                                ),
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
  final CourseController courseController = Get.find();
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
          deleteItems<ItemModel>(
            courseController.itemsSelectedRow,
            courseCollection(),
          ).then((value) {
            for (var element in courseController.itemsSelectedRow) {
              courseController.courses.removeWhere((e) => e.id == element);
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
