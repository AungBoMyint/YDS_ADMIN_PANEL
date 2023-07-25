import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:data_table_2/data_table_2.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:YDS/admin/controller/course_controller.dart';
import 'package:YDS/admin/controller/question_controller.dart';
import 'package:YDS/admin/widgets/course/add_course_form.dart';
import 'package:YDS/admin/widgets/questions/sub_quesiton_add_form.dart';
import 'package:YDS/models/object_models/item.dart';
import 'package:YDS/models/object_models/question/question.dart';
import 'package:YDS/models/object_models/question/sub_question.dart';
import 'package:YDS/service/reference.dart';
import '../../../models/page_type.dart';
import '../../../models/rbpoint.dart';
import '../../controller/admin_ui_controller.dart';
import '../../utils/func.dart';
import '../../utils/space.dart';
import '../../utils/widgets.dart';
import '../../widgets/questions/main_question_add_form.dart';

class SubQuestionPage extends StatefulWidget {
  const SubQuestionPage({super.key});

  @override
  State<SubQuestionPage> createState() => _SubQuestionPageState();
}

class _SubQuestionPageState extends State<SubQuestionPage> {
  late ScrollController scrollController;
  final QuestionController questionController = Get.find();
  @override
  void initState() {
    scrollController = ScrollController(initialScrollOffset: 0.0);
    questionController.setSubQuestionScrollControllerListener(scrollController);
    questionController.startGetSubQuestion();
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
        RichText(
          text: TextSpan(
            text: "← Questions/",
            style: textTheme.displayMedium?.copyWith(
              fontSize: 25,
              color: Colors.blue,
            ),
            recognizer: TapGestureRecognizer()
              ..onTap = () {
                controller.changePageType(PageType.questions());
              },
          ),
        ),
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
                      onChanged: (v) => questionController.debouncer.run(() {
                        questionController.startSubQuestionSearch(v);
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
                          title: "Create Sub Question",
                          onPressed: () {
                            //TODO:CREATE ITEM
                            Get.dialog(
                              Center(
                                child: SizedBox(
                                  height: size.height * 0.8,
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
                                      child: AddSubQuestionForm(),
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
                    final questions = questionController.subQuestions;
                    final selectedAll =
                        questionController.subQuestionSelectedAll.value;
                    final selectedRow =
                        questionController.subQuestionSelectedRow;
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
                                questionController
                                    .setSubQuestionSelectedAll(questions);
                              } else {
                                questionController.setItemsSelectedAll(null);
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
                            'Question Number',
                            style: titleTextStyle,
                          ),
                        ),
                        //Out of stock
                        DataColumn2(
                          label: Text(
                            'Title',
                            style: titleTextStyle,
                          ),
                          size: ColumnSize.L,
                        ),
                        DataColumn(
                          label: Text(
                            'Description',
                            style: titleTextStyle,
                          ),
                        ),
                        DataColumn(
                          label: Text(
                            'Answer',
                            style: titleTextStyle,
                          ),
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
                        questions.length,
                        (index) {
                          final item = questions[index];
                          return DataRow(
                            cells: [
                              DataCell(
                                Checkbox(
                                  activeColor: Theme.of(context).primaryColor,
                                  value: selectedRow.contains(item.id),
                                  onChanged: (_) => questionController
                                      .setSubQuestionSelectedRow(item),
                                  side: const BorderSide(
                                    color: Colors.black,
                                    width: 1.5,
                                  ),
                                ),
                              ),
                              DataCell(
                                Text(
                                  "${item.qNo}",
                                  style: bodyTextStyle,
                                ),
                              ),
                              DataCell(
                                Text(
                                  item.title,
                                  style: bodyTextStyle,
                                ),
                              ),
                              DataCell(
                                Text(
                                  item.description,
                                  style: bodyTextStyle,
                                ),
                              ),
                              DataCell(
                                Text(
                                  item.answer,
                                  style: bodyTextStyle,
                                ),
                              ),
                              DataCell(Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  IconButton(
                                    iconSize: 25,
                                    onPressed: () {
                                      delete<SubQuestion>(
                                              sQuestionDocument(
                                                questionController
                                                        .selectedQuestion
                                                        .getOrElse(() => null)
                                                        ?.id ??
                                                    "",
                                                item.id,
                                              ),
                                              "Sub Question deleting is successful.",
                                              "Sub Question deleting is failed.")
                                          .then((value) {
                                        questionController.subQuestions
                                            .removeWhere((element) =>
                                                element.id == item.id);
                                      });
                                    },
                                    icon: Icon(
                                      FontAwesomeIcons.trash,
                                      color: Colors.grey.shade600,
                                    ),
                                  ),
                                  //View
                                  IconButton(
                                    onPressed: () {
                                      Get.dialog(
                                        Center(
                                          child: SizedBox(
                                            height: size.height * 0.8,
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
                                                child: AddSubQuestionForm(
                                                  question: item,
                                                  isView: true,
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
                                      FontAwesomeIcons.eye,
                                      size: 25,
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
                                            height: size.height * 0.8,
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
                                                child: AddSubQuestionForm(
                                                  question: item,
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
  final QuestionController questionController = Get.find();
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
          deleteItems<SubQuestion>(
            questionController.subQuestionSelectedRow,
            sQuestionCollection(
              questionController.selectedQuestion.getOrElse(() => null)?.id ??
                  "",
            ),
          ).then((value) {
            for (var element in questionController.itemsSelectedRow) {
              questionController.subQuestions
                  .removeWhere((e) => e.id == element);
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
