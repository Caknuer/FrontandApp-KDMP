import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:http/http.dart' as http;
import '../../config/api_config.dart';
import 'waiting_approval_screen.dart';
import 'rejected_screen.dart';
import 'register_screen.dart';
import '../dashboard_screen.dart';
import '../../services/auth_service.dart';
import '../../services/forgot_password_service.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../services/notification_service.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() =>
      _LoginScreenState();
}

class _LoginScreenState
    extends State<LoginScreen> {

  final TextEditingController emailController =
    TextEditingController();

  final TextEditingController passwordController =
      TextEditingController();

  bool isPasswordHidden = true;
  bool rememberMe = false;
  bool isLoading = false;

  Future<void> saveRememberMe() async {
    final prefs =
        await SharedPreferences.getInstance();
    if (rememberMe) {
      await prefs.setBool(
        "remember_me",
        true,
      );

      await prefs.setString(
        "remember_email",
        emailController.text.trim(),
      );
    } else {
      await prefs.remove(
        "remember_me",
      );

      await prefs.remove(
        "remember_email",
      );
    }
  }

  Future<void> loadRememberMe() async {
    final prefs =
        await SharedPreferences.getInstance();

    final remember =
        prefs.getBool("remember_me") ?? false;

    final email =
        prefs.getString("remember_email") ?? "";

    setState(() {
      rememberMe = remember;
      if (remember) {
        emailController.text = email;
      }
    });
  }

  Future<void> login() async {

    if (emailController.text.isEmpty ||
        passwordController.text.isEmpty) {

      ScaffoldMessenger.of(context)
          .showSnackBar(
        const SnackBar(
          content: Text(
            "Email dan password wajib diisi",
          ),
        ),
      );

      return;

    }

    try {

      setState(() {
        isLoading = true;
      });

      final credential =
          await FirebaseAuth.instance
              .signInWithEmailAndPassword(
        email: emailController.text.trim(),
        password: passwordController.text.trim(),
      );
      await NotificationService.requestPermission();
      await NotificationService.saveFcmToken();
      NotificationService.listenTokenRefresh();

      final token =
          await credential.user!
              .getIdToken();

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

      debugPrint(
        response.statusCode.toString(),
      );

      debugPrint(
        response.body,
      );

      final result =
          jsonDecode(response.body);

      if (response.statusCode != 200) {

        throw Exception(
          result["message"] ??
          "Gagal mengambil profile",
        );

      }

      final user = result["data"];
      AuthService.currentUser = user;

      final status = user["status"];

      if (!mounted) return;

      if (status == "pending") {

        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (_) =>
                const WaitingApprovalScreen(),
          ),
        );

        return;

      }

      if (status == "rejected") {

        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (_) =>
                const RejectedScreen(),
          ),
        );

        return;

      }
      
      await saveRememberMe();

      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (_) =>
              const DashboardScreen(),
        ),
      );

    } on FirebaseAuthException catch (e) {

      String message =
          "Login gagal";

      if (e.code ==
          "user-not-found") {

        message =
            "Email tidak ditemukan";

      } else if (e.code ==
          "wrong-password") {

        message =
            "Password salah";

      } else if (e.code ==
          "invalid-credential") {

        message =
            "Email atau password salah";

      }

      ScaffoldMessenger.of(context)
          .showSnackBar(
        SnackBar(
          content:
              Text(message),
        ),
      );

    } catch (e) {

      ScaffoldMessenger.of(context)
          .showSnackBar(
        SnackBar(
          content:
              Text(e.toString()),
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

  Future<void> showForgotPasswordDialog() async {
    final controller =
        TextEditingController();
    await showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text(
            "Lupa Password",
          ),
          content: TextField(
            controller: controller,
            keyboardType:
                TextInputType.emailAddress,
            decoration: const InputDecoration(
              labelText: "Email",
              hintText:
                  "Masukkan email akun",
            ),
          ),

          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: const Text("Batal"),
            ),

            ElevatedButton(
              onPressed: () async {
                final error =
                    await ForgotPasswordService
                        .resetPassword(
                  controller.text,
                );
                if (!mounted) return;
                Navigator.pop(context);
                ScaffoldMessenger.of(context)
                    .showSnackBar(
                  SnackBar(
                    content: Text(
                      error ??
                      "Link reset password telah dikirim ke email Anda.",
                    ),
                    backgroundColor:
                        error == null
                            ? Colors.green
                            : Colors.red,
                  ),
                );
              },

              child: const Text("Kirim"),
            ),
          ],
        );
      },
    );
  }

  @override
  void initState() {
    super.initState();
    loadRememberMe();
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      backgroundColor:
          const Color(0xffFCF9F8),

      body: Stack(
        children: [

          Positioned(
            top: -100,
            right: -100,

            child: Container(
              width: 250,
              height: 250,

              decoration: BoxDecoration(
                shape: BoxShape.circle,

                color: Colors.red.withAlpha(204), // 0.8 * 255
              ),
            ),
          ),

          Positioned(
            bottom: -120,
            left: -100,

            child: Container(
              width: 300,
              height: 300,

              decoration: BoxDecoration(
                shape: BoxShape.circle,

                color: Colors.red.withAlpha(128), // 0.5 * 255
              ),
            ),
          ),

          SafeArea(
            child: Center(
              child: SingleChildScrollView(
                padding:
                    const EdgeInsets.all(
                  20,
                ),

                child: Container(
                  width: double.infinity,

                  constraints:
                      const BoxConstraints(
                    maxWidth: 450,
                  ),

                  padding:
                      const EdgeInsets.all(
                    24,
                  ),

                  decoration: BoxDecoration(
                    color: Colors.white
                        .withAlpha(230), // 0.9 * 255

                    borderRadius:
                        BorderRadius.circular(
                      24,
                    ),

                    boxShadow: [

                      BoxShadow(
                        color: Colors.red
                            .withAlpha(204), // 0.8 * 255
                        blurRadius: 20,

                        offset:
                            const Offset(
                          0,
                          10,
                        ),
                      ),
                    ],
                  ),

                  child: Column(
                    crossAxisAlignment:
                        CrossAxisAlignment
                            .center,

                    children: [

                      Container(
                        width: 70,
                        height: 70,

                        decoration:
                            BoxDecoration(
                          color: Colors.red
                              .withAlpha(25), // 0.1 * 255

                          shape:
                              BoxShape.circle,
                        ),

                        child: const Icon(
                          Icons.login,
                          size: 35,
                          color: Color(
                            0xffAF101A,
                          ),
                        ),
                      ),

                      const SizedBox(
                        height: 20,
                      ),

                      const Text(
                        'Selamat Datang',

                        style: TextStyle(
                          fontSize: 28,

                          fontWeight:
                              FontWeight.bold,

                          color:
                              Colors.black87,
                        ),
                      ),

                      const SizedBox(
                        height: 10,
                      ),

                      const Text(
                        'Silakan masuk ke akun koperasi Anda',

                        textAlign:
                            TextAlign.center,

                        style: TextStyle(
                          fontSize: 16,

                          color:
                              Colors.black54,
                        ),
                      ),

                      const SizedBox(
                        height: 35,
                      ),

                      Align(
                        alignment:
                            Alignment
                                .centerLeft,

                        child: Text(
                          'Email',

                          style: TextStyle(
                            fontWeight:
                                FontWeight.w600,

                            color: Colors
                                .grey
                                .shade700,
                          ),
                        ),
                      ),

                      const SizedBox(
                        height: 8,
                      ),

                      TextField(
                        controller:
                            emailController,

                        decoration:
                            InputDecoration(
                          hintText:
                              'Masukkan email',

                          prefixIcon:
                              const Icon(
                            Icons
                                .alternate_email,
                          ),

                          filled: true,

                          fillColor:
                              Colors.white,

                          border:
                              OutlineInputBorder(
                            borderRadius:
                                BorderRadius.circular(
                              16,
                            ),

                            borderSide:
                                BorderSide(
                              color: Colors
                                  .grey
                                  .shade300,
                            ),
                          ),

                          enabledBorder:
                              OutlineInputBorder(
                            borderRadius:
                                BorderRadius.circular(
                              16,
                            ),

                            borderSide:
                                BorderSide(
                              color: Colors
                                  .grey
                                  .shade300,
                            ),
                          ),

                          focusedBorder:
                              OutlineInputBorder(
                            borderRadius:
                                BorderRadius.circular(
                              16,
                            ),

                            borderSide:
                                const BorderSide(
                              color: Color(
                                0xffAF101A,
                              ),

                              width: 2,
                            ),
                          ),
                        ),
                      ),

                      const SizedBox(
                        height: 20,
                      ),

                      Align(
                        alignment:
                            Alignment
                                .centerLeft,

                        child: Text(
                          'Kata Sandi',

                          style: TextStyle(
                            fontWeight:
                                FontWeight.w600,

                            color: Colors
                                .grey
                                .shade700,
                          ),
                        ),
                      ),

                      const SizedBox(
                        height: 8,
                      ),

                      TextField(
                        controller:
                            passwordController,

                        obscureText:
                            isPasswordHidden,

                        decoration:
                            InputDecoration(
                          hintText:
                              'Masukkan kata sandi',

                          prefixIcon:
                              const Icon(
                            Icons.lock,
                          ),

                          suffixIcon:
                              IconButton(
                            onPressed: () {

                              setState(() {
                                isPasswordHidden =
                                    !isPasswordHidden;
                              });

                            },

                            icon: Icon(
                              isPasswordHidden
                                  ? Icons
                                      .visibility
                                  : Icons
                                      .visibility_off,
                            ),
                          ),

                          filled: true,

                          fillColor:
                              Colors.white,

                          border:
                              OutlineInputBorder(
                            borderRadius:
                                BorderRadius.circular(
                              16,
                            ),

                            borderSide:
                                BorderSide(
                              color: Colors
                                  .grey
                                  .shade300,
                            ),
                          ),

                          enabledBorder:
                              OutlineInputBorder(
                            borderRadius:
                                BorderRadius.circular(
                              16,
                            ),

                            borderSide:
                                BorderSide(
                              color: Colors
                                  .grey
                                  .shade300,
                            ),
                          ),

                          focusedBorder:
                              OutlineInputBorder(
                            borderRadius:
                                BorderRadius.circular(
                              16,
                            ),

                            borderSide:
                                const BorderSide(
                              color: Color(
                                0xffAF101A,
                              ),

                              width: 2,
                            ),
                          ),
                        ),
                      ),

                      const SizedBox(
                        height: 18,
                      ),

                      Row(
                        mainAxisAlignment:
                            MainAxisAlignment
                                .spaceBetween,

                        children: [

                          Row(
                            children: [

                              Checkbox(
                                value:
                                    rememberMe,

                                activeColor:
                                    const Color(
                                  0xffAF101A,
                                ),

                                onChanged:
                                    (value) {

                                  setState(() {
                                    rememberMe =
                                        value ??
                                            false;
                                  });

                                },
                              ),

                              const Text(
                                'Ingat Saya',
                              ),
                            ],
                          ),

                          TextButton(
                            onPressed:
                                showForgotPasswordDialog,
                            child: const Text(
                              "Lupa Password?",
                              style: TextStyle(
                                color: Color(0xffAF101A),
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          )
                        ],
                      ),

                      const SizedBox(
                        height: 10,
                      ),

                      SizedBox(
                        width:
                            double.infinity,

                        height: 55,

                        child:
                            ElevatedButton(
                          onPressed:
                              isLoading
                                  ? null
                                  : login,

                          style:
                              ElevatedButton.styleFrom(
                            backgroundColor:
                                const Color(
                              0xffAF101A,
                            ),

                            shape:
                                RoundedRectangleBorder(
                              borderRadius:
                                  BorderRadius.circular(
                                16,
                              ),
                            ),
                          ),

                          child: isLoading
                              ? const SizedBox(
                                  width: 24,
                                  height: 24,

                                  child:
                                      CircularProgressIndicator(
                                    color:
                                        Colors
                                            .white,

                                    strokeWidth:
                                        3,
                                  ),
                                )
                              : const Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment
                                          .center,

                                  children: [

                                    Text(
                                      'MASUK KE AKUN',

                                      style:
                                          TextStyle(
                                        fontWeight:
                                            FontWeight
                                                .bold,

                                        letterSpacing:
                                            1,

                                        color: Colors
                                            .white,
                                      ),
                                    ),

                                    SizedBox(
                                      width:
                                          8,
                                    ),

                                    Icon(
                                      Icons
                                          .arrow_forward,

                                      color: Colors
                                          .white,
                                    ),
                                  ],
                                ),
                        ),
                      ),

                      const SizedBox(
                        height: 30,
                      ),

                      Row(
                        mainAxisAlignment:
                            MainAxisAlignment
                                .center,

                        children: [

                          const Text(
                            'Belum punya akun?',

                            style:
                                TextStyle(
                              color:
                                  Colors
                                      .black54,
                            ),
                          ),

                          TextButton(
                            onPressed: () {

                              Navigator.push(
                                context,

                                MaterialPageRoute(
                                  builder: (_) =>
                                      const RegisterScreen(),
                                ),
                              );

                            },

                            child:
                                const Text(
                              'Daftar Sekarang',

                              style:
                                  TextStyle(
                                color: Color(
                                  0xffAF101A,
                                ),

                                fontWeight:
                                    FontWeight
                                        .bold,
                              ),
                            ),
                          ),
                        ],
                      ),

                      const SizedBox(
                        height: 10,
                      ),

                      Row(
                        mainAxisAlignment:
                            MainAxisAlignment
                                .center,

                        children: [

                          const Icon(
                            Icons
                                .verified_user,

                            size: 18,

                            color: Color(
                              0xffAF101A,
                            ),
                          ),

                          const SizedBox(
                            width: 6,
                          ),

                          Flexible(
                            child: Text(
                              'Terdaftar dan diawasi Dinkop UKM Kabupaten Pasuruan',

                              style:
                                  TextStyle(
                                color: Colors
                                    .grey
                                    .shade600,

                                fontSize: 12,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}