import 'package:flutter/material.dart';
import 'dashboard_screen.dart';
import 'riwayat_screen.dart';
import 'profile_screen.dart';

class InfoScreen extends StatelessWidget {
  const InfoScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xffFCF9F8),

      appBar: AppBar(
        backgroundColor: const Color(0xffFCF9F8),
        elevation: 0,
        title: const Row(
          children: [
            Icon(
              Icons.account_balance,
              color: Color(0xffAF101A),
            ),
            SizedBox(width: 10),
            Text(
              'Koperasi Desa',
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
              Icons.search,
              color: Colors.black54,
            ),
          ),
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

            // HERO SECTION
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(24),

              decoration: BoxDecoration(
                color: const Color(0xffD32F2F),
                borderRadius: BorderRadius.circular(24),
              ),

              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [

                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 14,
                      vertical: 6,
                    ),

                    decoration: BoxDecoration(
                      color: Colors.white24,
                      borderRadius: BorderRadius.circular(30),
                    ),

                    child: const Text(
                      'Sejak 1998',
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),

                  const SizedBox(height: 20),

                  const Text(
                    'Membangun Ekonomi Desa Berkelanjutan',
                    style: TextStyle(
                      fontSize: 28,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),

                  const SizedBox(height: 14),

                  const Text(
                    'Koperasi Desa hadir sebagai pilar kemandirian ekonomi masyarakat, memberikan akses layanan keuangan yang adil dan transparan.',
                    style: TextStyle(
                      color: Colors.white70,
                      height: 1.5,
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 24),

            // VISI MISI
            Row(
              children: [

                Expanded(
                  child: buildCard(
                    icon: Icons.visibility,
                    title: 'Visi Kami',
                    content:
                        'Menjadi koperasi modern berbasis teknologi untuk kesejahteraan masyarakat desa.',
                  ),
                ),

                const SizedBox(width: 16),

                Expanded(
                  child: buildCard(
                    icon: Icons.rocket_launch,
                    title: 'Misi Utama',
                    content:
                        'Digitalisasi layanan dan pemberdayaan UMKM lokal.',
                  ),
                ),
              ],
            ),

            const SizedBox(height: 28),

            const Text(
              'Struktur Organisasi',
              style: TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold,
              ),
            ),

            const SizedBox(height: 16),

            SizedBox(
              height: 250,

              child: ListView(
                scrollDirection: Axis.horizontal,
                children: [

                  buildPersonCard(
                    name: 'Ir. Ahmad Subarjo',
                    position: 'Ketua Umum',
                  ),

                  buildPersonCard(
                    name: 'Siti Aminah, M.Ak',
                    position: 'Bendahara',
                  ),

                  buildPersonCard(
                    name: 'Budi Santoso',
                    position: 'Sekretaris',
                  ),
                ],
              ),
            ),

            const SizedBox(height: 28),

            const Text(
              'Kontak & Lokasi',
              style: TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold,
              ),
            ),

            const SizedBox(height: 16),

            Container(
              padding: const EdgeInsets.all(20),

              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(24),
              ),

              child: Column(
                children: [

                  Container(
                    height: 180,
                    decoration: BoxDecoration(
                      color: Colors.grey.shade300,
                      borderRadius: BorderRadius.circular(20),
                    ),

                    child: const Center(
                      child: Icon(
                        Icons.map,
                        size: 80,
                        color: Colors.grey,
                      ),
                    ),
                  ),

                  const SizedBox(height: 20),

                  buildInfoRow(
                    Icons.location_on,
                    'Alamat',
                    'Jl. Raya Desa Makmur No.12, Sleman',
                  ),

                  const SizedBox(height: 16),

                  buildInfoRow(
                    Icons.call,
                    'Telepon',
                    '(0274) 123-456',
                  ),

                  const SizedBox(height: 16),

                  buildInfoRow(
                    Icons.mail,
                    'Email',
                    'halo@kopdesa.id',
                  ),
                ],
              ),
            ),

            const SizedBox(height: 28),

            // LEGALITAS
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(20),

              decoration: BoxDecoration(
                color: const Color(0xffAF101A).withAlpha(26), // 0.1 * 255
                borderRadius: BorderRadius.circular(24),
                border: Border.all(
                  color: const Color(0xffAF101A).withAlpha(26), // 0.1 * 255
                  width: 1.5,
                ),
              ),

              child: Column(
                children: [

                  const Icon(
                    Icons.verified_user,
                    color: Color(0xffAF101A),
                    size: 40,
                  ),

                  const SizedBox(height: 12),

                  const Text(
                    'Legalitas Terjamin',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),

                  const SizedBox(height: 12),

                  const Text(
                    'Koperasi Desa telah terdaftar resmi dan diawasi oleh Kementerian Koperasi dan UKM.',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Colors.black54,
                      height: 1.5,
                    ),
                  ),

                  const SizedBox(height: 20),

                  Row(
                    mainAxisAlignment:
                        MainAxisAlignment.spaceEvenly,

                    children: [

                      Column(
                        children: const [
                          Text(
                            'No. BH',
                            style: TextStyle(
                              color: Color(0xffAF101A),
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          SizedBox(height: 4),
                          Text(
                            '182/BH/M.KUKM/2021',
                          ),
                        ],
                      ),

                      Column(
                        children: const [
                          Text(
                            'NIB',
                            style: TextStyle(
                              color: Color(0xffAF101A),
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          SizedBox(height: 4),
                          Text(
                            '912000345678',
                          ),
                        ],
                      ),
                    ],
                  ),
                ],
              ),
            ),

            const SizedBox(height: 100),
          ],
        ),
      ),

      // BOTTOM NAVIGATION
      bottomNavigationBar: BottomNavigationBar(
      currentIndex: 2,
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

  Widget buildCard({
    required IconData icon,
    required String title,
    required String content,
  }) {

    return Container(
      padding: const EdgeInsets.all(18),

      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
      ),

      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [

          CircleAvatar(
            backgroundColor:
                const Color(0xffAF101A).withAlpha(26), // 0.1 * 255

            child: Icon(
              icon,
              color: const Color(0xffAF101A),
            ),
          ),

          const SizedBox(height: 14),

          Text(
            title,
            style: const TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 18,
            ),
          ),

          const SizedBox(height: 10),

          Text(
            content,
            style: const TextStyle(
              color: Colors.black54,
              height: 1.5,
            ),
          ),
        ],
      ),
    );
  }

  Widget buildPersonCard({
    required String name,
    required String position,
  }) {

    return Container(
      width: 180,
      margin: const EdgeInsets.only(right: 16),
      padding: const EdgeInsets.all(16),

      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(24),
      ),

      child: Column(
        children: [

          const CircleAvatar(
            radius: 40,
            backgroundColor: Colors.grey,
            child: Icon(
              Icons.person,
              size: 40,
              color: Colors.white,
            ),
          ),

          const SizedBox(height: 16),

          Text(
            name,
            textAlign: TextAlign.center,
            style: const TextStyle(
              fontWeight: FontWeight.bold,
            ),
          ),

          const SizedBox(height: 8),

          Text(
            position,
            style: const TextStyle(
              color: Color(0xffAF101A),
            ),
          ),
        ],
      ),
    );
  }

  Widget buildInfoRow(
    IconData icon,
    String title,
    String value,
  ) {

    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [

        Icon(
          icon,
          color: const Color(0xffAF101A),
        ),

        const SizedBox(width: 12),

        Expanded(
          child: Column(
            crossAxisAlignment:
                CrossAxisAlignment.start,

            children: [

              Text(
                title,
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                ),
              ),

              const SizedBox(height: 4),

              Text(
                value,
                style: const TextStyle(
                  color: Colors.black54,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}