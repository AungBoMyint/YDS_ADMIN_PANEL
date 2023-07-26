import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:YDS/models/object_models/item.dart';
import '../models/guideline_category.dart';
import '../models/guideline_item.dart';
import '../models/object_models/form/car_licence_form.dart';
import '../models/object_models/form/course_form.dart';
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
Query<GuideLineCategory> glCategoryQuery() =>
    glCategoryCollection().orderBy("dateTime").limit(10);
Query<GuideLineItem> glItemQuery(String parentId) => glItemCollection()
    .where("parentId", isEqualTo: parentId)
    .orderBy("dateTime")
    .limit(10);
Query<Cost> drivingLicenceCostQuery() =>
    drivingLicencePriceCollection().limit(10);
Query<Cost> carLicenceCostQuery() => carLicencePriceCollection().limit(10);
Query<CourseForm> coursePurchaseQuery() => courseFormPurchaseCollection()
    .orderBy("dateTime")
    .orderBy("name")
    .orderBy("id")
    .limit(10);
Query drivingPurchaseQuery() =>
    drivingLicenceFormPurchaseCollection().orderBy("dateTime").limit(10);
Query<CarLicenceForm> carPurchaseQuery() =>
    carLicenceFormPurchaseCollection().orderBy("dateTime").limit(10);
Query<PurchaseModel> rewardPurchaseQuery() =>
    productPurchaseCollection().orderBy("dateTime").limit(10);
