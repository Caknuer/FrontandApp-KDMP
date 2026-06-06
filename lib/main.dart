import 'package:flutter/material.dart';
import 'screens/auth/splash_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Koperasi Desa',
      theme: ThemeData(
        fontFamily: 'Roboto',
        primaryColor: Colors.red,
      ),
      home: const SplashOne(),
    );
  }
}