import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:pizza/admin/controller/course_controller.dart';
import 'package:pizza/admin/controller/question_controller.dart';
import 'package:pizza/admin/utils/extensions.dart';
import 'package:pizza/models/object_models/item.dart';
import 'package:pizza/models/object_models/question/question.dart';
import 'package:pizza/service/reference.dart';
import 'package:uuid/uuid.dart';
import '../../utils/func.dart';
import '../../utils/space.dart';
import '../../utils/widgets.dart';

class AddMainQuestionForm extends StatefulWidget {
  const AddMainQuestionForm({
    super.key,
    this.question,
  });

  final Question? question;

  @override
  State<AddMainQuestionForm> createState() => _AddMainQuestionFormState();
}

class _AddMainQuestionFormState extends State<AddMainQuestionForm> {
  GlobalKey<FormState> formKey = GlobalKey();
  TextEditingController questionNumberTextController = TextEditingController();
  TextEditingController titleTextController = TextEditingController();

  @override
  void initState() {
    if (!(widget.question == null)) {
      questionNumberTextController.text = "${widget.question?.qNo}";
      titleTextController.text = widget.question?.title ?? "";
    }
    super.initState();
  }

  @override
  void dispose() {
    questionNumberTextController.dispose();
    titleTextController.dispose();
    super.dispose();
  }

  void refresh() {
    setState(() {
      questionNumberTextController.clear();
      titleTextController.clear();
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

            verticalSpace(),
            ElevatedButton(
              onPressed: () {
                if (formKey.currentState?.validate() == true) {
                  var nameList = getNameList(titleTextController.text);
                  if (widget.question == null) {
                    final question = Question(
                      id: Uuid().v1(),
                      qNo: int.tryParse(questionNumberTextController.text) ?? 0,
                      title: titleTextController.text,
                      nameList: nameList,
                    );
                    upload<Question>(
                        questionDocument(question.id),
                        question,
                        "Question uploading is successful.",
                        "Question uploading is failed.", () {
                      refresh();
                      questionController.questions.add(question);
                    });

                    debugPrint("******Uploading...Slider");
                  } else {
                    final question = Question(
                      id: widget.question?.id ?? "",
                      qNo: int.tryParse(questionNumberTextController.text) ?? 0,
                      title: titleTextController.text,
                      nameList: nameList,
                    );
                    edit<Question>(
                        questionDocument(question.id),
                        question,
                        "Question updating is successful.",
                        "Question updating is failed.", () {
                      final index = questionController.questions
                          .indexWhere((element) => element.id == question.id);
                      questionController.questions[index] = question;
                    });

                    debugPrint("******Uploading...Slider");
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
