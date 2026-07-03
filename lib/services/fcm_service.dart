import 'package:firebase_messaging/firebase_messaging.dart';

class FCMService {

  static final FirebaseMessaging _messaging =
      FirebaseMessaging.instance;

  static Future<void> initialize() async {

    await _messaging.requestPermission(

      alert: true,
      badge: true,
      sound: true,

    );

    final token =
        await _messaging.getToken();

    print("FCM TOKEN");

    print(token);

  }

}