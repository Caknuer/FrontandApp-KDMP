import 'package:flutter/material.dart';

class TermsScreen extends StatefulWidget {
  const TermsScreen({super.key});

  @override
  State<TermsScreen> createState() => _TermsScreenState();
}

class _TermsScreenState extends State<TermsScreen> {
  final ScrollController _scrollController = ScrollController();
  bool showConsentBar = false;

  @override
  void initState() {
    super.initState();

    _scrollController.addListener(() {
      if (_scrollController.offset > 200 && !showConsentBar) {
        setState(() {
          showConsentBar = true;
        });
      }
    });
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  Widget sectionTitle(String title) {
    return Row(
      children: [
        Container(
          width: 6,
          height: 32,
          decoration: BoxDecoration(
            color: const Color(0xFFAF101A),
            borderRadius: BorderRadius.circular(99),
          ),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: Text(
            title,
            style: const TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
      ],
    );
  }

  Widget infoCard({
    required IconData icon,
    required String title,
    required String description,
  }) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: const Color(0xFFF6F3F2),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: const Color(0xFFE4BEBA)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(icon, color: const Color(0xFFAF101A)),
          const SizedBox(height: 8),
          Text(
            title,
            style: const TextStyle(
              fontWeight: FontWeight.w600,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            description,
            style: const TextStyle(
              color: Colors.black54,
              fontSize: 13,
            ),
          ),
        ],
      ),
    );
  }

  Widget chip(String label) {
    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: 12,
        vertical: 6,
      ),
      decoration: BoxDecoration(
        color: const Color(0xFFDfe0E0),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Text(
        label,
        style: const TextStyle(
          fontSize: 12,
          fontWeight: FontWeight.w500,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFFCF9F8),

      appBar: AppBar(
        elevation: 0,
        backgroundColor: const Color(0xFFFCF9F8),
        leading: IconButton(
          icon: const Icon(
            Icons.arrow_back,
            color: Color(0xFFAF101A),
          ),
          onPressed: () => Navigator.pop(context),
        ),
        title: const Text(
          'Syarat & Ketentuan',
          style: TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),

      body: Stack(
        children: [
          SingleChildScrollView(
            controller: _scrollController,
            padding: const EdgeInsets.fromLTRB(16, 8, 16, 120),
            child: Column(
              children: [
                // Hero
                Container(
                  height: 220,
                  clipBehavior: Clip.antiAlias,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(16),
                  ),
                  child: Stack(
                    fit: StackFit.expand,
                    children: [
                      Image.network(
                        "https://lh3.googleusercontent.com/aida-public/AB6AXuA3FgiAhzh_ZII51A_2w1cwFNfHJdSCVLiWcMVvHgpfIP4MkTSsoe6UOQAwDKUWE2TdG6Ix1E0iwAWUkG-hHRm9vWcUv9wTa7A5TEyjxIsG0XOhNp7nuDo7snIfiG_mVSNvsEc9y_dqWZaT_-dWWSKewtzz_C5quPZrJ1hFD_1E20jlUZS2-TClj3GFx5Z0lfFuaKxRKoaQUm-myw-hiZWmVLobp84-qvRg0JAV0ZgrK06Jg5ptjCXRFGI_Uy1oPzlfmVWBrY8dHZIX",
                        fit: BoxFit.cover,
                      ),
                      Container(
                        decoration: BoxDecoration(
                          gradient: LinearGradient(
                            begin: Alignment.topCenter,
                            end: Alignment.bottomCenter,
                            colors: [
                              Colors.transparent,
                              Colors.black.withAlpha(166),
                            ],
                          ),
                        ),
                      ),
                      const Positioned(
                        left: 16,
                        right: 16,
                        bottom: 16,
                        child: Text(
                          'Panduan Keanggotaan & Layanan',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 24,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),

                const SizedBox(height: 24),

                Container(
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(16),
                    border: Border.all(
                      color: const Color(0xFFE4BEBA),
                    ),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Section 1
                      sectionTitle("1. Ketentuan Umum"),
                      const SizedBox(height: 12),
                      const Text(
                        "Aplikasi Koperasi Desa merupakan platform digital yang dikelola untuk mempermudah transaksi dan transparansi tata kelola desa.",
                        style: TextStyle(height: 1.6),
                      ),
                      const SizedBox(height: 12),

                      const Text("• Layanan tersedia bagi warga desa."),
                      const Text("• Sistem berjalan 24/7."),
                      const Text(
                          "• Penyalahgunaan akun akan ditindak sesuai hukum."),

                      const SizedBox(height: 28),

                      // Section 2
                      sectionTitle("2. Keanggotaan"),
                      const SizedBox(height: 16),

                      GridView.count(
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        crossAxisCount: 2,
                        mainAxisSpacing: 12,
                        crossAxisSpacing: 12,
                        childAspectRatio: 1.1,
                        children: [
                          infoCard(
                            icon: Icons.badge_outlined,
                            title: "Syarat Daftar",
                            description:
                                "Warga dengan KTP sah dan menyetujui AD/ART koperasi.",
                          ),
                          infoCard(
                            icon: Icons.verified_user_outlined,
                            title: "Status Aktif",
                            description:
                                "Memenuhi simpanan wajib setiap bulan.",
                          ),
                        ],
                      ),

                      const SizedBox(height: 28),

                      // Section 3
                      sectionTitle("3. Hak dan Kewajiban"),
                      const SizedBox(height: 16),

                      ListTile(
                        contentPadding: EdgeInsets.zero,
                        leading: CircleAvatar(
                          backgroundColor: const Color(0xFFFFDAD6),
                          child: Icon(
                            Icons.check,
                            color: const Color(0xFFAF101A),
                          ),
                        ),
                        title: const Text("Hak Anggota"),
                        subtitle: const Text(
                          "Menerima SHU, memberikan suara pada RAT, dan memperoleh laporan keuangan.",
                        ),
                      ),

                      ListTile(
                        contentPadding: EdgeInsets.zero,
                        leading: const CircleAvatar(
                          backgroundColor: Color(0xFFEAE7E7),
                          child: Icon(Icons.gavel),
                        ),
                        title: const Text("Kewajiban Anggota"),
                        subtitle: const Text(
                          "Mematuhi AD/ART dan berpartisipasi aktif dalam pengembangan koperasi.",
                        ),
                      ),

                      const SizedBox(height: 28),

                      // Section 4
                      sectionTitle("4. Penarikan dan Simpanan"),
                      const SizedBox(height: 16),

                      Container(
                        padding: const EdgeInsets.all(16),
                        decoration: BoxDecoration(
                          color: const Color(0xFFAF101A).withAlpha(13),
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: const Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                Icon(
                                  Icons.info_outline,
                                  color: Color(0xFFAF101A),
                                ),
                                SizedBox(width: 8),
                                Text(
                                  "Ketentuan Finansial",
                                  style: TextStyle(
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(height: 12),
                            Text(
                                "• Simpanan Pokok tidak dapat ditarik selama menjadi anggota."),
                            Text(
                                "• Simpanan Sukarela maksimal Rp5.000.000 per hari."),
                            Text(
                                "• Penarikan di atas limit memerlukan verifikasi admin."),
                          ],
                        ),
                      ),

                      const SizedBox(height: 28),

                      // Section 5
                      sectionTitle("5. Kebijakan Privasi"),
                      const SizedBox(height: 12),

                      const Text(
                        "Data pribadi digunakan untuk verifikasi identitas dan peningkatan layanan Koperasi Desa.",
                        style: TextStyle(height: 1.6),
                      ),

                      const SizedBox(height: 16),

                      Wrap(
                        spacing: 8,
                        runSpacing: 8,
                        children: [
                          chip("Enkripsi End-to-End"),
                          chip("Tanpa Pihak Ketiga"),
                          chip("GDPR Compliance"),
                        ],
                      ),

                      const SizedBox(height: 24),

                      const Divider(),

                      const SizedBox(height: 12),

                      const Center(
                        child: Text(
                          "Terakhir diperbarui: 24 Mei 2024",
                          style: TextStyle(
                            color: Colors.black54,
                            fontStyle: FontStyle.italic,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),

          // Consent Bar
          AnimatedPositioned(
            duration: const Duration(milliseconds: 300),
            left: 16,
            right: 16,
            bottom: showConsentBar ? 90 : -200,
            child: Material(
              elevation: 8,
              borderRadius: BorderRadius.circular(20),
              child: Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Column(
                  children: [
                    const Text(
                      "Apakah Anda menyetujui seluruh Syarat & Ketentuan di atas?",
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: 12),
                    Row(
                      children: [
                        Expanded(
                          child: OutlinedButton(
                            onPressed: () {
                              setState(() {
                                showConsentBar = false;
                              });
                            },
                            child: const Text("Tutup"),
                          ),
                        ),
                        const SizedBox(width: 12),
                        Expanded(
                          child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              backgroundColor:
                                  const Color(0xFFAF101A),
                            ),
                            onPressed: () {
                              setState(() {
                                showConsentBar = false;
                              });
                            },
                            child: const Text("Saya Setuju"),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),

      bottomNavigationBar: BottomNavigationBar(
        currentIndex: 3,
        type: BottomNavigationBarType.fixed,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home_outlined),
            label: "Beranda",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.account_balance_wallet_outlined),
            label: "Simpanan",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.payments_outlined),
            label: "Pinjaman",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: "Akun",
          ),
        ],
      ),
    );
  }
}