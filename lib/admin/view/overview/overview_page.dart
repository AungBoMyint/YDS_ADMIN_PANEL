import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../constant/icon.dart';
import '../../../models/rbpoint.dart';
import '../../controller/admin_login_controller.dart';
import '../../controller/admin_ui_controller.dart';
import '../../controller/overview_related_controller.dart';
import '../../widgets/datacolumn_rowcontainer.dart';
import '../../widgets/overview/onloading.dart';

class OverviewPage extends StatefulWidget {
  const OverviewPage({
    super.key,
    required this.verticalSpace,
    required this.horizontalSpace,
    required this.girlNetworkImage,
    required this.textTheme,
  });

  final SizedBox Function({double? v}) verticalSpace;
  final SizedBox Function({double? v}) horizontalSpace;
  final String girlNetworkImage;
  final TextTheme textTheme;

  @override
  State<OverviewPage> createState() => _OverviewPageState();
}

class _OverviewPageState extends State<OverviewPage> {
  final OverviewRelatedController orController = Get.find();

  @override
  void initState() {
    /* orController.getAll(); */
    debugPrint("*****************Overview init*******");
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final AdminUiController controller = Get.find();
    final AdminLoginController alController = Get.find();
    final textTheme = Theme.of(context).textTheme;
    return LayoutBuilder(builder: (context, constraints) {
      final width = constraints.maxWidth;
      debugPrint("*******Overview Width: $width");
      return SizedBox(
        width: width,
        child: Card(
          color: Theme.of(context).cardTheme.color,
          //padding: const EdgeInsets.all(10),
          child: SingleChildScrollView(
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(18.0),
                    child: Text(
                      "Here's what's happening with your app today.",
                      style: textTheme.displayMedium?.copyWith(
                        fontSize: controller.rbPoint.value!
                            .getOrElse(() => RBPoint.xl())
                            .map(
                                xl: (_) => 25,
                                desktop: (_) => 22,
                                tablet: (_) => 18,
                                mobile: (_) => 16),
                        color: !alController.isLightTheme.value
                            ? Colors.grey.shade50
                            : Colors.grey.shade700,
                      ),
                    ),
                  ),
                  widget.verticalSpace(),
                  //Container Row
                  Wrap(
                    children: [
                      Obx(
                        () {
                          final newsCategories = orController.courses.value!;
                          return newsCategories.fold(
                            (l) => onLoading(),
                            (r) => DataColumnRowContainer(
                              isSvg: false,
                              horizontalSpace: widget.horizontalSpace,
                              verticalSpace: widget.verticalSpace,
                              topImageIcon: AdminIcon.course,
                              containerBackgroundColor:
                                  alController.isLightTheme.value
                                      ? const Color(0XFFCFF466)
                                      : Colors.black,
                              topData: "သင်တန်းများ",
                              titleData: "$r",
                              subTitleData: "",
                            ),
                          );
                        },
                      ),
                      Obx(
                        () {
                          final newsTypes = orController.products.value!;
                          return newsTypes.fold(
                            (l) => onLoading(),
                            (r) => DataColumnRowContainer(
                              isSvg: false,
                              horizontalSpace: widget.horizontalSpace,
                              verticalSpace: widget.verticalSpace,
                              topImageIcon: AdminIcon.product,
                              containerBackgroundColor:
                                  alController.isLightTheme.value
                                      ? const Color(0XFFCFF466)
                                      : Colors.black,
                              topData: "ဆုတံဆိပ်များ",
                              titleData: "$r",
                              subTitleData: "",
                            ),
                          );
                        },
                      ),
                      Obx(
                        () {
                          final newsItems = orController.purchases.value!;
                          return newsItems.fold(
                            (l) => onLoading(),
                            (r) => DataColumnRowContainer(
                              isSvg: false,
                              horizontalSpace: widget.horizontalSpace,
                              verticalSpace: widget.verticalSpace,
                              topImageIcon: AdminIcon.purchase,
                              containerBackgroundColor:
                                  alController.isLightTheme.value
                                      ? const Color(0XFFCFF466)
                                      : Colors.black,
                              topData: "စာရင်းသွင်းခြင်းများ",
                              titleData: "$r",
                              subTitleData: "",
                            ),
                          );
                        },
                      ),
                      //MainQuestions
                      Obx(
                        () {
                          final vlogVideos = orController.mainQuestions.value!;
                          return vlogVideos.fold(
                            (l) => onLoading(),
                            (r) => DataColumnRowContainer(
                              isSvg: false,
                              horizontalSpace: widget.horizontalSpace,
                              verticalSpace: widget.verticalSpace,
                              topImageIcon: AdminIcon.question,
                              containerBackgroundColor:
                                  alController.isLightTheme.value
                                      ? const Color(0XFFCFF466)
                                      : Colors.black,
                              topData: "ခေါင်းစီးမေးခွန်းများ",
                              titleData: "$r",
                              subTitleData: "",
                            ),
                          );
                        },
                      ),
                      //Sub Questions
                      Obx(() {
                        final therapyCategories =
                            orController.subQuestions.value!;
                        return therapyCategories.fold(
                          (l) => onLoading(),
                          (r) => DataColumnRowContainer(
                            isSvg: false,
                            horizontalSpace: widget.horizontalSpace,
                            verticalSpace: widget.verticalSpace,
                            topImageIcon: AdminIcon.question,
                            containerBackgroundColor:
                                alController.isLightTheme.value
                                    ? const Color(0XFFCFF466)
                                    : Colors.black,
                            topData: "မေးခွန်းခွဲများ",
                            titleData: "$r",
                            subTitleData: "",
                          ),
                        );
                      }),
                      //Main guideline
                      Obx(
                        () {
                          final therapyVideos =
                              orController.mainGuideLine.value!;

                          return therapyVideos.fold(
                            (l) => onLoading(),
                            (r) => DataColumnRowContainer(
                              isSvg: false,
                              horizontalSpace: widget.horizontalSpace,
                              verticalSpace: widget.verticalSpace,
                              topImageIcon: AdminIcon.guideLine,
                              containerBackgroundColor:
                                  alController.isLightTheme.value
                                      ? const Color(0XFFCFF466)
                                      : Colors.black,
                              topData: "ခေါင်းစီးလမ်းညွှန်ချက်များ",
                              titleData: "$r",
                              subTitleData: "",
                            ),
                          );
                        },
                      ),
                      //Sub Guideline
                      Obx(
                        () {
                          final therapyVideos =
                              orController.subGuideLine.value!;

                          return therapyVideos.fold(
                            (l) => onLoading(),
                            (r) => DataColumnRowContainer(
                              isSvg: false,
                              horizontalSpace: widget.horizontalSpace,
                              verticalSpace: widget.verticalSpace,
                              topImageIcon: AdminIcon.guideLine,
                              containerBackgroundColor:
                                  alController.isLightTheme.value
                                      ? const Color(0XFFCFF466)
                                      : Colors.black,
                              topData: "လမ်းညွှန်ချက်ခွဲများ",
                              titleData: "$r",
                              subTitleData: "",
                            ),
                          );
                        },
                      ),
                      //Users
                      Obx(
                        () {
                          final users = orController.users.value!;
                          return users.fold(
                            (l) => onLoading(),
                            (r) => DataColumnRowContainer(
                              isSvg: false,
                              horizontalSpace: widget.horizontalSpace,
                              verticalSpace: widget.verticalSpace,
                              topImageIcon: AdminIcon.users,
                              containerBackgroundColor:
                                  alController.isLightTheme.value
                                      ? const Color(0XFFCFF466)
                                      : Colors.black,
                              topData: "အသုံးပြုသူများ",
                              titleData: "$r",
                              subTitleData: "",
                            ),
                          );
                        },
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      );
    });
  }
}
