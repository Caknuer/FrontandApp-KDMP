import 'package:flutter/material.dart';
import 'register_screen.dart';
import '../dashboard_screen.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() =>
      _LoginScreenState();
}

class _LoginScreenState
    extends State<LoginScreen> {

  final TextEditingController usernameController =
      TextEditingController();

  final TextEditingController passwordController =
      TextEditingController();

  bool isPasswordHidden = true;
  bool rememberMe = false;
  bool isLoading = false;

  void login() async {

    setState(() {
      isLoading = true;
    });

    await Future.delayed(
      const Duration(seconds: 2),
    );

    setState(() {
      isLoading = false;
    });

    if (!mounted) return;

    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (_) =>
            const DashboardScreen(),
      ),
    );
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
                          'Username',

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
                            usernameController,

                        decoration:
                            InputDecoration(
                          hintText:
                              'Masukkan username',

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
                            onPressed: () {},

                            child:
                                const Text(
                              'Lupa Password?',

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