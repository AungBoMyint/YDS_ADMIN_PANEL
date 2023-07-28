import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dio/dio.dart';

import '../core/key.dart';
import '../models/object_models/user.dart';
import 'collection_name.dart';

class Api {
  static Future<void> sendPushToUser(
      String title, String message, String userId) async {
    FirebaseFirestore.instance
        .collection(normalUserCollection)
        .withConverter<AuthUser>(
          fromFirestore: (data, __) => AuthUser.fromJson(data.data()!),
          toFirestore: (user, __) => user.toJson(),
        )
        .doc(userId)
        .get()
        .then((value) async {
      final user = value.data()!;
      final jsonBody = <String, dynamic>{
        "notification": <String, dynamic>{
          "title": title,
          "body": message,
        },
        "data": <String, dynamic>{
          "click_action": "FLUTTER_NOTIFICATION_CLICK",
          "route": "/home",
        },
        "to": user.token,
      };
      await Dio().post("https://fcm.googleapis.com/fcm/send",
          data: jsonBody,
          options: Options(headers: {
            "Authorization": "key=$fcmKey",
            "Content-Type": "application/json"
          }));
    });
  }

  static Future<void> sendPushToAllUser(String title, String message) async {
    final jsonBody = <String, dynamic>{
      "notification": <String, dynamic>{
        "title": title,
        "body": message,
      },
      "data": <String, dynamic>{
        "click_action": "FLUTTER_NOTIFICATION_CLICK",
        "route": "/home",
      },
      "condition": "'alarm' in topics",
    };
    final response = await Dio().post("https://fcm.googleapis.com/fcm/send",
        data: jsonBody,
        options: Options(headers: {
          "Authorization": "key=$fcmKey",
          "Content-Type": "application/json"
        }));
    print("Response ${response}");
    return;
  }
}
