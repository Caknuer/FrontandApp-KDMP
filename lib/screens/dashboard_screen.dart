import 'package:flutter/material.dart';
import 'riwayat_screen.dart';
import 'info_screen.dart';
import 'page-profil/profile_screen.dart';
import 'simpanan_screen.dart';
import 'news/index_screen.dart';
import 'pengumuman/index_screen.dart';
import 'tarik_screen.dart';
import 'notifikasi_screen.dart';

class DashboardScreen extends StatelessWidget {
  const DashboardScreen({super.key});

  static const Color primaryColor =
      Color(0xffAF101A);

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

            Icon(
              Icons.account_balance,
              color: primaryColor,
            ),

            SizedBox(width: 10),

            Text(
              'Koperasi Desa',
              style: TextStyle(
                color: primaryColor,
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

              Positioned(
                top: 14,
                right: 14,

                child: Container(
                  width: 10,
                  height: 10,

                  decoration:
                      const BoxDecoration(
                    color: primaryColor,
                    shape: BoxShape.circle,
                  ),
                ),
              ),
            ],
          ),

          Padding(
            padding:
                const EdgeInsets.only(
              right: 15,
            ),

            child: CircleAvatar(
              backgroundImage:
                  const AssetImage(
                'assets/images/logo.png',
              ),

              radius: 20,
            ),
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

            const Text(
              'Halo, Ahmad',
              style: TextStyle(
                fontSize: 30,
                fontWeight:
                    FontWeight.bold,
              ),
            ),

            const SizedBox(height: 5),

            const Text(
              'Selamat pagi, kelola tabunganmu dengan mudah.',
              style: TextStyle(
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
                    BorderRadius.circular(
                  30,
                ),

                gradient:
                    const LinearGradient(
                  colors: [
                    Color(0xffAF101A),
                    Color(0xff8B0D15),
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

                        children: const [

                          Text(
                            'Total Saldo Simpanan',
                            style: TextStyle(
                              color:
                                  Colors
                                      .white70,
                            ),
                          ),

                          Icon(
                            Icons
                                .visibility_outlined,
                            color:
                                Colors
                                    .white70,
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

                        children: const [

                          Padding(
                            padding:
                                EdgeInsets.only(
                              bottom: 6,
                            ),

                            child: Text(
                              'Rp',
                              style:
                                  TextStyle(
                                color: Colors
                                    .white70,

                                fontSize:
                                    20,
                              ),
                            ),
                          ),

                          SizedBox(width: 8),

                          Text(
                            '12.450.000',
                            style:
                                TextStyle(
                              color:
                                  Colors
                                      .white,

                              fontSize:
                                  34,

                              fontWeight:
                                  FontWeight
                                      .bold,
                            ),
                          ),
                        ],
                      ),

                      const SizedBox(
                        height: 25,
                      ),
                    ],
                  ),
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
                    primaryColor,
                  ),
                ),

                GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) =>
                            const TarikPage(),
                      ),
                    );
                  },
                  child: modernMenuItem(
                    Icons.payments,
                    'Tarik',
                    const Color(0xffECEFF8),
                    Colors.blueGrey,
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
                    Colors.brown,
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
                    Colors.red,
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

                TextButton(
                  onPressed: () {},

                  child: const Text(
                    'Lihat Semua',
                    style: TextStyle(
                      color:
                          primaryColor,
                    ),
                  ),
                ),
              ],
            ),

            const SizedBox(height: 20),

            modernNewsCard(
              category: 'Acara',
              categoryColor:
                  primaryColor,

              title:
                  'Rapat Tahunan Anggota 2024',

              subtitle:
                  'Bahasan strategis perkembangan koperasi tahun ini.',

              image:
                  'assets/images/register.png',
            ),

            const SizedBox(height: 15),

            modernNewsCard(
              category: 'Program',
              categoryColor:
                  Colors.blueGrey,

              title:
                  'Pinjaman Modal Usaha',

              subtitle:
                  'Bunga spesial 0.5% untuk UMKM aktif desa.',

              image:
                  'assets/images/register.png',
            ),

            const SizedBox(height: 120),
          ],
        ),
      ),

      // ======================
      // BOTTOM NAVIGATION
      // ======================

      bottomNavigationBar:
          BottomNavigationBar(
        currentIndex: 0,

        selectedItemColor:
            primaryColor,

        unselectedItemColor:
            Colors.grey,

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

  Widget modernNewsCard({
    required String category,
    required Color categoryColor,
    required String title,
    required String subtitle,
    required String image,
  }) {

    return Container(
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
                BorderRadius.circular(
              18,
            ),

            child: Image.asset(
              image,

              width: 85,
              height: 85,

              fit: BoxFit.cover,
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
    );
  }
}