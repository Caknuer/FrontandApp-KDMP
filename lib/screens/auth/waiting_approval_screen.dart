import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:http/http.dart' as http;

import '../../config/api_config.dart';
import '../dashboard_screen.dart';
import 'rejected_screen.dart';

class WaitingApprovalScreen extends StatefulWidget {
  const WaitingApprovalScreen({super.key});

  @override
  State<WaitingApprovalScreen> createState() =>
      _WaitingApprovalScreenState();
}

class _WaitingApprovalScreenState
    extends State<WaitingApprovalScreen> {

  bool isLoading = false;

  Future<void> checkStatus() async {

    try {

      setState(() {
        isLoading = true;
      });

      final user =
          FirebaseAuth.instance.currentUser;

      if (user == null) {
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

      final result =
          jsonDecode(response.body);
      
      debugPrint(response.body);

      if (response.statusCode != 200) {

        throw Exception(
          result["message"],
        );

      }

      final status =
          result["data"]["status"];

      if (!mounted) return;

      if (status == "approved") {

        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (_) =>
                const DashboardScreen(),
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

        ScaffoldMessenger.of(context)
            .showSnackBar(
          const SnackBar(
            content: Text(
              "Status masih menunggu persetujuan",
            ),
          ),
        );

      }

    } catch (e) {

      if (!mounted) return;

      ScaffoldMessenger.of(context)
          .showSnackBar(
        SnackBar(
          content: Text(
            e.toString(),
          ),
        ),
      );

    } finally {

      if (mounted) {

        setState(() {
          isLoading = false;
        });

      }

    }

  }

  Future<void> logout() async {

    await FirebaseAuth.instance.signOut();

    if (!mounted) return;

    Navigator.popUntil(
      context,
      (route) => route.isFirst,
    );

  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(

      backgroundColor:
          const Color(0xffFCF9F8),

      appBar: AppBar(
        title: const Text(
          "Menunggu Persetujuan",
        ),
        centerTitle: true,
        backgroundColor:
            const Color(0xffAF101A),
        foregroundColor: Colors.white,
      ),

      body: Center(

        child: Padding(
          padding:
              const EdgeInsets.all(24),

          child: Column(
            mainAxisAlignment:
                MainAxisAlignment.center,

            children: [

              const Icon(
                Icons.hourglass_top,
                size: 100,
                color: Color(
                  0xffAF101A,
                ),
              ),

              const SizedBox(
                height: 20,
              ),

              const Text(
                "Pendaftaran Sedang Ditinjau",
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 24,
                  fontWeight:
                      FontWeight.bold,
                ),
              ),

              const SizedBox(
                height: 16,
              ),

              const Text(
                "Data Anda telah berhasil dikirim dan sedang menunggu verifikasi admin koperasi.",
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 16,
                  color: Colors.grey,
                ),
              ),

              const SizedBox(
                height: 40,
              ),

              SizedBox(
                width: double.infinity,
                height: 55,

                child: ElevatedButton(
                  onPressed:
                      isLoading
                          ? null
                          : checkStatus,

                  style:
                      ElevatedButton.styleFrom(
                    backgroundColor:
                        const Color(
                      0xffAF101A,
                    ),
                  ),

                  child: isLoading
                      ? const CircularProgressIndicator(
                          color: Colors.white,
                        )
                      : const Text(
                          "CEK STATUS",
                          style: TextStyle(
                            color: Colors.white,
                            fontWeight:
                                FontWeight.bold,
                          ),
                        ),
                ),
              ),

              const SizedBox(
                height: 15,
              ),

              SizedBox(
                width: double.infinity,
                height: 55,

                child: OutlinedButton(
                  onPressed: logout,

                  child: const Text(
                    "LOGOUT",
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}