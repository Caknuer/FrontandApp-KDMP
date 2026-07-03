import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:firebase_auth/firebase_auth.dart';
import '../config/api_config.dart';
import 'riwayat_screen.dart';
import 'info_screen.dart';
import 'page-profil/profile_screen.dart';
import 'simpanan/simpanan_screen.dart';
import 'news/index_screen.dart';
import 'pengumuman/index_screen.dart';
import 'tarik/tarik_screen.dart';
import 'notifikasi_screen.dart';
import 'news/show_screen.dart';
import '../services/news_service.dart';
import '../services/announcement_service.dart';

class DashboardScreen extends StatefulWidget {
  const DashboardScreen({super.key});

  static const Color primaryColor = Color(0xffAF101A);
  static const Color secondaryColor = Color(0xff8B0D15);

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  bool hasNotification = true;

  String namaUser = "";
  String emailUser = "";
  String statusUser = "";
  String tipeKeanggotaan = "";

  double simpananPokok = 0;
  double simpananWajib = 0;
  double simpananSukarela = 0;
  double totalSaldo = 0;
  double saldoDapatDitarik = 0;
  int jumlahTunggakan = 0;
  double totalTunggakan = 0;

  bool loading = true;

  List<Map<String, dynamic>> informasiTerbaru = [];
  bool loadingInformasi = false;

  @override
    void initState() {
      super.initState();
      loadProfile();
    }

    Future<void> loadProfile() async {
      try {

        final user =
            FirebaseAuth.instance.currentUser;

        if (user == null) return;

        final token =
            await user.getIdToken();

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

        if (response.statusCode == 200) {

          final result =
              jsonDecode(response.body);

          final data =
              result["data"];

          setState(() {

            namaUser =
                data["nama"] ?? "";

            emailUser =
                data["email"] ?? "";

            statusUser =
                data["status"] ?? "";

            tipeKeanggotaan =
                data["tipe_keanggotaan"] ?? "";

            loading = false;

          });

            await loadSaldo(
              data["id"],
            );

            await loadTagihan(
              data["id"],
            );

            await loadInformasi();
        }

      } catch (e) {

        debugPrint(
          "DASHBOARD ERROR: $e",
        );

      }
    }

    Future<void> loadSaldo(String userId) async {
      try {
        final response = await http.get(
          Uri.parse(
            "${ApiConfig.baseUrl}/saldo/$userId",
          ),
        );

        if (response.statusCode == 200) {
          final result =
              jsonDecode(response.body);

          final data =
              result["data"];

          setState(() {
            simpananPokok =
                (data["simpanan_pokok"] ?? 0)
                    .toDouble();

            simpananWajib =
                (data["simpanan_wajib"] ?? 0)
                    .toDouble();

            simpananSukarela =
                (data["simpanan_sukarela"] ?? 0)
                    .toDouble();

            totalSaldo =
                (data["saldo"] ?? 0)
                    .toDouble();

            saldoDapatDitarik =
                (data["saldo_dapat_ditarik"] ?? 0)
                    .toDouble();
          });
        }
      } catch (e) {
        debugPrint(e.toString());
      }
    }

    Future<void> loadTagihan(String userId) async {
      try {
        final response = await http.get(
          Uri.parse(
            "${ApiConfig.baseUrl}/tagihan/user/$userId/summary",
          ),
        );

        if (response.statusCode == 200) {
          final result = jsonDecode(response.body);
          final data = result["data"];

          setState(() {
            jumlahTunggakan =
                data["jumlah_bulan"] ?? 0;

            totalTunggakan =
                (data["total_tunggakan"] ?? 0)
                    .toDouble();
          });
        }
      } catch (e) {
        debugPrint(e.toString());
      }
    }

    Future<void> loadInformasi() async {
      try {
        setState(() {
          loadingInformasi = true;
        });

        final berita =
            await NewsService.getAll();

        final pengumuman =
            await AnnouncementService.getAll();

        final List<Map<String, dynamic>> gabungan = [];

        for (final item in berita) {
          final data =
              Map<String, dynamic>.from(item);

          data["tipe"] = "berita";
          gabungan.add(data);
        }

        for (final item in pengumuman) {
          final data =
              Map<String, dynamic>.from(item);
          data["tipe"] = "pengumuman";
          gabungan.add(data);
        }

        gabungan.sort(
          (a, b) => DateTime.parse(
            b["created_at"],
          ).compareTo(
            DateTime.parse(
              a["created_at"],
            ),
          ),
        );

        setState(() {
          informasiTerbaru =
              gabungan.take(5).toList();

          loadingInformasi = false;
        });

      } catch (e) {

        debugPrint(
          e.toString(),
        );

        setState(() {
          loadingInformasi = false;
        });
      }
    }

  String rupiah(num value) {
    return value
        .toStringAsFixed(0)
        .replaceAllMapped(
          RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))'),
          (m) => '${m[1]}.',
        );
  }
  
  @override
  Widget build(BuildContext context) {

    return Scaffold(
      backgroundColor:
          const Color(0xffFCF9F8),

      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,

        title: Row(
          children: const [
            Text(
              'Dashboard',
              style: TextStyle(
                color: DashboardScreen.primaryColor,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),

        actions: [

          Stack(
            children: [

              IconButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) =>
                          const NotificationPage(),
                    ),
                  );
                },

                icon: const Icon(
                  Icons.notifications,
                  color: Colors.black54,
                ),
              ),

                if (hasNotification)
                  Positioned(
                    top: 14,
                    right: 14,
                    child: Container(
                      width: 10,
                      height: 10,
                      decoration: const BoxDecoration(
                        color: DashboardScreen.primaryColor,
                        shape: BoxShape.circle,
                      ),
                    ),
                  ),
            ],
          ),
        ],
      ),

      body: SingleChildScrollView(
        padding:
            const EdgeInsets.all(20),

        child: Column(
          crossAxisAlignment:
              CrossAxisAlignment.start,

          children: [

            Text(
              'Halo, $namaUser',
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: const TextStyle(
                fontSize: 30,
                fontWeight: FontWeight.bold,
              ),
            ),

            const SizedBox(height: 5),

            Text(
              "$tipeKeanggotaan • $statusUser",
              style: const TextStyle(
                color: Colors.black54,
                fontSize: 16,
              ),
            ),

            const SizedBox(height: 25),

            // ======================
            // CARD SALDO
            // ======================

            Container(
              width: double.infinity,
              padding:
                  const EdgeInsets.all(25),
              decoration: BoxDecoration(
                borderRadius:
                    BorderRadius.circular(30,),
                gradient:
                    const LinearGradient(
                  colors: [
                    DashboardScreen.primaryColor,
                    DashboardScreen.secondaryColor,
                  ],

                  begin: Alignment
                      .topLeft,
                  end: Alignment
                      .bottomRight,
                ),
              ),

              child: Stack(
                children: [
                  Positioned(
                    right: -30,
                    top: -30,
                    child: Container(
                      width: 120,
                      height: 120,
                      decoration:
                          BoxDecoration(
                        color: Colors.white
                            .withAlpha(
                          15,
                        ),
                        shape:
                            BoxShape.circle,
                      ),
                    ),
                  ),
                  Column(
                    crossAxisAlignment:
                        CrossAxisAlignment
                            .start,
                    children: [
                      Row(
                        mainAxisAlignment:
                            MainAxisAlignment
                                .spaceBetween,
                        children: [
                          const Text(
                            'Total Saldo Simpanan',
                            style: TextStyle(
                              color: Colors.white70,
                              fontSize: 20,
                            ),
                          ),
                        ],
                      ),

                      const SizedBox(
                        height: 15,
                      ),

                      Row(
                        crossAxisAlignment:
                            CrossAxisAlignment
                                .end,

                        children: [
                          const Padding(
                            padding: EdgeInsets.only(
                              bottom: 6,
                            ),
                            child: Text(
                              'Rp',
                              style: TextStyle(
                                color: Colors.white70,
                                fontSize: 35,
                              ),
                            ),
                          ),

                          const SizedBox(width: 8),

                          Text(
                            rupiah(totalSaldo),
                            style: const TextStyle(
                              color: Colors.white,
                              fontSize: 47,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ]
                      ),

                      const SizedBox(
                        height: 25,
                      ),
                    ],
                  ),
                ],
              ),
            ),
            
            const SizedBox(height: 15),

            Container(
              padding: const EdgeInsets.all(18),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius:
                    BorderRadius.circular(20),
              ),
              child: Column(
                children: [

                  buildInfoRow(
                    "Simpanan Pokok",
                    "Rp ${rupiah(simpananPokok)}",
                  ),

                  const Divider(),

                  buildInfoRow(
                    "Simpanan Wajib",
                    "Rp ${rupiah(simpananWajib)}",
                  ),

                  const Divider(),

                  buildInfoRow(
                    "Simpanan Sukarela",
                    "Rp ${rupiah(simpananSukarela)}",
                  ),

                ],
              ),
            ),

            const SizedBox(height: 15),

            Container(
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(20),
                border: Border.all(
                  color: jumlahTunggakan > 0
                      ? Colors.orange.shade300
                      : Colors.green.shade300,
                ),
              ),
              child: Column(
                crossAxisAlignment:
                    CrossAxisAlignment.start,
                children: [

                  Row(
                    children: [

                      Icon(
                        jumlahTunggakan > 0
                            ? Icons.warning_amber_rounded
                            : Icons.check_circle,
                        color: jumlahTunggakan > 0
                            ? Colors.orange
                            : Colors.green,
                      ),

                      const SizedBox(width: 10),

                      const Text(
                        "Tagihan Simpanan Wajib",
                        style: TextStyle(
                          fontSize: 17,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),

                  const SizedBox(height: 18),

                  if (jumlahTunggakan > 0) ...[

                    Text(
                      "Belum Dibayar",
                      style: TextStyle(
                        color: Colors.grey.shade700,
                      ),
                    ),

                    const SizedBox(height: 8),

                    Text(
                      "$jumlahTunggakan Bulan",
                      style: const TextStyle(
                        fontSize: 28,
                        fontWeight: FontWeight.bold,
                        color: Colors.red,
                      ),
                    ),

                    const SizedBox(height: 8),

                    Text(
                      "Total Tagihan",
                      style: TextStyle(
                        color: Colors.grey.shade700,
                      ),
                    ),

                    const SizedBox(height: 4),

                    Text(
                      "Rp ${rupiah(totalTunggakan)}",
                      style: const TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                      ),
                    ),

                    const SizedBox(height: 20),

                    SizedBox(
                      width: double.infinity,
                      child: ElevatedButton(

                        onPressed: () {

                          Navigator.push(

                            context,

                            MaterialPageRoute(

                              builder: (_) =>
                                  const SetorSimpananPage(),

                            ),

                          );

                        },

                        child: const Text(
                          "Lihat Tagihan",
                        ),

                      ),
                    ),

                  ] else ...[

                    const Text(

                      "Tidak ada tagihan simpanan wajib.",

                      style: TextStyle(
                        color: Colors.green,
                        fontWeight: FontWeight.w600,
                      ),

                    ),

                  ],

                ],
              ),
            ),

            const SizedBox(height: 35),

            // ======================
            // LAYANAN CEPAT
            // ======================

            const Text(
              'Layanan Cepat',
              style: TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold,
              ),
            ),

            const SizedBox(height: 20),

            GridView.count(
              crossAxisCount: 4,
              shrinkWrap: true,
              physics:
                  const NeverScrollableScrollPhysics(),
              childAspectRatio: 0.75,
              crossAxisSpacing: 12,
              mainAxisSpacing: 20,
              children: [

                GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) =>
                            const SetorSimpananPage(),
                      ),
                    );
                  },
                  child: modernMenuItem(
                    Icons.account_balance_wallet,
                    'Simpan',
                    const Color(0xffFDECEC),
                    DashboardScreen.primaryColor,),
                  ),

                GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) =>
                            const TarikSimpananScreen(),
                      ),
                    );
                  },
                  child: modernMenuItem(
                    Icons.payments,
                    'Tarik',
                    const Color(0xffECEFF8),
                    DashboardScreen.primaryColor,
                  ),
                ),

                GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) =>
                            const BeritaPage(),
                      ),
                    );
                  },
                  child: modernMenuItem(
                    Icons.newspaper,
                    'Berita',
                    const Color(0xffF4F1EE),
                    DashboardScreen.primaryColor,
                  ),
                ),

                GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) =>
                            const PengumumanPage(),
                      ),
                    );
                  },
                  child: modernMenuItem(
                    Icons.campaign,
                    'Pengumuman',
                    const Color(0xffFCECEC),
                    DashboardScreen.primaryColor,
                  ),
                ),
              ],
            ),

            const SizedBox(height: 35),

            // ======================
            // INFORMASI TERBARU
            // ======================

            Row(
              mainAxisAlignment:
                  MainAxisAlignment
                      .spaceBetween,

              children: [

                const Expanded(
                  child: Text(
                    'Informasi Terbaru',
                    style: TextStyle(
                      fontSize: 22,
                      fontWeight:
                          FontWeight
                              .bold,
                    ),

                    overflow:
                        TextOverflow
                            .ellipsis,
                  ),
                ),
              ],
            ),

            const SizedBox(height: 20),

            if (loadingInformasi)
            const Center(
              child: Padding(
                padding: EdgeInsets.all(20),
                child: CircularProgressIndicator(),
              ),
            )
          else if (informasiTerbaru.isEmpty)
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(20),
              alignment: Alignment.center,
              child: const Text(
                "Belum ada informasi terbaru.",
                style: TextStyle(
                  color: Colors.grey,
                ),
              ),
            )
          else
            ListView.separated(
              shrinkWrap: true,
              physics:
                  const NeverScrollableScrollPhysics(),

              itemCount:
                  informasiTerbaru.length,

              separatorBuilder:
                  (_, __) =>
                      const SizedBox(height: 15),

              itemBuilder: (context, index) {

                final item =
                    informasiTerbaru[index];

                final isBerita =
                    item["tipe"] == "berita";

                return modernNewsCard(
                  category:
                      isBerita
                          ? (item["kategori"] ??
                              "Berita")
                          : "Pengumuman",

                  categoryColor:
                      isBerita
                          ? Colors.blue
                          : Colors.red,

                  title:
                      item["judul"] ?? "-",
                  subtitle:
                      item["konten"] ?? "",
                  imageUrl:
                      item["gambar"] ?? "",

                  onTap: () {
                    if (isBerita) {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) =>
                              DetailBeritaScreen(
                            id: item["id"],
                          ),
                        ),
                      );
                    } else {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) =>
                              PengumumanPage(),
                        ),
                      );
                    }
                  },
                );
              },
            ),
          ],
        ),
      ),

      // ======================
      // BOTTOM NAVIGATION
      // ======================

      bottomNavigationBar:
          BottomNavigationBar(
        currentIndex: 0,
        selectedItemColor:DashboardScreen.primaryColor,
        unselectedItemColor:Colors.grey,
        type:
            BottomNavigationBarType
                .fixed,
        onTap: (index) {
          if (index == 0) {
            return;
          } else if (index ==
              1) {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                builder: (_) =>
                    const TransactionHistoryScreen(),
              ),
            );

          } else if (index ==
              2) {

            Navigator.pushReplacement(
              context,

              MaterialPageRoute(
                builder: (_) =>
                    const InfoScreen(),
              ),
            );

          } else if (index ==
              3) {

            Navigator.pushReplacement(
              context,

              MaterialPageRoute(
                builder: (_) =>
                    const ProfileScreen(),
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
            label: 'Profil',
          ),
        ],
      ),
    );
  }

  // ======================
  // MENU ITEM
  // ======================

  Widget modernMenuItem(
    IconData icon,
    String title,
    Color bgColor,
    Color iconColor,
  ) {

    return Column(
      children: [

        Container(
          width: 65,
          height: 65,

          decoration: BoxDecoration(
            color: bgColor,

            borderRadius:
                BorderRadius.circular(
              22,
            ),
          ),

          child: Icon(
            icon,
            size: 30,
            color: iconColor,
          ),
        ),

        const SizedBox(height: 10),

        Text(
          title,

          style: const TextStyle(
            fontSize: 13,
            fontWeight:
                FontWeight.w600,
          ),

          overflow:
              TextOverflow.ellipsis,
        ),
      ],
    );
  }

  // ======================
  // NEWS CARD
  // ======================

  Widget buildInfoRow(
    String title,
    String value,
  ) {
    return Row(
      mainAxisAlignment:
          MainAxisAlignment.spaceBetween,
      children: [

        Text(title),

        Text(
          value,
          style: const TextStyle(
            fontWeight: FontWeight.bold,
          ),
        ),
      ],
    );
  }

  Widget modernNewsCard({
    required String category,
    required Color categoryColor,
    required String title,
    required String subtitle,
    String? imageUrl,
    VoidCallback? onTap,
  }) {

    return Material(
      color: Colors.transparent,
      child: InkWell(
        borderRadius: BorderRadius.circular(24),
        onTap: onTap,
        child: Container(
          padding: const EdgeInsets.all(15),

          decoration: BoxDecoration(
            color: Colors.white,

            borderRadius:
                BorderRadius.circular(
              24,
            ),
          ),

          child: Row(
            children: [
              ClipRRect(
                borderRadius:
                    BorderRadius.circular(16),
                child:
                  imageUrl != null &&
                        imageUrl.isNotEmpty
                    ? Image.network(
                        imageUrl,width: 100,height: 90,fit: BoxFit.cover,
                        errorBuilder:
                            (_, __, ___) {
                          return Image.asset(
                            "assets/images/register.png",
                            width: 100,height: 90,fit: BoxFit.cover,
                          );
                        },
                      )
                    : Image.asset(
                        "assets/images/register.png",
                        width: 100,height: 90,fit: BoxFit.cover,
                      ),
              ),

              const SizedBox(width: 15),

              Expanded(
                child: Column(
                  crossAxisAlignment:
                      CrossAxisAlignment
                          .start,

                  children: [

                    Text(
                      category.toUpperCase(),

                      style: TextStyle(
                        color:
                            categoryColor,

                        fontSize: 11,

                        fontWeight:
                            FontWeight
                                .bold,
                      ),
                    ),

                    const SizedBox(
                      height: 6,
                    ),

                    Text(
                      title,

                      maxLines: 2,

                      overflow:
                          TextOverflow
                              .ellipsis,

                      style:
                          const TextStyle(
                        fontSize: 16,
                        fontWeight:
                            FontWeight
                                .bold,
                      ),
                    ),

                    const SizedBox(
                      height: 6,
                    ),

                    Text(
                      subtitle,

                      maxLines: 2,

                      overflow:
                          TextOverflow
                              .ellipsis,

                      style:
                          const TextStyle(
                        color:
                            Colors.black54,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      )
    );
  }
}