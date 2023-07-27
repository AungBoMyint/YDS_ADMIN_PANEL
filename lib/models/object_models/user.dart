import 'package:YDS/constant/data.dart';
import 'package:json_annotation/json_annotation.dart';

part 'user.g.dart';

@JsonSerializable()
class AuthUser {
  // ignore: deprecated_member_use
  @JsonKey(nullable: true, defaultValue: "id")
  final String id;
  @JsonKey(nullable: true, defaultValue: "emailAddress")
  final String? emailAddress;
  @JsonKey(nullable: true, defaultValue: "userName")
  final String? userName;
  @JsonKey(nullable: true, defaultValue: emptyUserImage)
  final String? image;
  @JsonKey(nullable: true, defaultValue: 0)
  final int points;
  @JsonKey(nullable: true, defaultValue: 0)
  final int? status;
  @JsonKey(nullable: true, defaultValue: "token")
  final String? token;
  @JsonKey(nullable: true)
  final List<String>? nameList;
  AuthUser({
    required this.id,
    required this.emailAddress,
    required this.userName,
    this.image,
    required this.points,
    this.status = 0,
    required this.token,
    this.nameList,
  });

  factory AuthUser.fromJson(Map<String, dynamic> json) =>
      _$AuthUserFromJson(json);

  Map<String, dynamic> toJson() => _$AuthUserToJson(this);
}
