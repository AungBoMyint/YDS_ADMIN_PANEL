import 'package:dartz/dartz.dart';
import 'package:get/get.dart';
import '../../core/firebase_reference.dart';
import '../../service/firebase_reference.dart';
import '../../service/query.dart';

class OverviewRelatedController extends GetxController {
  /*  Rxn<Either<None, int>> newsCategories = Rxn(left(None()));
  Rxn<Either<None, int>> newsTypes = Rxn(left(None()));
  Rxn<Either<None, int>> newsItems = Rxn(left(None()));
  Rxn<Either<None, int>> vlogVideos = Rxn(left(None()));
  Rxn<Either<None, int>> therapyCategories = Rxn(left(None()));
  Rxn<Either<None, int>> therapyVideos = Rxn(left(None()));
  Rxn<Either<None, int>> affirmationsCategories = Rxn(left(None()));
  Rxn<Either<None, int>> affirmationsTypes = Rxn(left(None()));
  Rxn<Either<None, int>> affirmationsMusics = Rxn(left(None())); */
  Rxn<Either<None, int>> users = Rxn(right(1000) /* left(None()) */);
  Rxn<Either<None, int>> courses = Rxn(right(4) /* left(None()) */);
  Rxn<Either<None, int>> products = Rxn(right(2) /* left(None()) */);
  Rxn<Either<None, int>> purchases = Rxn(right(2000) /* left(None()) */);
  Rxn<Either<None, int>> mainQuestions = Rxn(right(5) /* left(None()) */);
  Rxn<Either<None, int>> subQuestions = Rxn(right(250) /* left(None()) */);
  Rxn<Either<None, int>> mainGuideLine = Rxn(right(4) /* left(None()) */);
  Rxn<Either<None, int>> subGuideLine = Rxn(right(20) /* left(None()) */);
/* 
  getNewsCategories() async {
    if (newsCategories.value!.getOrElse(() => 0) == 0) {
      final aggreCount = await categoryCollection().count().get();
      newsCategories.value = right(aggreCount.count);
    }
  }

  getNewsTypes() async {
    if (newsTypes.value!.getOrElse(() => 0) == 0) {
      final aggreCount = await homeTypeCollection().count().get();
      newsTypes.value = right(aggreCount.count);
    }
  }

  getNewsItems() async {
    if (newsItems.value!.getOrElse(() => 0) == 0) {
      final aggreCount = await allExpertQuery().count().get();
      newsItems.value = right(aggreCount.count);
    }
  }

  getVlogVideos() async {
    if (vlogVideos.value!.getOrElse(() => 0) == 0) {
      final aggreCount = await vlogVideoCollection().count().get();
      vlogVideos.value = right(aggreCount.count);
    }
  }

  getTherapyCategories() async {
    if (therapyCategories.value!.getOrElse(() => 0) == 0) {
      final aggreCount = await therapyCategoryCollection().count().get();
      therapyCategories.value = right(aggreCount.count);
    }
  }

  getTherapyVideos() async {
    if (therapyVideos.value!.getOrElse(() => 0) == 0) {
      final aggreCount = await therapyVideoCollection().count().get();
      therapyVideos.value = right(aggreCount.count);
    }
  }

  getAffirmationCategories() async {
    if (affirmationsCategories.value!.getOrElse(() => 0) == 0) {
      final aggreCount = await affirmationsCategoryCollection().count().get();
      affirmationsCategories.value = right(aggreCount.count);
    }
  }

  getAffirmationTypes() async {
    if (affirmationsTypes.value!.getOrElse(() => 0) == 0) {
      final aggreCount = await affirmationsTypeCollection().count().get();
      affirmationsTypes.value = right(aggreCount.count);
    }
  }

  getAffirmationMusics() async {
    if (affirmationsMusics.value!.getOrElse(() => 0) == 0) {
      final aggreCount = await allAffirmationsMusicsQuery().count().get();
      affirmationsMusics.value = right(aggreCount.count);
    }
  }

  getUsers() async {
    if (users.value!.getOrElse(() => 0) == 0) {
      final aggreCount = await userCollectionReference().count().get();
      users.value = right(aggreCount.count);
    }
  } */

  /*  void getAll() async {
    getNewsCategories();
    getNewsTypes();
    getNewsItems();
    getVlogVideos();
    getTherapyCategories();
    getTherapyVideos();
    getAffirmationCategories();
    getAffirmationTypes();
    getAffirmationMusics();
    getUsers();
  } */
}
