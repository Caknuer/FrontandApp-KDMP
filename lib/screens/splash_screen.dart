import 'dart:async';
import 'package:flutter/material.dart';
import 'splash_screentwo.dart';

class SplashOne extends StatefulWidget {
  const SplashOne({super.key});

  @override
  State<SplashOne> createState() => _SplashOneState();
}

class _SplashOneState extends State<SplashOne> {

  @override
  void initState() {
    super.initState();

    Timer(const Duration(seconds: 10), () {

      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (_) => const SplashTwo(),
        ),
      );

    });
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