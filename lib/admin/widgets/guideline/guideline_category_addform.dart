import 'dart:developer';

import 'package:YDS/admin/utils/extensions.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:uuid/uuid.dart';
import '../../../models/guideline_category.dart';
import '../../../service/reference.dart';
import '../../controller/guideline_controller.dart';
import '../../utils/color_picker.dart';
import '../../utils/func.dart';
import '../../utils/space.dart';
import '../../utils/widgets.dart';

class AddGuidelineCategoryForm extends StatefulWidget {
  const AddGuidelineCategoryForm({
    super.key,
    this.guidelineCategory,
  });

  final GuideLineCategory? guidelineCategory;

  @override
  State<AddGuidelineCategoryForm> createState() =>
      _AddGuidelineCategoryFormState();
}

class _AddGuidelineCategoryFormState extends State<AddGuidelineCategoryForm> {
  GlobalKey<FormState> formKey = GlobalKey();
  TextEditingController imageTextController = TextEditingController();
  TextEditingController titleTextController = TextEditingController();
  String? selectedHexColor;
  @override
  void initState() {
    if (!(widget.guidelineCategory == null)) {
      imageTextController.text = widget.guidelineCategory?.image ?? "";
      titleTextController.text = widget.guidelineCategory?.title ?? "";
      selectedHexColor = widget.guidelineCategory?.color ?? "";
    }
    super.initState();
  }

  @override
  void dispose() {
    imageTextController.dispose();
    titleTextController.dispose();
    selectedHexColor = null;
    super.dispose();
  }

  void refresh() {
    setState(() {
      imageTextController.clear();
      titleTextController.clear();
      selectedHexColor = null;
    });
  }

  @override
  Widget build(BuildContext context) {
    final GuideLineController glController = Get.find();
    return Form(
      key: formKey,
      child: SingleChildScrollView(
        child: Column(
          children: [
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
            TextFormField(
              validator: (v) => stringValidator("Image Url", v),
              controller: imageTextController,
              decoration: InputDecoration(
                border: dropDownBorder(),
                disabledBorder: dropDownBorder(),
                focusedBorder: dropDownBorder(),
                enabledBorder: dropDownBorder(),
                labelText: "Image Url",
                floatingLabelBehavior: FloatingLabelBehavior.always,
              ),
            ),
            verticalSpace(),
            Wrap(
              children: colorList.map((e) {
                return Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Container(
                      height: 50,
                      width: 50,
                      child: Stack(children: [
                        Align(
                          alignment: Alignment.center,
                          child: InkWell(
                            onTap: () {
                              if (mounted) {
                                setState(() {
                                  selectedHexColor = e;
                                });
                              }
                            },
                            splashColor: Colors.grey,
                            child: CircleAvatar(
                              radius: 25,
                              backgroundColor: HexColor(e),
                            ),
                          ),
                        ),
                        selectedHexColor == e
                            ? Align(
                                alignment: Alignment.center,
                                child: Icon(Icons.check, color: Colors.white))
                            : const SizedBox(),
                      ])),
                );
              }).toList(),
            ),
            ElevatedButton(
              onPressed: () {
                if (formKey.currentState?.validate() == true &&
                    selectedHexColor?.isNotEmpty == true) {
                  var nameList = getNameList(titleTextController.text);
                  if (widget.guidelineCategory == null) {
                    final guidelineCategory = GuideLineCategory(
                      id: Uuid().v1(),
                      title: titleTextController.text,
                      color: selectedHexColor ?? "",
                      image: imageTextController.text,
                      dateTime: DateTime.now(),
                      nameList: nameList,
                    );
                    upload<GuideLineCategory>(
                        glCategoryDocument(guidelineCategory.id),
                        guidelineCategory,
                        "Guideline Category uploading is successful.",
                        "Guideline Category uploading is failed.", () {
                      refresh();
                      glController.guideLineCategories.add(guidelineCategory);
                    });

                    debugPrint("******Uploading...Slider");
                  } else {
                    final guidelineCategory = GuideLineCategory(
                      id: widget.guidelineCategory!.id,
                      title: titleTextController.text,
                      color: selectedHexColor ?? "",
                      image: imageTextController.text,
                      dateTime: DateTime.now(),
                      nameList: nameList,
                    );
                    edit<GuideLineCategory>(
                        glCategoryDocument(guidelineCategory.id),
                        guidelineCategory,
                        "Guideline Category updating is successful.",
                        "Guideline Category updating is failed.", () {
                      final index = glController.guideLineCategories.indexWhere(
                          (element) => element.id == guidelineCategory.id);
                      glController.guideLineCategories[index] =
                          guidelineCategory;
                    });

                    debugPrint("******Uploading...Slider");
                  }
                }
              },
              child: Padding(
                padding: const EdgeInsets.all(5.0),
                child: Text(
                  widget.guidelineCategory == null ? "Save" : "Update",
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
