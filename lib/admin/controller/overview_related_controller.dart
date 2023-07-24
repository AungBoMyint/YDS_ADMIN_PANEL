import 'package:dartz/dartz.dart';
import 'package:get/get.dart';
import 'package:pizza/service/collection_name.dart';
import 'package:pizza/service/reference.dart';
import '../../service/query.dart';

class OverviewRelatedController extends GetxController {
  Rxn<Either<None, int>> users = Rxn(left(None()));
  Rxn<Either<None, int>> courses = Rxn(left(None()));
  Rxn<Either<None, int>> products = Rxn(left(None()));
  Rxn<Either<None, int>> mainQuestions = Rxn(left(None()));
/*   Rxn<Either<None, int>> subQuestions = Rxn(left(None()));
 */
  Rxn<Either<None, int>> mainGuideLine = Rxn(left(None()));
  Rxn<Either<None, int>> subGuideLine = Rxn(left(None()));
  Rxn<Either<None, int>> coursePurchases = Rxn(left(None()));
  Rxn<Either<None, int>> drivingPurchases = Rxn(left(None()));
  Rxn<Either<None, int>> carPurchases = Rxn(left(None()));
  Rxn<Either<None, int>> rewardProductPurchases = Rxn(left(None()));

  getUser() async => userCollectionReference()
      .count()
      .get()
      .then((value) => users.value = right(value.count));
  getCourse() async => courseCollection()
      .count()
      .get()
      .then((value) => courses.value = right(value.count));
  getProduct() async => rproductCollection()
      .count()
      .get()
      .then((value) => products.value = right(value.count));
  getMainQuestion() async => questionCollection()
      .count()
      .get()
      .then((value) => mainQuestions.value = right(value.count));
  /* getSubQuestion() async => sQuestionCollection()
      .count()
      .get()
      .then((value) => subQuestions.value = right(value.count)); */
  getMainGuideline() async => glCategoryCollection()
      .count()
      .get()
      .then((value) => mainGuideLine.value = right(value.count));
  getSubGuideline() async => glItemCollection()
      .count()
      .get()
      .then((value) => subGuideLine.value = right(value.count));
  getCoursePurchase() async => courseFormPurchaseCollection()
      .count()
      .get()
      .then((value) => coursePurchases.value = right(value.count));
  getDrivingPurchase() async => drivingLicenceFormPurchaseCollection()
      .count()
      .get()
      .then((value) => drivingPurchases.value = right(value.count));
  getCarPurchase() async => carLicenceFormPurchaseCollection()
      .count()
      .get()
      .then((value) => carPurchases.value = right(value.count));
  getRewardProductPurchase() async => productPurchaseCollection()
      .count()
      .get()
      .then((value) => rewardProductPurchases.value = right(value.count));

  getAll() async {
    getUser();
    getCourse();
    getProduct();
    getMainQuestion();
    /* getSubQuestion(); */
    getMainGuideline();
    getSubGuideline();
    getCoursePurchase();
    getDrivingPurchase();
    getCarPurchase();
    getRewardProductPurchase();
  }
}
