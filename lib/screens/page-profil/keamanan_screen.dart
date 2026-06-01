import 'package:flutter/material.dart';

class SecurityScreen extends StatefulWidget {
  const SecurityScreen({super.key});

  @override
  State<SecurityScreen> createState() => _SecurityScreenState();
}

class _SecurityScreenState extends State<SecurityScreen> {
  bool biometricEnabled = true;
  bool twoFactorEnabled = false;

  bool showCurrentPassword = false;
  bool showNewPassword = false;
  bool showConfirmPassword = false;

  final Color primaryColor = const Color(0xFFAF101A);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFFCF9F8),

      appBar: AppBar(
        backgroundColor: const Color(0xFFFCF9F8),
        elevation: 0,
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back,
            color: primaryColor,
          ),
          onPressed: () => Navigator.pop(context),
        ),
        title: Text(
          'Keamanan & Kata Sandi',
          style: TextStyle(
            color: primaryColor,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),

      body: SingleChildScrollView(
        padding: const EdgeInsets.fromLTRB(16, 24, 16, 120),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _sectionTitle('Ubah Kata Sandi'),

            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.white,
                border: Border.all(
                  color: Colors.grey.shade300,
                ),
                borderRadius: BorderRadius.circular(16),
              ),
              child: Column(
                children: [
                  _passwordField(
                    label: 'Kata Sandi Saat Ini',
                    visible: showCurrentPassword,
                    onToggle: () {
                      setState(() {
                        showCurrentPassword =
                            !showCurrentPassword;
                      });
                    },
                  ),

                  const SizedBox(height: 16),

                  _passwordField(
                    label: 'Kata Sandi Baru',
                    visible: showNewPassword,
                    helper:
                        'Minimal 8 karakter dengan kombinasi huruf dan angka.',
                    onToggle: () {
                      setState(() {
                        showNewPassword =
                            !showNewPassword;
                      });
                    },
                  ),

                  const SizedBox(height: 16),

                  _passwordField(
                    label: 'Konfirmasi Kata Sandi Baru',
                    visible: showConfirmPassword,
                    onToggle: () {
                      setState(() {
                        showConfirmPassword =
                            !showConfirmPassword;
                      });
                    },
                  ),
                ],
              ),
            ),

            const SizedBox(height: 24),

            _sectionTitle('Keamanan Tambahan'),

            Container(
              decoration: BoxDecoration(
                color: Colors.white,
                border: Border.all(
                  color: Colors.grey.shade300,
                ),
                borderRadius: BorderRadius.circular(16),
              ),
              child: Column(
                children: [
                  _securityTile(
                    icon: Icons.fingerprint,
                    title: 'Masuk dengan Biometrik',
                    subtitle: 'Sidik jari atau wajah',
                    value: biometricEnabled,
                    onChanged: (value) {
                      setState(() {
                        biometricEnabled = value;
                      });
                    },
                  ),

                  Divider(
                    height: 1,
                    color: Colors.grey.shade300,
                  ),

                  _securityTile(
                    icon: Icons.verified_user,
                    title: 'Verifikasi 2 Langkah',
                    subtitle:
                        'Keamanan ekstra via SMS/Email',
                    value: twoFactorEnabled,
                    onChanged: (value) {
                      setState(() {
                        twoFactorEnabled = value;
                      });
                    },
                  ),
                ],
              ),
            ),

            const SizedBox(height: 32),

            Center(
              child: Stack(
                clipBehavior: Clip.none,
                children: [
                  Container(
                    width: 96,
                    height: 96,
                    decoration: BoxDecoration(
                      color: const Color(0xFFF0EDED),
                      shape: BoxShape.circle,
                    ),
                    child: const Icon(
                      Icons.shield,
                      size: 48,
                      color: Colors.grey,
                    ),
                  ),
                  Positioned(
                    right: -4,
                    bottom: -4,
                    child: Container(
                      width: 40,
                      height: 40,
                      decoration: BoxDecoration(
                        color: const Color(0xFFD32F2F),
                        shape: BoxShape.circle,
                        border: Border.all(
                          color: const Color(0xFFFCF9F8),
                          width: 4,
                        ),
                      ),
                      child: const Icon(
                        Icons.lock,
                        size: 18,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),

      bottomNavigationBar: SafeArea(
        child: Container(
          padding: const EdgeInsets.all(16),
          decoration: const BoxDecoration(
            color: Colors.white,
          ),
          child: SizedBox(
            height: 56,
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: primaryColor,
                shape: RoundedRectangleBorder(
                  borderRadius:
                      BorderRadius.circular(12),
                ),
              ),
              onPressed: () {},
              child: const Text(
                'Simpan Perubahan',
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _sectionTitle(String title) {
    return Padding(
      padding: const EdgeInsets.only(
        left: 4,
        bottom: 12,
      ),
      child: Text(
        title.toUpperCase(),
        style: const TextStyle(
          fontSize: 13,
          fontWeight: FontWeight.w600,
          color: Color(0xFF5B403D),
        ),
      ),
    );
  }

  Widget _passwordField({
    required String label,
    required bool visible,
    required VoidCallback onToggle,
    String? helper,
  }) {
    return Column(
      crossAxisAlignment:
          CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: const TextStyle(
            color: Color(0xFF5B403D),
            fontSize: 12,
          ),
        ),

        const SizedBox(height: 6),

        TextField(
          obscureText: !visible,
          decoration: InputDecoration(
            filled: true,
            fillColor: const Color(0xFFF6F3F2),
            hintText: '••••••••',
            border: OutlineInputBorder(
              borderRadius:
                  BorderRadius.circular(12),
              borderSide: BorderSide.none,
            ),
            suffixIcon: IconButton(
              icon: Icon(
                visible
                    ? Icons.visibility_off
                    : Icons.visibility,
              ),
              onPressed: onToggle,
            ),
          ),
        ),

        if (helper != null) ...[
          const SizedBox(height: 4),
          Text(
            helper,
            style: TextStyle(
              fontSize: 12,
              color: Colors.grey.shade600,
            ),
          ),
        ]
      ],
    );
  }

  Widget _securityTile({
    required IconData icon,
    required String title,
    required String subtitle,
    required bool value,
    required ValueChanged<bool> onChanged,
  }) {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Row(
        children: [
          Container(
            width: 40,
            height: 40,
            decoration: BoxDecoration(
              color:
                  const Color(0xFFFFDAD6),
              borderRadius:
                  BorderRadius.circular(20),
            ),
            child: Icon(
              icon,
              color: primaryColor,
            ),
          ),

          const SizedBox(width: 16),

          Expanded(
            child: Column(
              crossAxisAlignment:
                  CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: const TextStyle(
                    fontWeight: FontWeight.w600,
                  ),
                ),
                Text(
                  subtitle,
                  style: const TextStyle(
                    color: Colors.grey,
                    fontSize: 13,
                  ),
                ),
              ],
            ),
          ),

          Switch(
            activeThumbColor: primaryColor,
            value: value,
            onChanged: onChanged,
          ),
        ],
      ),
    );
  }
}