import 'dart:async';

import 'package:YDS/service/reference.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../admin/utils/widgets.dart';

class FirebaseMessagingService {
  static Future<void> getToken() async {
    FirebaseMessaging.instance.getToken().then(updateToken);
    FirebaseMessaging.instance.onTokenRefresh
        .listen((event) => updateToken(event));
  }

  static Future<void> updateToken(String? token) async {
    final id = FirebaseAuth.instance.currentUser?.uid ?? "";
    print("===========Current User Id:$id");
    await userDocumentReference(id).update({"token": token});
  }

  static Future<void> requestPermission() async {
    FirebaseMessaging messaging = FirebaseMessaging.instance;

    NotificationSettings settings = await messaging.requestPermission(
      alert: true,
      announcement: false,
      badge: true,
      carPlay: false,
      criticalAlert: false,
      provisional: true,
      sound: true,
    );

    //for iOS Foreground
    await messaging.setForegroundNotificationPresentationOptions(
      alert: true, // Required to display a heads up notification
      badge: true,
      sound: true,
    );

    print('User granted permission: ${settings.authorizationStatus}');
  }

  static Future<void> setUpFullNotification() async {
    //for foreground notification listen
    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      RemoteNotification? notification = message.notification;
      AndroidNotification? android = message.notification?.android;
      print("==============Notification Receive====");
      print("=====body:${notification?.body}");
      // If `onMessage` is triggered with a notification, construct our own
      // local notification to show to users using the created channel.
      if (notification != null) {
        Get.snackbar(notification.title ?? "", notification.body ?? "",
            snackPosition: SnackPosition.TOP,
            duration: const Duration(seconds: 2));
      }
    });

    //----SetUp for Backgorund,Terminated State Notification---//

    RemoteMessage? initialMessage =
        await FirebaseMessaging.instance.getInitialMessage();

    if (!(initialMessage == null)) {
      _handleMessage(initialMessage);
    }

    // Also handle any interaction when the app is in the background via a
    // Stream listener
    FirebaseMessaging.onMessageOpenedApp.listen(_handleMessage);
  }

  static void _handleMessage(RemoteMessage message) {
    print("==============Notification Receive====");
    print("=======body:${message.notification?.body}");
    Get.snackbar(
        message.notification?.title ?? "", message.notification?.body ?? "",
        snackPosition: SnackPosition.TOP, duration: const Duration(seconds: 2));
  }
}
