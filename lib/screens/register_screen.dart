import 'package:flutter/material.dart';
import 'login_screen.dart';
import 'dart:io';
import 'package:image_picker/image_picker.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final TextEditingController namaController = TextEditingController();

  final TextEditingController nikController = TextEditingController();

  final TextEditingController hpController = TextEditingController();

  final TextEditingController emailController = TextEditingController();

  final TextEditingController alamatController = TextEditingController();

  final TextEditingController usernameController = TextEditingController();

  final TextEditingController passwordController = TextEditingController();

  final TextEditingController confirmController = TextEditingController();

  bool hidePassword = true;
  bool hideConfirm = true;
  bool agree = false;
  bool isLoading = false;

  String? tipeKeanggotaan;

  Future<void> pickImage(ImageSource source) async {
    final XFile? image = await picker.pickImage(
      source: source,
      imageQuality: 70,
    );

    if (image != null) {
      setState(() {
        ktpImage = File(image.path);
      });
    }
  }

  void showImagePicker() {
    showModalBottomSheet(
      context: context,
      builder: (context) {
        return SafeArea(
          child: Wrap(
            children: [
              ListTile(
                leading: const Icon(Icons.camera_alt),
                title: const Text('Kamera'),
                onTap: () {
                  Navigator.pop(context);
                  pickImage(ImageSource.camera);
                },
              ),
              ListTile(
                leading: const Icon(Icons.photo),
                title: const Text('Galeri'),
                onTap: () {
                  Navigator.pop(context);
                  pickImage(ImageSource.gallery);
                },
              ),
            ],
          ),
        );
      },
    );
  }

  void register() async {
    if (namaController.text.isEmpty ||
        nikController.text.isEmpty ||
        hpController.text.isEmpty ||
        emailController.text.isEmpty ||
        alamatController.text.isEmpty ||
        usernameController.text.isEmpty ||
        passwordController.text.isEmpty ||
        confirmController.text.isEmpty) {

          if (tipeKeanggotaan == null) {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(
                content: Text('Pilih tipe keanggotaan'),
              ),
            );
            return;
          }

          ScaffoldMessenger.of(
            context,
          ).showSnackBar(const SnackBar(content: Text('Semua data wajib diisi')));
          return;
        }

    if (passwordController.text != confirmController.text) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Konfirmasi password tidak sama')),
      );
      return;
    }

    if (ktpImage == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Foto KTP wajib diupload'),
        ),
      );
      return;
    }

    if (!agree) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Setujui syarat dan ketentuan')),
      );
      return;
    }

    setState(() {
      isLoading = true;
    });

    await Future.delayed(const Duration(seconds: 2));

    setState(() {
      isLoading = false;
    });
    
    if (!mounted) return;

    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
          title: const Row(
            children: [
              Icon(Icons.check_circle, color: Colors.green),
              SizedBox(width: 10),
              Text('Berhasil'),
            ],
          ),

          content: Text(
            'Pendaftaran sebagai $tipeKeanggotaan berhasil dikirim.',
          ),

          actions: [
            ElevatedButton(
              onPressed: () {
                Navigator.pop(context);

                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(builder: (_) => const LoginScreen()),
                );
              },
              child: const Text('OK'),
            ),
          ],
        );
      },
    );
  }

  InputDecoration inputDecoration(String hint, IconData icon) {
    return InputDecoration(
      hintText: hint,

      prefixIcon: Icon(icon),

      filled: true,
      fillColor: const Color(0xffF6F3F2),

      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(16),

        borderSide: BorderSide.none,
      ),

      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(16),

        borderSide: const BorderSide(color: Color(0xffAF101A), width: 2),
      ),
    );
  }

  final ImagePicker picker = ImagePicker();
  File? ktpImage;

    @override
    void dispose() {
      namaController.dispose();
      nikController.dispose();
      hpController.dispose();
      emailController.dispose();
      alamatController.dispose();
      usernameController.dispose();
      passwordController.dispose();
      confirmController.dispose();
      super.dispose();
    }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xffFCF9F8),

      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,

        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },

          icon: const Icon(Icons.arrow_back, color: Colors.black),
        ),

        title: const Text(
          'Daftar Anggota Baru',
          style: TextStyle(
            color: Color(0xffAF101A),
            fontWeight: FontWeight.bold,
          ),
        ),
      ),

      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),

        child: Column(
          children: [
            Container(
              height: 200,
              width: double.infinity,

              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),

                image: const DecorationImage(
                  image: AssetImage('assets/images/register.png'),

                  fit: BoxFit.cover,
                ),
              ),

              child: Container(
                padding: const EdgeInsets.all(20),

                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),

                  gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,

                    colors: [
                      Colors.transparent,
                      Colors.black.withAlpha(153), // 0.6 * 255
                    ],
                  ),
                ),

                alignment: Alignment.bottomLeft,

                child: const Text(
                  'Bergabunglah dengan\nKoperasi Desa',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),

            const SizedBox(height: 25),

            sectionTitle(Icons.person, 'Informasi Identitas'),

            const SizedBox(height: 15),

            TextField(
              controller: namaController,

              decoration: inputDecoration('Nama Lengkap', Icons.person),
            ),

            const SizedBox(height: 15),

            TextField(
              controller: nikController,
              keyboardType: TextInputType.number,

              decoration: inputDecoration('Nomor KTP / NIK', Icons.badge),
            ),

            const SizedBox(height: 15),

            Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: hpController,
                    keyboardType: TextInputType.phone,

                    decoration: inputDecoration('Nomor HP', Icons.phone),
                  ),
                ),

                const SizedBox(width: 15),

                Expanded(
                  child: TextField(
                    controller: emailController,
                    keyboardType: TextInputType.emailAddress,

                    decoration: inputDecoration('Email', Icons.email),
                  ),
                ),
              ],
            ),

            const SizedBox(height: 15),

            TextField(
              controller: alamatController,
              maxLines: 3,

              decoration: inputDecoration('Alamat Lengkap', Icons.home),
            ),

            const SizedBox(height: 15),

            DropdownButtonFormField<String>(
              initialValue: tipeKeanggotaan,
              decoration: inputDecoration(
                'Tipe Keanggotaan',
                Icons.group,
              ),
              items: const [
                DropdownMenuItem(
                  value: 'Anggota Biasa',
                  child: Text('Anggota Biasa'),
                ),
                DropdownMenuItem(
                  value: 'Anggota Luar Biasa',
                  child: Text('Anggota Luar Biasa'),
                ),
                DropdownMenuItem(
                  value: 'Anggota Kehormatan',
                  child: Text('Anggota Kehormatan'),
                ),
              ],
              onChanged: (value) {
                setState(() {
                  tipeKeanggotaan = value;
                });
              },
            ),

            const SizedBox(height: 30),

            sectionTitle(Icons.lock, 'Keamanan Akun'),

            const SizedBox(height: 15),

            TextField(
              controller: usernameController,

              decoration: inputDecoration('Username', Icons.alternate_email),
            ),

            const SizedBox(height: 15),

            TextField(
              controller: passwordController,
              obscureText: hidePassword,

              decoration: inputDecoration('Password', Icons.lock).copyWith(
                suffixIcon: IconButton(
                  onPressed: () {
                    setState(() {
                      hidePassword = !hidePassword;
                    });
                  },

                  icon: Icon(
                    hidePassword ? Icons.visibility : Icons.visibility_off,
                  ),
                ),
              ),
            ),

            const SizedBox(height: 15),

            TextField(
              controller: confirmController,
              obscureText: hideConfirm,

              decoration:
                  inputDecoration(
                    'Konfirmasi Password',
                    Icons.lock_outline,
                  ).copyWith(
                    suffixIcon: IconButton(
                      onPressed: () {
                        setState(() {
                          hideConfirm = !hideConfirm;
                        });
                      },

                      icon: Icon(
                        hideConfirm ? Icons.visibility : Icons.visibility_off,
                      ),
                    ),
                  ),
            ),

            const SizedBox(height: 30),

            sectionTitle(Icons.upload_file, 'Dokumen Pendukung'),

            const SizedBox(height: 15),

            GestureDetector(
              onTap: showImagePicker,
              child: Container(
                width: double.infinity,
                padding: const EdgeInsets.all(25),

                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),

                  border: Border.all(color: Colors.red.shade200, width: 2),
                ),

                child: ktpImage == null
                    ? Column(
                        children: [
                          CircleAvatar(
                            radius: 35,
                            backgroundColor: Colors.red.shade50,

                            child: const Icon(
                              Icons.photo_camera,
                              size: 35,
                              color: Color(0xffAF101A),
                            ),
                          ),

                          const SizedBox(height: 15),

                          const Text(
                            'Upload Foto KTP',
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),

                          const SizedBox(height: 5),

                          Text(
                            'Tap untuk memilih foto',
                            style: TextStyle(color: Colors.grey.shade600),
                          ),
                        ],
                      )
                    : Column(
                      children: [
                        ClipRRect(
                          borderRadius: BorderRadius.circular(12),
                          child: Image.file(
                            ktpImage!,
                            height: 180,
                            width: double.infinity,
                            fit: BoxFit.cover,
                          ),
                        ),
                        const SizedBox(height: 10),
                        const Text(
                          'Foto KTP berhasil dipilih',
                          style: TextStyle(
                            color: Colors.green,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
              ),
            ),

            const SizedBox(height: 25),

            Row(
              crossAxisAlignment: CrossAxisAlignment.start,

              children: [
                Checkbox(
                  value: agree,

                  activeColor: const Color(0xffAF101A),

                  onChanged: (value) {
                    setState(() {
                      agree = value ?? false;
                    });
                  },
                ),

                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.only(top: 12),

                    child: RichText(
                      text: const TextSpan(
                        style: TextStyle(color: Colors.black54),

                        children: [
                          TextSpan(text: 'Saya menyetujui '),

                          TextSpan(
                            text: 'syarat dan ketentuan',
                            style: TextStyle(
                              color: Color(0xffAF101A),
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),

            const SizedBox(height: 25),

            SizedBox(
              width: double.infinity,
              height: 55,

              child: ElevatedButton(
                onPressed: isLoading ? null : register,

                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xffAF101A),

                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16),
                  ),
                ),

                child: isLoading
                    ? const CircularProgressIndicator(color: Colors.white)
                    : const Text(
                        'DAFTAR SEKARANG',
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          letterSpacing: 1,
                        ),
                      ),
              ),
            ),

            const SizedBox(height: 20),

            Row(
              mainAxisAlignment: MainAxisAlignment.center,

              children: [
                const Text('Sudah punya akun?'),

                TextButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (_) => const LoginScreen()),
                    );
                  },

                  child: const Text(
                    'Masuk',
                    style: TextStyle(
                      color: Color(0xffAF101A),
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget sectionTitle(IconData icon, String title) {
    return Row(
      children: [
        Icon(icon, color: const Color(0xffAF101A)),

        const SizedBox(width: 10),

        Text(
          title,
          style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        ),
      ],
    );
  }
}
