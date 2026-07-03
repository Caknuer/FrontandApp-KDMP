import 'package:flutter/material.dart';
import '../dashboard_screen.dart';
import '../riwayat_screen.dart';
import '../info_screen.dart';
import 'editprofil_screen.dart';
import 'keamanan_screen.dart';
import 'syarat_screen.dart';
import 'detailprofil_screen.dart';
import 'dart:io';
import '../auth/login_screen.dart';
import '../../services/profile_service.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  File? profileImage;
  Map<String, dynamic>? profile;
  bool loading = true;

  Future<void> loadProfile() async {
    profile = await ProfileService.getProfile();
    if (mounted) {
      setState(() {
        loading = false;
      });
    }
  }

  @override
  void initState() {
    super.initState();
    loadProfile();
  }

  @override
  Widget build(BuildContext context) {
    if (loading) {
      return const Scaffold(body: Center(child: CircularProgressIndicator()));
    }
    return Scaffold(
      backgroundColor: const Color(0xffFCF9F8),
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        title: const Row(
          children: [
            Text(
              'Profil Saya',
              style: TextStyle(
                color: Color(0xffAF101A),
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),

      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),

        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // PROFILE
            InkWell(
              borderRadius: BorderRadius.circular(20),
              onTap: () async {
                final result =
                    await Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) =>
                        DetailProfilScreen(
                      profile: profile,
                      profileImage:
                          profileImage,
                    ),
                  ),
                );

                if (result == true) {
                  await loadProfile();
                }
              },
              child: Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(20),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withAlpha(13),
                      blurRadius: 10,
                    ),
                  ],
                ),
                child: Row(
                  children: [
                    Stack(
                      children: [
                        CircleAvatar(
                          radius: 40,
                          backgroundColor: Colors.grey.shade300,
                          backgroundImage: profileImage != null
                              ? FileImage(profileImage!)
                              : profile?["foto_profile_url"] != null &&
                                    profile!["foto_profile_url"] != ""
                              ? NetworkImage(profile!["foto_profile_url"])
                              : null,
                          child:
                              profileImage == null &&
                                  (profile?["foto_profile_url"] == null ||
                                      profile!["foto_profile_url"] == "")
                              ? Icon(
                                  Icons.person,
                                  size: 40,
                                  color: Colors.grey.shade600,
                                )
                              : null,
                        ),
                        Positioned(
                          bottom: 0,
                          right: 0,
                          child: Container(
                            padding: const EdgeInsets.all(4),
                            decoration: const BoxDecoration(
                              color: Color(0xffAF101A),
                              shape: BoxShape.circle,
                            ),
                            child: const Icon(
                              Icons.edit,
                              color: Colors.white,
                              size: 16,
                            ),
                          ),
                        ),
                      ],
                    ),

                    const SizedBox(width: 16),

                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            profile?["nama"] ?? "-",
                            style: const TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          SizedBox(height: 4),
                          Text(
                            "Member ID: ${profile?["id"]?.toString().substring(0, 8) ?? "-"}",
                            style: const TextStyle(color: Colors.grey),
                          ),
                          SizedBox(height: 8),
                          Chip(
                            backgroundColor: profile?["status"] == "approved"
                                ? const Color(0xffD8F5D0)
                                : profile?["status"] == "pending"
                                ? const Color(0xffFFF3CD)
                                : const Color(0xffFFDAD6),
                            label: Text(
                              profile?["status"] == "approved"
                                  ? "ANGGOTA AKTIF"
                                  : profile?["status"] == "pending"
                                  ? "MENUNGGU PERSETUJUAN"
                                  : "TIDAK AKTIF",
                              style: TextStyle(
                                color: profile?["status"] == "approved"
                                    ? Colors.green.shade800
                                    : profile?["status"] == "pending"
                                    ? Colors.orange.shade800
                                    : const Color(0xff930010),
                                fontWeight: FontWeight.bold,
                                fontSize: 12,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),

                    const Icon(Icons.chevron_right, color: Colors.grey),
                  ],
                ),
              ),
            ),

            const SizedBox(height: 24),

            const Text(
              'Pengaturan & Informasi',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                color: Colors.black54,
              ),
            ),

            const SizedBox(height: 12),

            buildMenuItem(
              icon: Icons.person,
              title: 'Edit Profil',
              onTap: () async {
                final result = await Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) =>
                        EditProfileScreen(
                      profile: profile,
                      profileImage: profileImage,
                    ),
                  ),
                );

                if (result == true) {
                  await loadProfile();
                }
              },
            ),

            buildMenuItem(
              icon: Icons.lock,
              title: 'Kata Sandi',
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (_) => const SecurityScreen()),
                );
              },
            ),

            buildMenuItem(
              icon: Icons.description,
              title: 'Syarat & Ketentuan',
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (_) => const TermsScreen()),
                );
              },
            ),

            const SizedBox(height: 30),

            SizedBox(
              width: double.infinity,
              height: 55,

              child: OutlinedButton.icon(
                onPressed: () {
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(builder: (_) => const LoginScreen()),
                  );
                },

                style: OutlinedButton.styleFrom(
                  side: const BorderSide(color: Color(0xffAF101A), width: 2),

                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16),
                  ),
                ),

                icon: const Icon(Icons.logout, color: Color(0xffAF101A)),

                label: const Text(
                  'Keluar Akun',
                  style: TextStyle(
                    color: Color(0xffAF101A),
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),

            const SizedBox(height: 20),

            const Center(
              child: Text(
                'Versi Aplikasi 2.4.1',
                style: TextStyle(color: Colors.grey),
              ),
            ),
          ],
        ),
      ),

      bottomNavigationBar: BottomNavigationBar(
        currentIndex: 3,
        selectedItemColor: const Color(0xffAF101A),
        unselectedItemColor: Colors.grey,

        onTap: (index) {
          if (index == 0) {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: (_) => const DashboardScreen()),
            );
          } else if (index == 1) {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                builder: (_) => const TransactionHistoryScreen(),
              ),
            );
          } else if (index == 2) {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: (_) => const InfoScreen()),
            );
          } else if (index == 3) {
            return; // Sudah di halaman profil, tidak perlu navigasi
          }
        },

        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Beranda'),

          BottomNavigationBarItem(icon: Icon(Icons.history), label: 'Riwayat'),

          BottomNavigationBarItem(icon: Icon(Icons.info), label: 'Info'),

          BottomNavigationBarItem(icon: Icon(Icons.person), label: 'Akun'),
        ],
      ),
    );
  }

  Widget buildMenuItem({
    required IconData icon,
    required String title,
    required VoidCallback onTap,
  }) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
      ),
      child: ListTile(
        leading: CircleAvatar(
          backgroundColor: const Color(0xffAF101A).withAlpha(26),
          child: Icon(icon, color: const Color(0xffAF101A)),
        ),
        title: Text(title),
        trailing: const Icon(Icons.chevron_right),
        onTap: onTap,
      ),
    );
  }
}
