import 'package:flutter/material.dart';

class HelpScreen extends StatefulWidget {
  const HelpScreen({super.key});

  @override
  State<HelpScreen> createState() => _HelpScreenState();
}

class _HelpScreenState extends State<HelpScreen> {
  final List<Map<String, dynamic>> categories = [
    {
      "title": "Simpanan",
      "icon": Icons.account_balance_wallet,
    },
    {
      "title": "Transaksi",
      "icon": Icons.receipt_long,
    },
    {
      "title": "Akun & Keamanan",
      "icon": Icons.security,
    },
    {
      "title": "Info Koperasi",
      "icon": Icons.info,
    },
  ];

  final List<Map<String, String>> faqs = [
    {
      "question": "Bagaimana cara setor simpanan?",
      "answer":
          "Anda dapat melakukan setoran melalui transfer bank ke rekening virtual account koperasi atau datang langsung ke kantor pusat dengan membawa buku anggota."
    },
    {
      "question": "Lupa kata sandi?",
      "answer":
          "Klik 'Lupa Password' pada halaman login, lalu masukkan nomor HP terdaftar untuk menerima kode OTP verifikasi penggantian kata sandi baru."
    },
    {
      "question": "Berapa lama verifikasi transaksi?",
      "answer":
          "Verifikasi otomatis biasanya memakan waktu 5-10 menit. Untuk setoran manual melalui kantor, verifikasi akan dilakukan dalam 1x24 jam hari kerja."
    },
  ];

  static const primaryColor = Color(0xFFAF101A);

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
          "Pusat Bantuan",
          style: TextStyle(
            color: primaryColor,
            fontWeight: FontWeight.bold,
          ),
        ),
        actions: [
          IconButton(
            icon: const Icon(
              Icons.search,
              color: primaryColor,
            ),
            onPressed: () {},
          ),
        ],
      ),

      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildSearchField(),

            const SizedBox(height: 24),

            const Text(
              "KATEGORI BANTUAN",
              style: TextStyle(
                fontSize: 12,
                color: Color(0xFF5D5F5F),
                fontWeight: FontWeight.w600,
                letterSpacing: 1,
              ),
            ),

            const SizedBox(height: 12),

            GridView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: categories.length,
              gridDelegate:
                  const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                mainAxisSpacing: 12,
                crossAxisSpacing: 12,
                childAspectRatio: 1.15,
              ),
              itemBuilder: (context, index) {
                return _buildCategoryCard(
                  categories[index]["title"],
                  categories[index]["icon"],
                );
              },
            ),

            const SizedBox(height: 32),

            Row(
              mainAxisAlignment:
                  MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  "PERTANYAAN UMUM (FAQ)",
                  style: TextStyle(
                    fontSize: 12,
                    color: Color(0xFF5D5F5F),
                    fontWeight: FontWeight.w600,
                    letterSpacing: 1,
                  ),
                ),
                TextButton(
                  onPressed: () {},
                  child: const Text(
                    "Lihat Semua",
                    style: TextStyle(
                      color: primaryColor,
                    ),
                  ),
                ),
              ],
            ),

            const SizedBox(height: 8),

            ...faqs.map(
              (faq) => Padding(
                padding:
                    const EdgeInsets.only(bottom: 12),
                child: _buildFaqItem(
                  faq["question"]!,
                  faq["answer"]!,
                ),
              ),
            ),

            const SizedBox(height: 24),

            _buildSupportCard(),

            const SizedBox(height: 32),
          ],
        ),
      ),
    );
  }

  Widget _buildSearchField() {
    return TextField(
      decoration: InputDecoration(
        hintText: "Cari bantuan...",
        prefixIcon: const Icon(Icons.search),
        filled: true,
        fillColor: const Color(0xFFF6F3F2),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16),
          borderSide: BorderSide.none,
        ),
      ),
    );
  }

  Widget _buildCategoryCard(
    String title,
    IconData icon,
  ) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: const Color(0xFFE4BEBA),
        ),
      ),
      child: Column(
        crossAxisAlignment:
            CrossAxisAlignment.start,
        mainAxisAlignment:
            MainAxisAlignment.center,
        children: [
          Container(
            width: 52,
            height: 52,
            decoration: BoxDecoration(
              color: primaryColor.withAlpha(26),
              borderRadius:
                  BorderRadius.circular(12),
            ),
            child: const Icon(
              Icons.account_balance_wallet,
              color: primaryColor,
            ),
          ),
          const SizedBox(height: 12),
          Text(
            title,
            style: const TextStyle(
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildFaqItem(
    String question,
    String answer,
  ) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: const Color(0xFFE4BEBA),
        ),
      ),
      child: ExpansionTile(
        title: Text(question),
        childrenPadding:
            const EdgeInsets.fromLTRB(
          16,
          0,
          16,
          16,
        ),
        children: [
          Text(
            answer,
            style: const TextStyle(
              color: Color(0xFF616363),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSupportCard() {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: const Color(0xFFF6F3F2),
        borderRadius: BorderRadius.circular(24),
      ),
      child: Column(
        children: [
          const Text(
            "Butuh Bantuan Lebih Lanjut?",
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.w700,
            ),
          ),

          const SizedBox(height: 8),

          const Text(
            "Tim dukungan kami siap membantu Anda 24/7 melalui berbagai saluran komunikasi.",
            textAlign: TextAlign.center,
            style: TextStyle(
              color: Color(0xFF616363),
            ),
          ),

          const SizedBox(height: 20),

          SizedBox(
            width: double.infinity,
            height: 54,
            child: ElevatedButton.icon(
              style: ElevatedButton.styleFrom(
                backgroundColor: primaryColor,
                foregroundColor: Colors.white,
                shape: RoundedRectangleBorder(
                  borderRadius:
                      BorderRadius.circular(14),
                ),
              ),
              onPressed: () {},
              icon: const Icon(Icons.chat),
              label: const Text(
                "Hubungi Kami via WhatsApp",
              ),
            ),
          ),

          const SizedBox(height: 12),

          SizedBox(
            width: double.infinity,
            height: 54,
            child: OutlinedButton.icon(
              style: OutlinedButton.styleFrom(
                shape: RoundedRectangleBorder(
                  borderRadius:
                      BorderRadius.circular(14),
                ),
              ),
              onPressed: () {},
              icon: const Icon(Icons.call),
              label: const Text(
                "Pusat Panggilan",
              ),
            ),
          ),
        ],
      ),
    );
  }
}