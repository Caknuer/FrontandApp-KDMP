import 'package:flutter/material.dart';
import 'dashboard_screen.dart';
import 'riwayat_screen.dart';
import 'info_screen.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xffFCF9F8),

      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        title: const Row(
          children: [
            Icon(
              Icons.account_balance,
              color: Color(0xffAF101A),
            ),
            SizedBox(width: 10),
            Text(
              'Profil Saya',
              style: TextStyle(
                color: Color(0xffAF101A),
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
        actions: [
          IconButton(
            onPressed: () {},
            icon: const Icon(
              Icons.notifications,
              color: Colors.black54,
            ),
          ),
        ],
      ),

      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),

        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [

            // PROFILE
            Container(
              padding: const EdgeInsets.all(16),

              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(20),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withAlpha(13), // 0.05 * 255
                    blurRadius: 10,
                  ),
                ],
              ),

              child: Row(
                children: [

                  Stack(
                    children: [

                      const CircleAvatar(
                        radius: 40,
                        backgroundImage: NetworkImage(
                          'https://i.pravatar.cc/300',
                        ),
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

                  const Column(
                    crossAxisAlignment:
                        CrossAxisAlignment.start,

                    children: [

                      Text(
                        'Budi Santoso',
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),

                      SizedBox(height: 4),

                      Text(
                        'Member ID: ID-98231',
                        style: TextStyle(
                          color: Colors.grey,
                        ),
                      ),

                      SizedBox(height: 8),

                      Chip(
                        backgroundColor:
                            Color(0xffFFDAD6),

                        label: Text(
                          'ANGGOTA AKTIF',
                          style: TextStyle(
                            color: Color(0xff930010),
                            fontWeight: FontWeight.bold,
                            fontSize: 12,
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),

            const SizedBox(height: 20),

            // TOTAL SIMPANAN
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(24),

              decoration: BoxDecoration(
                color: const Color(0xffAF101A),
                borderRadius: BorderRadius.circular(24),
              ),

              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,

                children: [

                  const Text(
                    'Total Simpanan',
                    style: TextStyle(
                      color: Colors.white70,
                    ),
                  ),

                  const SizedBox(height: 10),

                  const Text(
                    'Rp 12.450.000',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 30,
                      fontWeight: FontWeight.bold,
                    ),
                  ),

                  const SizedBox(height: 30),

                  Center(
                    child: SizedBox(
                      width: 180,
                      height: 50,

                      child: ElevatedButton(
                        onPressed: () {

                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (_) =>
                                  const TransactionHistoryScreen(),
                            ),
                          );

                        },

                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.white,

                          shape: RoundedRectangleBorder(
                            borderRadius:
                                BorderRadius.circular(14),
                          ),
                        ),

                        child: const Row(
                          mainAxisAlignment:
                              MainAxisAlignment.center,

                          children: [

                            Icon(
                              Icons.receipt_long,
                              color: Color(0xffAF101A),
                            ),

                            SizedBox(width: 8),

                            Text(
                              'Riwayat',
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
            ),

            buildMenuItem(
              icon: Icons.lock,
              title: 'Keamanan & Kata Sandi',
            ),

            buildMenuItem(
              icon: Icons.payment,
              title: 'Metode Pembayaran',
            ),

            buildMenuItem(
              icon: Icons.help,
              title: 'Pusat Bantuan',
            ),

            buildMenuItem(
              icon: Icons.description,
              title: 'Syarat & Ketentuan',
            ),

            const SizedBox(height: 30),

            SizedBox(
              width: double.infinity,
              height: 55,

              child: OutlinedButton.icon(
                onPressed: () {},

                style: OutlinedButton.styleFrom(
                  side: const BorderSide(
                    color: Color(0xffAF101A),
                    width: 2,
                  ),

                  shape: RoundedRectangleBorder(
                    borderRadius:
                        BorderRadius.circular(16),
                  ),
                ),

                icon: const Icon(
                  Icons.logout,
                  color: Color(0xffAF101A),
                ),

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
                style: TextStyle(
                  color: Colors.grey,
                ),
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

          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (_) => const DashboardScreen(),
            ),
          );

        } else if (index == 1) {

          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (_) => const TransactionHistoryScreen(),
            ),
          );

        } else if (index == 2) {

          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (_) => const InfoScreen(),
            ),
          );

        } else if (index == 3) {

          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (_) => const ProfileScreen(),
            ),
          );

        }

      },

        items: const [

          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Beranda',
          ),

          BottomNavigationBarItem(
            icon: Icon(Icons.history),
            label: 'Riwayat',
          ),

          BottomNavigationBarItem(
            icon: Icon(Icons.info),
            label: 'Info',
          ),

          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: 'Akun',
          ),
        ],
      ),
    );
  }

  Widget buildMenuItem({
    required IconData icon,
    required String title,
  }) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),

      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
      ),

      child: ListTile(
        leading: CircleAvatar(
          backgroundColor:
              const Color(0xffAF101A).withAlpha(26), // 0.1 * 255

          child: Icon(
            icon,
            color: const Color(0xffAF101A),
          ),
        ),

        title: Text(title),

        trailing: const Icon(
          Icons.chevron_right,
        ),

        onTap: () {},
      ),
    );
  }
}