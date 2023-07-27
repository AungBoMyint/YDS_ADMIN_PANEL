import 'package:freezed_annotation/freezed_annotation.dart';

part 'page_type.freezed.dart';

@freezed
class PageType with _$PageType {
  const factory PageType.initial() = _Initial;
  const factory PageType.course() = _Course;
  const factory PageType.addCourse() = _AddCourse;
  const factory PageType.rewardProduct() = _RewardProduct;
  const factory PageType.questions() = _Questions;
  const factory PageType.subQuestions() = _SubQuestions;
  const factory PageType.guideLineCategory() = _GuideLineCategory;
  const factory PageType.guideLineItem() = _GuideLineItem;
  const factory PageType.drivingLicencePrice() = _DrivingLicencePrice;
  const factory PageType.carLicencePrice() = _CarLicencePrice;
  const factory PageType.coursePurchase() = _CoursePurchase;
  const factory PageType.drivingLicencePurchase() = _DrivingLicencePurchase;
  const factory PageType.carLicencePurchase() = _CarLicencePurchase;
  const factory PageType.coursePurchaseDetail() = _CoursePurchaseDetail;
  const factory PageType.drivingLicencePurchaseDetail() =
      _DrivingLicencePurchaseDetail;
  const factory PageType.carLicencePurchaseDetail() = _CarLicencePurchaseDetail;
  const factory PageType.productPurchase() = _ProductPurchase;
  const factory PageType.productPurchaseDetail() = _ProductPurchaseDetail;
  const factory PageType.customer() = _Customer;
  const factory PageType.addCustomer() = _AddCustomer;
  const factory PageType.settings() = _Settings;
  const factory PageType.updateProfile() = _UpdateProfile;
}
