import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:pizza/models/object_models/item.dart';
import '../models/object_models/form/car_licence_form.dart';
import '../models/object_models/form/course_form.dart';
import '../models/object_models/form/driving_licence_form.dart';
import '../models/object_models/guideline/guideline_category.dart';
import '../models/object_models/guideline/guideline_item.dart';
import '../models/object_models/price/cost.dart';
import '../models/object_models/purchase.dart';
import '../models/object_models/question/question.dart';
import '../models/object_models/question/sub_question.dart';
import '../models/object_models/reward_product.dart';
import 'reference.dart';

Query<ItemModel> allCourseQuery() =>
    courseCollection().orderBy("deliverytime").limit(10);
Query<RewardProduct> rewardProductQuery() =>
    rproductCollection() /* .orderBy("dateTime") */ .limit(10);
Query<Question> questionQuery() =>
    questionCollection().orderBy("qNo").limit(10);
Query<SubQuestion> subQuestionQuery(String mainQuestionId) =>
    sQuestionCollection(mainQuestionId).orderBy("qNo").limit(10);
Query<GuideLineCategory> guideLineCategoryQuery() =>
    glCategoryCollection().orderBy("dateTime").limit(10);
Query<GuideLineItem> guideLineItemQuery() =>
    glItemCollection().orderBy("dateTime").limit(10);
Query<Cost> drivingLicenceCostQuery() =>
    drivingLicencePriceCollection().orderBy("dateTime").limit(10);
Query<Cost> carLicenceCostQuery() =>
    carLicencePriceCollection().orderBy("dateTime").limit(10);
Query<CourseForm> coursePurchaseQuery() =>
    courseFormPurchaseCollection().orderBy("dateTime").limit(10);
Query<DrivingLicenceForm> drivingPurchaseQuery() =>
    drivingLicenceFormPurchaseCollection().orderBy("dateTime").limit(10);
Query<CarLicenceForm> carPurchaseQuery() =>
    carLicenceFormPurchaseCollection().orderBy("dateTime").limit(10);
Query<PurchaseModel> rewardPurchaseQuery() =>
    productPurchaseCollection().orderBy("dateTime").limit(10);
