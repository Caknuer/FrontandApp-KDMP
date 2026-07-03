import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:http/http.dart' as http;

import '../../config/api_config.dart';

import 'login_screen.dart';
import 'waiting_approval_screen.dart';
import 'rejected_screen.dart';
import '../../services/notification_service.dart';
import '../dashboard_screen.dart';

class SplashOne extends StatefulWidget {
  const SplashOne({super.key});

  @override
  State<SplashOne> createState() => _SplashOneState();
}

class _SplashOneState extends State<SplashOne> {

  @override
  void initState() {
    super.initState();

    checkLogin();
  }

  Future<void> checkLogin() async {

    await Future.delayed(
      const Duration(seconds: 2),
    );

    try {

      final user =
          FirebaseAuth.instance.currentUser;

      if (user == null) {

        if (!mounted) return;

        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (_) =>
                const LoginScreen(),
          ),
        );

        return;

      }

      final token =
          await user.getIdToken();

      final response =
          await http.get(
        Uri.parse(
          "${ApiConfig.baseUrl}/auth/profile",
        ),
        headers: {
          "Authorization":
              "Bearer $token",
        },
      );

      if (response.statusCode != 200) {

        if (!mounted) return;

        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (_) =>
                const LoginScreen(),
          ),
        );

        return;

      }

      final result =
          jsonDecode(response.body);

      if (!mounted) return;

      final status =
          result["data"]["status"];

      if (status == "approved") {

        await NotificationService.requestPermission();
        await NotificationService.saveFcmToken();
        NotificationService.listenTokenRefresh();

        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (_) =>
                const DashboardScreen(),
          ),
        );

      } else if (
          status == "pending") {

        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (_) =>
                const WaitingApprovalScreen(),
          ),
        );

      } else if (
          status == "rejected") {

        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (_) =>
                const RejectedScreen(),
          ),
        );

      } else {

        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (_) =>
                const LoginScreen(),
          ),
        );

      }

    } catch (e) {

      debugPrint(
        "SPLASH ERROR: $e",
      );

      if (!mounted) return;

      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (_) =>
              const LoginScreen(),
        ),
      );

    }

  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      backgroundColor: Colors.white,

      body: Stack(
        children: [

          Positioned(
            top: -100,
            left: -100,
            child: Container(
              width: 250,
              height: 250,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: Colors.red.withAlpha(128), // 0.5 * 255
              ),
            ),
          ),

          Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [

                Container(
                  width: 140,
                  height: 140,
                  padding: const EdgeInsets.all(20),

                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: Colors.white,
                    boxShadow: [
                      BoxShadow(
                        color: Colors.red.withAlpha(38), // 0.15 * 255
                        blurRadius: 20,
                      ),
                    ],
                  ),

                  child: Image.asset(
                    'assets/images/logo.png',
                  ),
                ),

                const SizedBox(height: 30),

                const Text(
                  'KOPERASI DESA',
                  style: TextStyle(
                    fontSize: 30,
                    fontWeight: FontWeight.bold,
                    color: Color(0xffE31E24),
                  ),
                ),

                const SizedBox(height: 10),

                const Text(
                  'Bersama Membangun Kesejahteraan',
                  style: TextStyle(
                    color: Colors.black54,
                    fontSize: 16,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}