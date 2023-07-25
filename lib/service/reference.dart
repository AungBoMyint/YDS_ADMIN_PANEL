import 'package:cloud_firestore/cloud_firestore.dart';
import '../models/auth_user.dart';
import '../models/guideline_category.dart';
import '../models/guideline_item.dart';
import '../models/object_models/form/car_licence_form.dart';
import '../models/object_models/form/course_form.dart';
import '../models/object_models/form/driving_licence_form.dart';
import '../models/object_models/item.dart';
import '../models/object_models/price/cost.dart';
import '../models/object_models/purchase.dart';
import '../models/object_models/question/question.dart';
import '../models/object_models/question/sub_question.dart';
import '../models/object_models/reward_product.dart';
import 'collection_name.dart';

//Course
CollectionReference<ItemModel> courseCollection() =>
    FirebaseFirestore.instance.collection(productCollection).withConverter(
          fromFirestore: (snapshot, __) =>
              ItemModel.fromJson(snapshot.data()!, snapshot.id),
          toFirestore: (itemModel, __) => itemModel.toJson(),
        );
DocumentReference<ItemModel> courseDocument(id) => courseCollection().doc(id);

///Reward Product
CollectionReference<RewardProduct> rproductCollection() => FirebaseFirestore
    .instance
    .collection(rewardProductCollection)
    .withConverter(
      fromFirestore: (snapshot, __) => RewardProduct.fromJson(snapshot.data()!),
      toFirestore: (itemModel, __) => itemModel.toJson(),
    );
DocumentReference<RewardProduct> rproductDocument(String id) =>
    rproductCollection().doc(id);

///MainQuestion
CollectionReference<Question> questionCollection() =>
    FirebaseFirestore.instance.collection(mainQuestionCollection).withConverter(
          fromFirestore: (snapshot, __) => Question.fromJson(snapshot.data()!),
          toFirestore: (question, __) => question.toJson(),
        );

///MainQuestion
DocumentReference<Question> questionDocument(String id) =>
    questionCollection().doc(id);

///SubQuestion
CollectionReference<SubQuestion> sQuestionCollection(String mainQuestionId) =>
    FirebaseFirestore.instance
        .collection(mainQuestionCollection)
        .doc(mainQuestionId)
        .collection(subQuestionCollection)
        .withConverter(
            fromFirestore: (snapshot, __) =>
                SubQuestion.fromJson(snapshot.data()!),
            toFirestore: (subquestion, __) => subquestion.toJson());

///SubQuestion
DocumentReference<SubQuestion> sQuestionDocument(
        String mainQuestionId, String id) =>
    sQuestionCollection(mainQuestionId).doc(id);

///GuideLine Category
CollectionReference<GuideLineCategory> glCategoryCollection() =>
    FirebaseFirestore.instance
        .collection(guideLineCategoryCollection)
        .withConverter(
            fromFirestore: (snapshot, __) =>
                GuideLineCategory.fromJson(snapshot.data()!),
            toFirestore: (glCategory, __) => glCategory.toJson());

///GuideLine Category
DocumentReference<GuideLineCategory> glCategoryDocument(String id) =>
    glCategoryCollection().doc(id);

///GuideLine item
CollectionReference<GuideLineItem> glItemCollection() =>
    FirebaseFirestore.instance
        .collection(guideLineItemCollection)
        .withConverter(
            fromFirestore: (snapshot, __) =>
                GuideLineItem.fromJson(snapshot.data()!),
            toFirestore: (glCategory, __) => glCategory.toJson());

///GuideLine item
DocumentReference<GuideLineItem> glItemDocument(String id) =>
    glItemCollection().doc(id);

///Driving Licence
CollectionReference<Cost> drivingLicencePriceCollection() =>
    FirebaseFirestore.instance
        .collection(drivingLicenceCostCollection)
        .withConverter(
            fromFirestore: (snapshot, __) => Cost.fromJson(snapshot.data()!),
            toFirestore: (glCategory, __) => glCategory.toJson());

///Driving Licence
DocumentReference<Cost> drivingLicencePriceDocument(String id) =>
    drivingLicencePriceCollection().doc(id);

///Car Licence
CollectionReference<Cost> carLicencePriceCollection() =>
    FirebaseFirestore.instance
        .collection(carLicenceCostCollection)
        .withConverter(
            fromFirestore: (snapshot, __) => Cost.fromJson(snapshot.data()!),
            toFirestore: (glCategory, __) => glCategory.toJson());

///Car Licence
DocumentReference<Cost> carLicencePriceDocument(String id) =>
    carLicencePriceCollection().doc(id);

///Course Licence Purchase
CollectionReference<CourseForm> courseFormPurchaseCollection() =>
    FirebaseFirestore.instance.collection(courseFormCollection).withConverter(
        fromFirestore: (snapshot, __) => CourseForm.fromJson(snapshot.data()!),
        toFirestore: (glCategory, __) => glCategory.toJson());

///Course Licence Purchase
DocumentReference<CourseForm> courseFormPurchaseDocument(String id) =>
    courseFormPurchaseCollection().doc(id);

///Driving Licence Purchase
CollectionReference<DrivingLicenceForm>
    drivingLicenceFormPurchaseCollection() => FirebaseFirestore.instance
        .collection(drivingLicenceCollection)
        .withConverter(
            fromFirestore: (snapshot, __) =>
                DrivingLicenceForm.fromJson(snapshot.data()!),
            toFirestore: (glCategory, __) => glCategory.toJson());

///Driving Licence Purchase
DocumentReference<DrivingLicenceForm> drivingLicenceFormPurchaseDocument(
        String id) =>
    drivingLicenceFormPurchaseCollection().doc(id);

///Car Licence Purchase
CollectionReference<CarLicenceForm> carLicenceFormPurchaseCollection() =>
    FirebaseFirestore.instance.collection(carLicenceCollection).withConverter(
        fromFirestore: (snapshot, __) =>
            CarLicenceForm.fromJson(snapshot.data()!),
        toFirestore: (glCategory, __) => glCategory.toJson());

///Car Licence Purchase
DocumentReference<CarLicenceForm> carLicenceFormPurchaseDocument(String id) =>
    carLicenceFormPurchaseCollection().doc(id);

///Product Purchase
CollectionReference<PurchaseModel> productPurchaseCollection() =>
    FirebaseFirestore.instance.collection(purchaseCollection).withConverter(
        fromFirestore: (snapshot, __) =>
            PurchaseModel.fromJson(snapshot.data()!),
        toFirestore: (glCategory, __) => glCategory.toJson());

///Product Purchase
DocumentReference<PurchaseModel> productPurchaseDocument(String id) =>
    productPurchaseCollection().doc(id);

//User
CollectionReference<AuthUser> userCollectionReference() =>
    FirebaseFirestore.instance.collection(normalUserCollection).withConverter(
        fromFirestore: (snapshot, __) => AuthUser.fromJson(snapshot.data()!),
        toFirestore: (glCategory, __) => glCategory.toJson());

DocumentReference<AuthUser> userDocumentReference(String id) =>
    userCollectionReference().doc(id);
