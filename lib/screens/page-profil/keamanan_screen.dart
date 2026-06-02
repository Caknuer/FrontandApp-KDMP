import 'package:flutter/material.dart';

class SecurityScreen extends StatefulWidget {
  const SecurityScreen({super.key});

  @override
  State<SecurityScreen> createState() => _SecurityScreenState();
}

class _SecurityScreenState extends State<SecurityScreen> {
  static const Color primaryColor = Color(0xFFAF101A);

  final _formKey = GlobalKey<FormState>();

  bool _showCurrentPassword = false;
  bool _showNewPassword = false;
  bool _showConfirmPassword = false;

  final TextEditingController currentPasswordController =
      TextEditingController();

  final TextEditingController newPasswordController =
      TextEditingController();

  final TextEditingController confirmPasswordController =
      TextEditingController();
  
  bool isSaving = false;
  bool saved = false;

  Future<void> savePassword() async {
    setState(() {
      isSaving = true;
      saved = false;
    });

    await Future.delayed(
      const Duration(milliseconds: 1500),
    );

    setState(() {
      isSaving = false;
      saved = true;
    });

    await Future.delayed(
      const Duration(seconds: 1),
    );

    if (!mounted) return;

    Navigator.pop(context, true);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFFCF9F8),

      appBar: AppBar(
        backgroundColor: const Color(0xFFFCF9F8),
        elevation: 0,

        leading: IconButton(
          icon: const Icon(
            Icons.arrow_back,
            color: primaryColor,
          ),
          onPressed: () => Navigator.pop(context),
        ),

        title: const Text(
          'Kata Sandi',
          style: TextStyle(
            color: primaryColor,
            fontWeight: FontWeight.bold,
            fontSize: 22,
          ),
        ),

        centerTitle: false,
      ),

      body: Form(
        key: _formKey,
        child: SingleChildScrollView(
        padding: const EdgeInsets.all(16),

        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'UBAH KATA SANDI',
              style: TextStyle(
                fontSize: 13,
                fontWeight: FontWeight.w600,
                color: Color(0xFF5B403D),
                letterSpacing: 1,
              ),
            ),

            const SizedBox(height: 12),

            Container(
              padding: const EdgeInsets.all(16),

              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(16),
                border: Border.all(
                  color: const Color(0xFFE4BEBA),
                ),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withAlpha(8),
                    blurRadius: 8,
                  ),
                ],
              ),

              child: Column(
                children: [
                  _buildPasswordField(
                    label: 'Kata Sandi Saat Ini',
                    controller: currentPasswordController,
                    obscureText: !_showCurrentPassword,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Password lama wajib diisi';

                      }
                      if (value.length < 8) {
                        return 'Minimal 8 karakter';
                      }

                      return null;
                    },
                    onToggle: () {
                      setState(() {
                        _showCurrentPassword =
                            !_showCurrentPassword;
                      });
                    },
                  ),

                  const SizedBox(height: 16),

                  _buildPasswordField(
                    label: 'Kata Sandi Baru',
                    controller: newPasswordController,
                    obscureText: !_showNewPassword,
                    onToggle: () {
                      setState(() {
                        _showNewPassword =
                            !_showNewPassword;
                      });
                    },
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Password baru wajib diisi';
                      }
                      if (value.length < 8) {
                        return 'Minimal 8 karakter';
                      }
                      return null;
                    },
                  ),

                  const SizedBox(height: 6),

                  const Align(
                    alignment: Alignment.centerLeft,
                    child: Padding(
                      padding: EdgeInsets.only(left: 4),
                      child: Text(
                        'Minimal 8 karakter dengan kombinasi huruf dan angka.',
                        style: TextStyle(
                          fontSize: 11,
                          color: Colors.grey,
                        ),
                      ),
                    ),
                  ),

                  const SizedBox(height: 16),

                  _buildPasswordField(
                    label: 'Konfirmasi Kata Sandi Baru',
                    controller:
                        confirmPasswordController,
                    obscureText: !_showConfirmPassword,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Konfirmasi password wajib diisi';
                      }

                      if (value != newPasswordController.text) {
                        return 'Password tidak cocok';
                      }

                      return null;
                    },
                    onToggle: () {
                      setState(() {
                        _showConfirmPassword =
                            !_showConfirmPassword;
                      });
                    },
                  ),
                ],
              ),
            ),

            const SizedBox(height: 120),
          ],
        ),
      ),
      ),

      bottomNavigationBar: SafeArea(
        child: Padding(
          padding: const EdgeInsets.fromLTRB(
            16,
            0,
            16,
            24,
          ),
          child: SizedBox(
            height: 56,

            child: ElevatedButton(
              onPressed: isSaving
                  ? null
                  : () {
                      if (_formKey.currentState!.validate()) {
                        savePassword();
                      }
                    },

                style: ElevatedButton.styleFrom(
                  backgroundColor:
                      saved ? Colors.green : primaryColor,
                  foregroundColor: Colors.white,
                  elevation: 4,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16),
                  ),
                ),

              child: isSaving
                ? const Row(
                    mainAxisAlignment:
                        MainAxisAlignment.center,
                    children: [
                      SizedBox(
                        width: 18,
                        height: 18,
                        child: CircularProgressIndicator(
                          strokeWidth: 2,
                          color: Colors.white,
                        ),
                      ),
                      SizedBox(width: 12),
                      Text("Menyimpan..."),
                    ],
                  )
                : saved
                    ? const Row(
                        mainAxisAlignment:
                            MainAxisAlignment.center,
                        children: [
                          Icon(Icons.check_circle),
                          SizedBox(width: 8),
                          Text("Berhasil Disimpan"),
                        ],
                      )
                    : const Text(
                        'Simpan Perubahan',
                        style: TextStyle(
                          fontWeight: FontWeight.w600,
                          fontSize: 15,
                        ),
                      ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildPasswordField({
    required String label,
    required TextEditingController controller,
    required bool obscureText,
    required VoidCallback onToggle,
    String? Function(String?)? validator,
  })
  
  {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding:
              const EdgeInsets.only(left: 4, bottom: 6),

          child: Text(
            label,
            style: const TextStyle(
              fontSize: 12,
              color: Color(0xFF5B403D),
              fontWeight: FontWeight.w500,
            ),
          ),
        ),

        TextFormField(
          controller: controller,
          obscureText: obscureText,
          validator: validator,
          decoration: InputDecoration(
            hintText: '••••••••',

            filled: true,
            fillColor: const Color(0xFFF6F3F2),

            contentPadding:
                const EdgeInsets.symmetric(
              horizontal: 16,
              vertical: 14,
            ),

            suffixIcon: IconButton(
              icon: Icon(
                obscureText
                    ? Icons.visibility
                    : Icons.visibility_off,
                color: const Color(0xFF5B403D),
              ),
              onPressed: onToggle,
            ),

            border: OutlineInputBorder(
              borderRadius:
                  BorderRadius.circular(12),
              borderSide: BorderSide.none,
            ),

            enabledBorder: OutlineInputBorder(
              borderRadius:
                  BorderRadius.circular(12),
              borderSide: BorderSide.none,
            ),

            focusedBorder: OutlineInputBorder(
              borderRadius:
                  BorderRadius.circular(12),
              borderSide: const BorderSide(
                color: primaryColor,
                width: 2,
              ),
            ),
          ),
        ),
      ],
    );
  }

  @override
  void dispose() {
    currentPasswordController.dispose();
    newPasswordController.dispose();
    confirmPasswordController.dispose();
    super.dispose();
  }

}