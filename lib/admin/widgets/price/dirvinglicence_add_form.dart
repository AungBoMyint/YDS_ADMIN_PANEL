import 'package:YDS/admin/controller/driving_licence_price_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:YDS/admin/controller/guideline_controller.dart';
import 'package:YDS/admin/utils/extensions.dart';
import 'package:YDS/service/reference.dart';
import 'package:uuid/uuid.dart';
import '../../../models/guideline_item.dart';
import '../../../models/object_models/price/cost.dart';
import '../../utils/func.dart';
import '../../utils/space.dart';
import '../../utils/widgets.dart';

class DrivingLicencePriceAddForm extends StatefulWidget {
  const DrivingLicencePriceAddForm({
    super.key,
    this.cost,
  });

  final Cost? cost;

  @override
  State<DrivingLicencePriceAddForm> createState() =>
      _DrivingLicencePriceAddFormState();
}

class _DrivingLicencePriceAddFormState
    extends State<DrivingLicencePriceAddForm> {
  GlobalKey<FormState> formKey = GlobalKey();
  TextEditingController priceTextController = TextEditingController();
  TextEditingController titleTextController = TextEditingController();

  @override
  void initState() {
    if (!(widget.cost == null)) {
      priceTextController.text = "${widget.cost?.cost}";
      titleTextController.text = widget.cost?.desc ?? "";
    }
    super.initState();
  }

  @override
  void dispose() {
    priceTextController.dispose();
    titleTextController.dispose();

    super.dispose();
  }

  void refresh() {
    setState(() {
      priceTextController.clear();
      titleTextController.clear();
    });
  }

  @override
  Widget build(BuildContext context) {
    final DrivingLicencePriceController glController = Get.find();
    return Form(
      key: formKey,
      child: SingleChildScrollView(
        child: Column(
          children: [
            //Title
            TextFormField(
              validator: (v) => stringValidator("Description", v),
              controller: titleTextController,
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

            ElevatedButton(
              onPressed: () {
                if (formKey.currentState?.validate() == true) {
                  if (widget.cost == null) {
                    final cost = Cost(
                      id: Uuid().v1(),
                      desc: titleTextController.text,
                      cost: int.tryParse(priceTextController.text) ?? 0,
                    );
                    upload<Cost>(
                        drivingLicencePriceDocument(cost.id),
                        cost,
                        "Driving Licence Price uploading is successful.",
                        "Driving Licence Price uploading is failed.", () {
                      refresh();
                      glController.dlCosts.add(cost);
                    });
                  } else {
                    final cost = Cost(
                      id: widget.cost?.id ?? "",
                      desc: titleTextController.text,
                      cost: int.tryParse(priceTextController.text) ?? 0,
                    );
                    edit<Cost>(
                        drivingLicencePriceDocument(cost.id),
                        cost,
                        "Driving Licence Price updating is successful.",
                        "Driving Licence Price updating is failed.", () {
                      final index = glController.dlCosts
                          .indexWhere((element) => element.id == cost.id);
                      glController.dlCosts[index] = cost;
                    });
                  }
                }
              },
              child: Padding(
                padding: const EdgeInsets.all(5.0),
                child: Text(
                  widget.cost == null ? "Save" : "Update",
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
