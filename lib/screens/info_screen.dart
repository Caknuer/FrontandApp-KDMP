import 'package:flutter/material.dart';
import '../services/company_service.dart';
import '../services/legality_service.dart';
import '../services/management_service.dart';
import 'dashboard_screen.dart';
import 'riwayat_screen.dart';
import 'page-profil/profile_screen.dart';

class InfoScreen extends StatefulWidget {

  const InfoScreen({
    super.key,
  });

  @override
  State<InfoScreen> createState() =>
      _InfoScreenState();

}

class _InfoScreenState
    extends State<InfoScreen> {
  
  Map<String, dynamic>? company;
  Map<String, dynamic>? legality;
  List<dynamic> management = [];
  bool loading = true;

  Future<void> loadData() async {
    final results = await Future.wait([
      CompanyService.getProfile(),
      LegalityService.getLegality(),
      ManagementService.getManagement(),
    ]);

    company = results[0] as Map<String, dynamic>?;
    legality = results[1] as Map<String, dynamic>?;
    management = results[2] as List<dynamic>;

    if (mounted) {
      setState(() {
        loading = false;
      });
    }
  }

  @override
  void initState() {
    super.initState();
    loadData();
  }

  @override
  Widget build(BuildContext context) {
    if (loading) {
      return const Scaffold(
        body: Center(
          child: CircularProgressIndicator(),
        ),
      );
    }
    return Scaffold(
      backgroundColor: const Color(0xffFCF9F8),

      appBar: AppBar(
        backgroundColor: const Color(0xffFCF9F8),
        elevation: 0,
        title: const Row(
          children: [
            Text(
              'Informasi Koperasi Desa',
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

                    child: Text(
                      company?["tahun_berdiri"] != null
                        ? "Sejak ${company!["tahun_berdiri"]}"
                        : "Koperasi Desa",
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),

                  const SizedBox(height: 12,),

                  Text(
                    company?["nama_koperasi"] ??
                        "",
                    style: const TextStyle(
                      color: Colors.white70,
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                    ),
                  ),

                  const SizedBox(height: 20),

                  Text(

                    company?["slogan"] ??
                        "Koperasi Desa Merah Putih",

                    style: const TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),

                  ),

                  const SizedBox(height: 14),

                  Text(
                    company?["deskripsi"] ??
                        "-",
                    style: const TextStyle(
                      color: Colors.white70,
                      height: 1.5,
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 24),

            // VISI MISI
            IntrinsicHeight(
              child: Row(
                children: [
                  Expanded(
                    child: buildCard(
                      icon: Icons.visibility,
                      title: 'Visi Kami',
                      content:
                        company?["visi"] ??
                        "-",
                    ),
                  ),
                  SizedBox(width: 16),
                  Expanded(
                    child: buildCard(
                      icon: Icons.rocket_launch,
                      title: 'Misi Utama',
                      content:
                        company?["misi"] ??
                        "-",
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 28),

            const Text(
              'Struktur Organisasi',
              style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
            ),

            const SizedBox(height: 16),

            management.isEmpty
              ? Container(
                  height: 150,
                  alignment: Alignment.center,
                  child: const Text(
                    "Belum ada data pengurus",
                    style: TextStyle(
                      color: Colors.grey,
                    ),
                  ),
                )
              : SizedBox(
                  height: 250,
                  child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: management.length,
                    itemBuilder: (context, index) {
                      final item = management[index];

                      return buildPersonCard(
                        name: item["nama"] ?? "-",
                        position: item["jabatan"] ?? "-",
                        photo: item["foto_url"]?.toString(),
                      );
                    },
                  ),
                ),

            const SizedBox(height: 28),

            const Text(
              'Kontak & Lokasi',
              style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
            ),

            const SizedBox(height: 16),

            Container(
              padding: const EdgeInsets.all(20),

              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(20),
                border: Border.all(
                  color: const Color(0xffE4BEBA),
                ),
              ),

              child: Column(
                children: [
                  // Container(
                  //   height: 180,
                  //   decoration: BoxDecoration(
                  //     color: Colors.grey.shade300,
                  //     borderRadius: BorderRadius.circular(20),
                  //   ),

                  //   child: const Center(
                  //     child: Icon(
                  //       Icons.map,
                  //       size: 70,
                  //       color: Colors.grey,
                  //     ),
                  //   ),
                  // ),

                  // const SizedBox(height: 20),

                  buildInfoRow(
                    Icons.location_on,
                    'Alamat',
                    company?["alamat"] ?? "-",
                  ),

                  const SizedBox(height: 16),

                  buildInfoRow(
                    Icons.call,
                    'Telepon',
                    company?["telepon"] ?? "-",
                  ),

                  const SizedBox(height: 16),

                  buildInfoRow(
                    Icons.mail,
                    'Email',
                    company?["email"] ?? "-",
                  ),

                  const SizedBox(height: 16),

                  buildInfoRow(
                    Icons.language,
                    'Website',
                    company?["website"] ?? "-",
                  ),

                  const SizedBox(height: 16),

                  buildInfoRow(
                    Icons.access_time,
                    'Jam Operasional',
                    company?["jam_operasional"] ?? "-",
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
                    'Legalitas Koperasi',
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),

                  const SizedBox(height: 12),

                  Text(
                    legality?["nomor_badan_hukum"] != null
                        ? "Koperasi telah memiliki legalitas resmi dan terdaftar sesuai Nomor Badan Hukum."
                        : "Legalitas koperasi belum tersedia.",
                    textAlign: TextAlign.center,
                    style: const TextStyle(
                      color: Colors.black54,
                      height: 1.5,
                    ),
                  ),

                  const SizedBox(height: 20),

                  Wrap(
                    alignment: WrapAlignment.spaceEvenly,
                    spacing: 32,
                    runSpacing: 12,
                    children: [
                      Column(
                        children: [
                          Text(
                            'No. BH',
                            style: TextStyle(
                              color: Color(0xffAF101A),
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          SizedBox(height: 4),
                          Text(
                            legality?["nomor_badan_hukum"] ?? "-",
                          ),
                        ],
                      ),

                      Column(
                        children:
                         [
                          Text(
                            'NIB',
                            style: TextStyle(
                              color: Color(0xffAF101A),
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          SizedBox(height: 4),
                          Text(
                            legality?["nomor_nib"] ?? "-",
                          ),
                        ],
                      ),

                      Column(
                        children: [

                          const Text(
                            'NPWP',
                            style: TextStyle(
                              color: Color(0xffAF101A),
                              fontWeight: FontWeight.bold,
                            ),
                          ),

                          const SizedBox(height: 4),

                          Text(
                            legality?["nomor_npwp"] ?? "-",
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
            return; //Sudah di halaman info
          } else if (index == 3) {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: (_) => const ProfileScreen()),
            );
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
        border: Border.all(
          color: const Color(0xffE4BEBA),
        ),
      ),

      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CircleAvatar(
            backgroundColor: const Color(0xffAF101A).withAlpha(26), // 0.1 * 255

            child: Icon(icon, color: const Color(0xffAF101A)),
          ),

          const SizedBox(height: 14),

          Text(
            title,
            style: const TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 16,
            ),
          ),

          const SizedBox(height: 10),

          Text(
            content,
            style: const TextStyle(
              color: Colors.black54,
              fontSize: 13,
              height: 1.6,
            ),
          ),
        ],
      ),
    );
  }

    Widget buildPersonCard({
      required String name,
      required String position,
      String? photo,
    }) {
    return Container(
      width: 200,
      margin: const EdgeInsets.only(right: 16),
      padding: const EdgeInsets.all(16),

      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(
          color: const Color(0xffE4BEBA),
        ),
      ),

      child: Column(
        children: [
          CircleAvatar(
            radius: 40,
            backgroundColor: Colors.grey.shade200,
            backgroundImage: photo != null && photo.isNotEmpty
              ? NetworkImage(photo)
              : null,
            child: photo == null || photo.isEmpty
              ? const Icon(
                  Icons.person,
                  size: 40,
                  color: Colors.grey,
                )
            : null,
          ),

          const SizedBox(height: 16),

          Text(
            name,
            textAlign: TextAlign.center,
            style: const TextStyle(fontWeight: FontWeight.bold),
          ),

          const SizedBox(height: 8),

          Text(position, style: const TextStyle(color: Color(0xffAF101A))),
        ],
      ),
    );
  }

  Widget buildInfoRow(IconData icon, String title, String value) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Icon(icon, color: const Color(0xffAF101A)),

        const SizedBox(width: 12),

        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,

            children: [
              Text(title, style: const TextStyle(fontWeight: FontWeight.bold)),

              const SizedBox(height: 4),

              Text(value, style: const TextStyle(color: Colors.black54)),
            ],
          ),
        ),
      ],
    );
  }
}
