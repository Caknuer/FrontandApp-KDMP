import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';
import 'screens/auth/splash_screen.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'services/fcm_service.dart';
import 'widgets/idle_detector.dart';
import 'services/session_service.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'screens/auth/login_screen.dart';
import 'config/app_navigator.dart';

Future<void> main() async {

  WidgetsFlutterBinding.ensureInitialized();

  await initializeDateFormatting(
    'id_ID',
    null,
  );

  await Firebase.initializeApp(
    options:
        DefaultFirebaseOptions.currentPlatform,
  );
  await FCMService.initialize();

  runApp(
    const MyApp(),
  );

}

class MyApp extends StatelessWidget {

  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {

    return IdleDetector(
      timeout: const Duration(
        minutes: 10,
      ),
      onTimeout: () async {
        try {
          SessionService.stop();
          await FirebaseAuth.instance.signOut();
        } catch (e) {
          debugPrint(
            "AUTO LOGOUT ERROR: $e",
          );
        }
        navigatorKey.currentState?.pushAndRemoveUntil(
          MaterialPageRoute(
            builder: (_) => const LoginScreen(),
          ),
          (route) => false,
        );
      },

      child: MaterialApp(
        navigatorKey: navigatorKey,
        debugShowCheckedModeBanner: false,
        title: 'Koperasi Desa',
        theme: ThemeData(
          fontFamily: 'Roboto',
          primaryColor: Colors.red,
        ),
        home: const SplashOne(),
      ),
    );

  }

}