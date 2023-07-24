// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'reward_product.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_RewardProduct _$$_RewardProductFromJson(Map<String, dynamic> json) =>
    _$_RewardProduct(
      id: json['id'] as String,
      name: json['name'] as String,
      description: json['description'] as String?,
      image: json['image'] as String,
      requirePoint: json['requirePoint'] as int,
      count: json['count'] as int? ?? 0,
      dateTime: json['dateTime'] == null
          ? null
          : DateTime.parse(json['dateTime'] as String),
      nameList: (json['nameList'] as List<dynamic>?)
          ?.map((e) => e as String)
          .toList(),
    );

Map<String, dynamic> _$$_RewardProductToJson(_$_RewardProduct instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'description': instance.description,
      'image': instance.image,
      'requirePoint': instance.requirePoint,
      'count': instance.count,
      'dateTime': instance.dateTime?.toIso8601String(),
      'nameList': instance.nameList,
    };
