import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:YDS/admin/controller/reward_product_controller.dart';
import 'package:YDS/admin/utils/extensions.dart';
import 'package:YDS/models/object_models/reward_product.dart';
import 'package:YDS/service/reference.dart';
import 'package:uuid/uuid.dart';
import '../../utils/func.dart';
import '../../utils/space.dart';
import '../../utils/widgets.dart';

class AddRewardForm extends StatefulWidget {
  const AddRewardForm({
    super.key,
    this.rewardProduct,
  });

  final RewardProduct? rewardProduct;

  @override
  State<AddRewardForm> createState() => _AddRewardFormState();
}

class _AddRewardFormState extends State<AddRewardForm> {
  GlobalKey<FormState> formKey = GlobalKey();
  TextEditingController nameTextController = TextEditingController();
  TextEditingController imageTextController = TextEditingController();

  TextEditingController descTextController = TextEditingController();

  TextEditingController requirePointTextController = TextEditingController();

  @override
  void initState() {
    if (!(widget.rewardProduct == null)) {
      nameTextController.text = widget.rewardProduct?.name ?? "";
      imageTextController.text = widget.rewardProduct?.image ?? "";
      descTextController.text = widget.rewardProduct?.description ?? "";
      requirePointTextController.text =
          "${widget.rewardProduct?.requirePoint ?? ""}";
    }
    super.initState();
  }

  @override
  void dispose() {
    nameTextController.dispose();
    imageTextController.dispose();
    descTextController.dispose();
    requirePointTextController.dispose();
    super.dispose();
  }

  void refresh() {
    setState(() {
      nameTextController.clear();
      imageTextController.clear();
      descTextController.clear();
      requirePointTextController.clear();
    });
  }

  @override
  Widget build(BuildContext context) {
    final RewardProductController rewardProductController = Get.find();
    return Form(
      key: formKey,
      child: SingleChildScrollView(
        child: Column(
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
            //Photo1
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
            //Required Point
            TextFormField(
              validator: (v) => stringValidator("Required Point", v),
              controller: requirePointTextController,
              decoration: InputDecoration(
                border: dropDownBorder(),
                disabledBorder: dropDownBorder(),
                focusedBorder: dropDownBorder(),
                enabledBorder: dropDownBorder(),
                labelText: "Required Point",
                floatingLabelBehavior: FloatingLabelBehavior.always,
              ),
            ),
            verticalSpace(),

            ElevatedButton(
              onPressed: () {
                if (formKey.currentState?.validate() == true) {
                  List<String> subName = [];
                  var subList = nameTextController.text.split('');
                  for (var i = 0; i < subList.length; i++) {
                    subName.add(nameTextController.text
                        .substring(0, i + 1)
                        .toLowerCase());
                  }
                  log("SubName: ${subName}");

                  if (widget.rewardProduct == null) {
                    final rewardProduct = RewardProduct(
                      id: Uuid().v1(),
                      name: nameTextController.text,
                      image: imageTextController.text,
                      nameList: subName,
                      description: descTextController.text,
                      dateTime: DateTime.now(),
                      requirePoint:
                          int.tryParse(requirePointTextController.text) ?? 0,
                    );
                    upload<RewardProduct>(
                        rproductDocument(rewardProduct.id),
                        rewardProduct,
                        "Reward Product uploading is successful.",
                        "Reward Product uploading is failed.", () {
                      refresh();
                      rewardProductController.rewardProducts.add(rewardProduct);
                    });

                    debugPrint("******Uploading...Slider");
                  } else {
                    final rewardProduct = RewardProduct(
                      id: widget.rewardProduct?.id ?? "",
                      name: nameTextController.text,
                      image: imageTextController.text,
                      description: descTextController.text,
                      dateTime: DateTime.now(),
                      nameList: subName,
                      requirePoint:
                          int.tryParse(requirePointTextController.text) ?? 0,
                    );
                    edit<RewardProduct>(
                        rproductDocument(rewardProduct.id),
                        rewardProduct,
                        "Reward Product updating is successful.",
                        "Reward Product updating is failed.", () {
                      final index = rewardProductController.rewardProducts
                          .indexWhere(
                              (element) => element.id == rewardProduct.id);
                      rewardProductController.rewardProducts[index] =
                          rewardProduct;
                    });

                    debugPrint("******Uploading...Slider");
                  }
                }
              },
              child: Padding(
                padding: const EdgeInsets.all(5.0),
                child: Text(
                  widget.rewardProduct == null ? "Save" : "Update",
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
