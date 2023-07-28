import 'dart:developer';
import 'dart:math';

import 'package:YDS/admin/utils/extensions.dart';
import 'package:YDS/constant/icon.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:uuid/uuid.dart';
import '../../../models/object_models/item.dart';
import '../../../service/reference.dart';
import '../../controller/course_controller.dart';
import '../../utils/func.dart';
import '../../utils/space.dart';
import '../../utils/widgets.dart';

class AddCourseForm extends StatefulWidget {
  const AddCourseForm({
    super.key,
    this.course,
  });

  final ItemModel? course;

  @override
  State<AddCourseForm> createState() => _AddCourseFormState();
}

class _AddCourseFormState extends State<AddCourseForm> {
  GlobalKey<FormState> formKey = GlobalKey();
  TextEditingController nameTextController = TextEditingController();
  /*  TextEditingController photoTextController = TextEditingController();
  TextEditingController photo2TextController = TextEditingController();
  TextEditingController photo3TextController = TextEditingController(); */
  TextEditingController descTextController = TextEditingController();
  TextEditingController priceTextController = TextEditingController();
  TextEditingController typeTextController = TextEditingController();
  TextEditingController startTextController = TextEditingController();
  final CourseController courseController = Get.find();

  @override
  void initState() {
    if (!(widget.course == null)) {
      nameTextController.text = widget.course?.name ?? "";
      courseController.pickedImageList.value = [
        widget.course?.photo ?? "",
        widget.course?.photo2 ?? "",
        widget.course?.photo3 ?? "",
      ];
      /*  photoTextController.text = widget.course?.photo ?? "";
      photo2TextController.text = widget.course?.photo2 ?? "";
      photo3TextController.text = widget.course?.photo3 ?? ""; */
      descTextController.text = widget.course?.desc ?? "";
      priceTextController.text = "${widget.course?.price}";
      typeTextController.text = widget.course?.color ?? "";
      startTextController.text = "${widget.course?.star ?? "0"}";
    }
    super.initState();
  }

  @override
  void dispose() {
    nameTextController.dispose();
    courseController.pickedImageList.value = ["", "", ""];
    /* photoTextController.dispose();
    photo2TextController.dispose();
    photo3TextController.dispose(); */
    descTextController.dispose();
    priceTextController.dispose();
    typeTextController.dispose();
    startTextController.dispose();
    super.dispose();
  }

  void refresh() {
    setState(() {
      nameTextController.clear();
      courseController.pickedImageList.value = ["", "", ""];
      /*    photoTextController.clear();
      photo2TextController.clear();
      photo3TextController.clear(); */
      descTextController.clear();
      priceTextController.clear();
      typeTextController.clear();
      startTextController.clear();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: formKey,
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TextFormField(
              validator: (v) => stringValidator("Name", v),
              controller: nameTextController,
              decoration: InputDecoration(
                border: dropDownBorder(),
                disabledBorder: dropDownBorder(),
                focusedBorder: dropDownBorder(),
                enabledBorder: dropDownBorder(),
                labelText: "Name",
                floatingLabelBehavior: FloatingLabelBehavior.always,
              ),
            ),
            verticalSpace(),
            /*  //Photo1
            TextFormField(
              validator: (v) => stringValidator("Photo1", v),
              controller: photoTextController,
              decoration: InputDecoration(
                border: dropDownBorder(),
                disabledBorder: dropDownBorder(),
                focusedBorder: dropDownBorder(),
                enabledBorder: dropDownBorder(),
                labelText: "Photo1",
                floatingLabelBehavior: FloatingLabelBehavior.always,
              ),
            ),
            verticalSpace(),
            //Photo2
            TextFormField(
              validator: (v) => stringValidator("Photo2", v),
              controller: photo2TextController,
              decoration: InputDecoration(
                border: dropDownBorder(),
                disabledBorder: dropDownBorder(),
                focusedBorder: dropDownBorder(),
                enabledBorder: dropDownBorder(),
                labelText: "Photo2",
                floatingLabelBehavior: FloatingLabelBehavior.always,
              ),
            ),
            verticalSpace(),
            //Photo3
            TextFormField(
              validator: (v) => stringValidator("Photo3", v),
              controller: photo3TextController,
              decoration: InputDecoration(
                border: dropDownBorder(),
                disabledBorder: dropDownBorder(),
                focusedBorder: dropDownBorder(),
                enabledBorder: dropDownBorder(),
                labelText: "Photo3",
                floatingLabelBehavior: FloatingLabelBehavior.always,
              ),
            ),
            verticalSpace(), */
            //description
            TextFormField(
              validator: (v) => stringValidator("Description", v),
              controller: descTextController,
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
            //price
            TextFormField(
              validator: (v) => stringValidator("Price", v),
              controller: priceTextController,
              decoration: InputDecoration(
                border: dropDownBorder(),
                disabledBorder: dropDownBorder(),
                focusedBorder: dropDownBorder(),
                enabledBorder: dropDownBorder(),
                labelText: "Price",
                floatingLabelBehavior: FloatingLabelBehavior.always,
              ),
            ),
            verticalSpace(),
            //Type
            TextFormField(
              validator: (v) => stringValidator("Type", v),
              controller: typeTextController,
              decoration: InputDecoration(
                border: dropDownBorder(),
                disabledBorder: dropDownBorder(),
                focusedBorder: dropDownBorder(),
                enabledBorder: dropDownBorder(),
                labelText: "Type",
                floatingLabelBehavior: FloatingLabelBehavior.always,
              ),
            ),
            verticalSpace(),
            //star
            TextFormField(
              validator: (v) => stringValidator("Star", v),
              controller: startTextController,
              decoration: InputDecoration(
                border: dropDownBorder(),
                disabledBorder: dropDownBorder(),
                focusedBorder: dropDownBorder(),
                enabledBorder: dropDownBorder(),
                labelText: "Star",
                floatingLabelBehavior: FloatingLabelBehavior.always,
              ),
            ),
            verticalSpace(),
            //Product Image Three
            Text("Pick three images:",
                style: TextStyle(color: Colors.grey.shade600)),
            verticalSpace(v: 10),
            Obx(() {
              final images = courseController.pickedImageList;
              if (images.isEmpty) {
                return const SizedBox();
              }
              return Wrap(
                children: [
                  //Image 1
                  CourseImage(
                    courseController: courseController,
                    images: images,
                    index: 0,
                  ),
                  horizontalSpace(v: 10),
                  //Image 2
                  CourseImage(
                    courseController: courseController,
                    images: images,
                    index: 1,
                  ),
                  horizontalSpace(v: 10),
                  //Image 3
                  CourseImage(
                    courseController: courseController,
                    images: images,
                    index: 2,
                  ),
                ],
              );
            }),

            verticalSpace(),
            Align(
              alignment: Alignment.center,
              child: ElevatedButton(
                onPressed: () {
                  if (formKey.currentState?.validate() == true) {
                    List<String> subName = [];
                    var subList = nameTextController.text.split('');
                    for (var i = 0; i < subList.length; i++) {
                      subName.add(nameTextController.text
                          .substring(0, i + 1)
                          .toLowerCase());
                    }

                    if (widget.course == null) {
                      courseController.database
                          .uploadImageList(
                              "courses", courseController.pickedImageList)
                          .then((value) async {
                        final course = ItemModel(
                          id: Uuid().v1(),
                          photo: value[0],
                          photo2: value[1],
                          photo3: value[2],
                          name: nameTextController.text,
                          //memic dateTime
                          deliverytime: DateTime.now().toIso8601String(),
                          price: int.tryParse(priceTextController.text) ?? 0,
                          desc: descTextController.text,
                          color: typeTextController.text,
                          size: "",
                          star: int.tryParse(startTextController.text) ?? 0,
                          category: "",
                          originalPrice: 0,
                          originalQuantity: 0,
                          remainQuantity: 0,
                          nameList: subName,
                        );
                        upload<ItemModel>(
                            courseDocument(course.id),
                            course,
                            "Course uploading is successful.",
                            "Course uploading is failed.", () {
                          refresh();
                          courseController.courses.add(course);
                        });
                      }).onError((error, stackTrace) {
                        print("=========Error Course Uploading: $error");
                      });

                      debugPrint("******Uploading...Slider");
                    } else {
                      courseController.database
                          .uploadImageList(
                              "courses", courseController.pickedImageList)
                          .then((value) async {
                        final course = ItemModel(
                          id: widget.course?.id ?? "",
                          photo: value[0],
                          photo2: value[1],
                          photo3: value[2],
                          name: nameTextController.text,
                          //memic dateTime
                          deliverytime: DateTime.now().toIso8601String(),
                          price: int.tryParse(priceTextController.text) ?? 0,
                          desc: descTextController.text,
                          color: typeTextController.text,
                          size: "",
                          star: int.tryParse(startTextController.text) ?? 0,
                          category: "",
                          originalPrice: 0,
                          originalQuantity: 0,
                          remainQuantity: 0,
                          nameList: subName,
                        );
                        edit<ItemModel>(
                            courseDocument(course.id),
                            course,
                            "Course updating is successful.",
                            "Course updating is failed.", () {
                          final index = courseController.courses
                              .indexWhere((element) => element.id == course.id);
                          courseController.courses[index] = course;
                        });
                      }).onError((error, stackTrace) {
                        print("=========Error Course Updating: $error");
                      });

                      debugPrint("******Uploading...Slider");
                    }
                  }
                },
                child: Padding(
                  padding: const EdgeInsets.all(5.0),
                  child: Text(
                    widget.course == null ? "Save" : "Update",
                    style: GoogleFonts.inter(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 20,
                    ),
                  ),
                ),
              ),
            ),
            verticalSpace(v: 10),
            Align(
              alignment: Alignment.center,
              child: ElevatedButton(
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
            ),
          ],
        ),
      ),
    );
  }
}

class CourseImage extends StatelessWidget {
  const CourseImage({
    super.key,
    required this.courseController,
    required this.images,
    required this.index,
  });

  final CourseController courseController;
  final List<String> images;
  final int index;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => courseController.pickImage(index),
      child: SizedBox(
        height: 100,
        width: 100,
        child: Image.network(
          images[index].isEmpty ? AdminIcon.addImage : images[index],
          fit: BoxFit.contain,
        ),
      ),
    );
  }
}
