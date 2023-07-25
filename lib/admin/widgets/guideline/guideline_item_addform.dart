import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:YDS/admin/controller/guideline_controller.dart';
import 'package:YDS/admin/utils/extensions.dart';
import 'package:YDS/service/reference.dart';
import 'package:uuid/uuid.dart';
import '../../../models/guideline_item.dart';
import '../../utils/func.dart';
import '../../utils/space.dart';
import '../../utils/widgets.dart';

class AddGuidelineItemForm extends StatefulWidget {
  const AddGuidelineItemForm({
    super.key,
    this.guidelineItem,
  });

  final GuideLineItem? guidelineItem;

  @override
  State<AddGuidelineItemForm> createState() => _AddGuidelineItemFormState();
}

class _AddGuidelineItemFormState extends State<AddGuidelineItemForm> {
  GlobalKey<FormState> formKey = GlobalKey();
  TextEditingController imageTextController = TextEditingController();
  TextEditingController titleTextController = TextEditingController();

  @override
  void initState() {
    if (!(widget.guidelineItem == null)) {
      imageTextController.text = widget.guidelineItem?.image ?? "";
      titleTextController.text = widget.guidelineItem?.desc ?? "";
    }
    super.initState();
  }

  @override
  void dispose() {
    imageTextController.dispose();
    titleTextController.dispose();

    super.dispose();
  }

  void refresh() {
    setState(() {
      imageTextController.clear();
      titleTextController.clear();
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
              validator: (v) => stringValidator("Image", v),
              controller: imageTextController,
              decoration: InputDecoration(
                border: dropDownBorder(),
                disabledBorder: dropDownBorder(),
                focusedBorder: dropDownBorder(),
                enabledBorder: dropDownBorder(),
                labelText: "Image",
                floatingLabelBehavior: FloatingLabelBehavior.always,
              ),
            ),
            verticalSpace(),

            ElevatedButton(
              onPressed: () {
                if (formKey.currentState?.validate() == true) {
                  var nameList = getNameList(titleTextController.text);
                  if (widget.guidelineItem == null) {
                    final guidelineItem = GuideLineItem(
                      id: Uuid().v1(),
                      desc: titleTextController.text,
                      image: imageTextController.text,
                      dateTime: DateTime.now(),
                      nameList: nameList,
                      parentId: glController.selectedGuideLineCategory
                              .getOrElse(() => null)
                              ?.id ??
                          "",
                    );
                    upload<GuideLineItem>(
                        glItemDocument(guidelineItem.id),
                        guidelineItem,
                        "Guideline Item uploading is successful.",
                        "Guideline Item uploading is failed.", () {
                      refresh();
                      glController.guideLineItems.add(guidelineItem);
                    });

                    debugPrint(
                        "******Guideline item: ${guidelineItem.toJson()}");
                  } else {
                    final guidelineItem = GuideLineItem(
                      id: widget.guidelineItem!.id,
                      desc: titleTextController.text,
                      image: imageTextController.text,
                      dateTime: DateTime.now(),
                      nameList: nameList,
                      parentId: glController.selectedGuideLineCategory
                              .getOrElse(() => null)
                              ?.id ??
                          "",
                    );
                    edit<GuideLineItem>(
                        glItemDocument(guidelineItem.id),
                        guidelineItem,
                        "Guideline Item updating is successful.",
                        "Guideline Item updating is failed.", () {
                      final index = glController.guideLineItems.indexWhere(
                          (element) => element.id == guidelineItem.id);
                      glController.guideLineItems[index] = guidelineItem;
                    });

                    debugPrint(
                        "******Guideline item: ${guidelineItem.toJson()}");
                  }
                }
              },
              child: Padding(
                padding: const EdgeInsets.all(5.0),
                child: Text(
                  widget.guidelineItem == null ? "Save" : "Update",
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
