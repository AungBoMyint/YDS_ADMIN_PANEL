import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:pizza/admin/controller/course_controller.dart';
import 'package:pizza/admin/controller/question_controller.dart';
import 'package:pizza/admin/utils/extensions.dart';
import 'package:pizza/models/object_models/item.dart';
import 'package:pizza/models/object_models/question/question.dart';
import 'package:pizza/models/object_models/question/sub_question.dart';
import 'package:pizza/service/reference.dart';
import 'package:uuid/uuid.dart';
import '../../utils/func.dart';
import '../../utils/space.dart';
import '../../utils/widgets.dart';

class AddSubQuestionForm extends StatefulWidget {
  const AddSubQuestionForm({
    super.key,
    this.question,
    this.isView = false,
  });

  final SubQuestion? question;
  final bool isView;

  @override
  State<AddSubQuestionForm> createState() => _AddSubQuestionFormState();
}

class _AddSubQuestionFormState extends State<AddSubQuestionForm> {
  GlobalKey<FormState> formKey = GlobalKey();
  TextEditingController questionNumberTextController = TextEditingController();
  TextEditingController titleTextController = TextEditingController();
  TextEditingController descriptionTextController = TextEditingController();
  TextEditingController answerTextController = TextEditingController();
  @override
  void initState() {
    if (!(widget.question == null)) {
      questionNumberTextController.text = "${widget.question?.qNo}";
      titleTextController.text = widget.question?.title ?? "";
      descriptionTextController.text = widget.question?.description ?? "";
      answerTextController.text = widget.question?.answer ?? "";
    }
    super.initState();
  }

  @override
  void dispose() {
    questionNumberTextController.dispose();
    titleTextController.dispose();
    descriptionTextController.dispose();
    answerTextController.dispose();
    super.dispose();
  }

  void refresh() {
    setState(() {
      questionNumberTextController.clear();
      titleTextController.clear();
      descriptionTextController.clear();
      answerTextController.clear();
    });
  }

  @override
  Widget build(BuildContext context) {
    final QuestionController questionController = Get.find();
    return Form(
      key: formKey,
      child: SingleChildScrollView(
        child: Column(
          children: [
            TextFormField(
              validator: (v) => stringValidator("Question Number", v),
              controller: questionNumberTextController,
              decoration: InputDecoration(
                border: dropDownBorder(),
                disabledBorder: dropDownBorder(),
                focusedBorder: dropDownBorder(),
                enabledBorder: dropDownBorder(),
                labelText: "Question Number",
                floatingLabelBehavior: FloatingLabelBehavior.always,
              ),
            ),
            verticalSpace(),
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
            //Description
            TextFormField(
              validator: (v) => stringValidator("Description", v),
              controller: descriptionTextController,
              decoration: InputDecoration(
                border: dropDownBorder(),
                disabledBorder: dropDownBorder(),
                focusedBorder: dropDownBorder(),
                enabledBorder: dropDownBorder(),
                labelText: "Description",
                floatingLabelBehavior: FloatingLabelBehavior.always,
              ),
            ),
            verticalSpace(),
            TextFormField(
              validator: (v) => stringValidator("Answer", v),
              controller: answerTextController,
              decoration: InputDecoration(
                border: dropDownBorder(),
                disabledBorder: dropDownBorder(),
                focusedBorder: dropDownBorder(),
                enabledBorder: dropDownBorder(),
                labelText: "Answer",
                floatingLabelBehavior: FloatingLabelBehavior.always,
              ),
            ),
            verticalSpace(),
            widget.isView
                ? const SizedBox()
                : ElevatedButton(
                    onPressed: () {
                      if (formKey.currentState?.validate() == true) {
                        var nameList = getNameList(titleTextController.text);
                        if (widget.question == null) {
                          final question = SubQuestion(
                            id: Uuid().v1(),
                            qNo: int.tryParse(
                                    questionNumberTextController.text) ??
                                0,
                            title: titleTextController.text,
                            description: descriptionTextController.text,
                            answer: answerTextController.text,
                            dateTime: DateTime.now(),
                            nameList: nameList,
                          );
                          upload<SubQuestion>(
                              sQuestionDocument(
                                  questionController.selectedQuestion
                                          .getOrElse(() => null)
                                          ?.id ??
                                      "",
                                  question.id),
                              question,
                              "Sub Question uploading is successful.",
                              "Sub Question uploading is failed.", () {
                            refresh();
                            questionController.subQuestions.add(question);
                          });

                          debugPrint("******Uploading...Slider");
                        } else {
                          final question = SubQuestion(
                            id: widget.question?.id ?? "",
                            qNo: int.tryParse(
                                    questionNumberTextController.text) ??
                                0,
                            title: titleTextController.text,
                            description: descriptionTextController.text,
                            answer: answerTextController.text,
                            dateTime: DateTime.now(),
                            nameList: nameList,
                          );
                          edit<SubQuestion>(
                              sQuestionDocument(
                                  questionController.selectedQuestion
                                          .getOrElse(() => null)
                                          ?.id ??
                                      "",
                                  question.id),
                              question,
                              "Sub Question updating is successful.",
                              "Sub Question updating is failed.", () {
                            final index = questionController.subQuestions
                                .indexWhere(
                                    (element) => element.id == question.id);
                            questionController.subQuestions[index] = question;
                          });

                          debugPrint("******${question.id}");
                        }
                      }
                    },
                    child: Padding(
                      padding: const EdgeInsets.all(5.0),
                      child: Text(
                        widget.question == null ? "Save" : "Update",
                        style: GoogleFonts.inter(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 20,
                        ),
                      ),
                    ),
                  ),
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
