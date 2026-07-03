import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_messaging/firebase_messaging.dart';

import '../config/api_config.dart';

class NotificationService {

  static Future<void> requestPermission() async {
    final messaging =
        FirebaseMessaging.instance;
    final settings =
        await messaging.requestPermission(

      alert: true,
      badge: true,
      sound: true,

    );

    print(
      "NOTIFICATION PERMISSION : ${settings.authorizationStatus}",
    );
  }

  static Future<String?> getFcmToken() async {
    try {
      final token =
          await FirebaseMessaging
              .instance
              .getToken();
      print("FCM TOKEN : $token");
      return token;
    } catch (e) {
      print(e);
      return null;
    }
  }

  static void listenTokenRefresh() {
    FirebaseMessaging.instance
        .onTokenRefresh
        .listen(

      (newToken) async {

        try {

          final firebaseUser =
              FirebaseAuth.instance.currentUser;

          if (firebaseUser == null) return;

          final idToken =
              await firebaseUser.getIdToken();

          await http.put(

            Uri.parse(
              "${ApiConfig.baseUrl}/auth/fcm-token",
            ),

            headers: {

              "Authorization":
                  "Bearer $idToken",

              "Content-Type":
                  "application/json",

            },

            body: jsonEncode({

              "fcm_token": newToken,

            }),

          );

          print(
            "FCM TOKEN UPDATED",
          );

        } catch (e) {

          print(e);

        }

      },

    );

  }

  // ===========================
  // SAVE FCM TOKEN
  // ===========================
  static Future<void> saveFcmToken() async {

    try {

      final firebaseUser =
          FirebaseAuth.instance.currentUser;

      if (firebaseUser == null) return;

      final idToken =
          await firebaseUser.getIdToken();

      final fcmToken =
          await FirebaseMessaging.instance.getToken();

      if (fcmToken == null) return;

      final response = await http.put(

        Uri.parse(
          "${ApiConfig.baseUrl}/auth/fcm-token",
        ),

        headers: {

          "Authorization":
              "Bearer $idToken",

          "Content-Type":
              "application/json",

        },

        body: jsonEncode({

          "fcm_token": fcmToken,

        }),

      );

      print(
        "SAVE FCM STATUS : ${response.statusCode}",
      );

      print(
        "SAVE FCM BODY : ${response.body}",
      );

    } catch (e) {

      print(
        "SAVE FCM ERROR : $e",
      );

    }

  }

  // ===========================
  // GET NOTIFICATION BY USER
  // ===========================
  static Future<List<dynamic>>
      getNotifications() async {

    try {

      final token =
        await FirebaseAuth
            .instance
            .currentUser!
            .getIdToken();

        final response =
        await http.get(

        Uri.parse(
        "${ApiConfig.baseUrl}/notifications",
        ),

        headers: {
        "Authorization":
        "Bearer $token",

        },
      );

      print(
        "NOTIFICATION STATUS : ${response.statusCode}",
      );

      print(
        "NOTIFICATION BODY : ${response.body}",
      );

      if (response.statusCode != 200) {

        return [];

      }

      final result =
          jsonDecode(response.body);

      return result["data"];

    } catch (e) {

      print(
        "NOTIFICATION ERROR : $e",
      );

      return [];

    }

  }

  // ===========================
  // MARK AS READ
  // ===========================
  static Future<bool> markAsRead(
    String id,
  ) async {

    try {

      final token =
          await FirebaseAuth.instance.currentUser!
              .getIdToken();

      final response = await http.patch(

        Uri.parse(
          "${ApiConfig.baseUrl}/notifications/$id/read",
        ),

        headers: {
          "Authorization":
              "Bearer $token",
        },
      );
      return response.statusCode == 200;
    } catch (e) {
      print(e);
      return false;
    }
  }

  // ===========================
  // MARK ALL AS READ
  // ===========================
  static Future<bool>
      markAllAsRead() async {

    try {

      final token =
        await FirebaseAuth
            .instance
            .currentUser!
            .getIdToken();

        final response =
        await http.patch(

        Uri.parse(
        "${ApiConfig.baseUrl}/notifications/read-all",
        ),

        headers: {
        "Authorization":
        "Bearer $token",

        },
      );

      return response.statusCode == 200;

    } catch (e) {

      print(e);

      return false;

    }

  }

}