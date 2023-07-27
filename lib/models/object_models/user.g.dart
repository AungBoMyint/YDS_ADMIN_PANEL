// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AuthUser _$AuthUserFromJson(Map<String, dynamic> json) => AuthUser(
      id: json['id'] as String? ?? 'id',
      emailAddress: json['emailAddress'] as String? ?? 'emailAddress',
      userName: json['userName'] as String? ?? 'userName',
      image: json['image'] as String? ??
          'https://cdn-icons-png.flaticon.com/512/194/194938.png',
      points: json['points'] as int? ?? 0,
      status: json['status'] as int? ?? 0,
      token: json['token'] as String? ?? 'token',
      nameList: (json['nameList'] as List<dynamic>?)
          ?.map((e) => e as String)
          .toList(),
    );

Map<String, dynamic> _$AuthUserToJson(AuthUser instance) => <String, dynamic>{
      'id': instance.id,
      'emailAddress': instance.emailAddress,
      'userName': instance.userName,
      'image': instance.image,
      'points': instance.points,
      'status': instance.status,
      'token': instance.token,
      'nameList': instance.nameList,
    };
