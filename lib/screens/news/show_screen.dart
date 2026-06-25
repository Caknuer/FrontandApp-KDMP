import 'package:flutter/material.dart';
import 'package:share_plus/share_plus.dart';

class DetailBeritaScreen extends StatelessWidget {
  final Map news;
  const DetailBeritaScreen({
    super.key,
    required this.news,
  });

  String formatTanggal(String date) {
    try {
      final parsed = DateTime.parse(date);

      const bulan = [
        '',
        'Januari',
        'Februari',
        'Maret',
        'April',
        'Mei',
        'Juni',
        'Juli',
        'Agustus',
        'September',
        'Oktober',
        'November',
        'Desember',
      ];

      return "${parsed.day} "
          "${bulan[parsed.month]} "
          "${parsed.year}";
    } catch (_) {
      return date;
    }
  }

  @override
  Widget build(BuildContext context) {
    const primaryColor = Color(0xffAF101A);

    return Scaffold(
      backgroundColor: const Color(0xffFCF9F8),

      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        centerTitle: true,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          color: Colors.black87,
          onPressed: () => Navigator.pop(context),
        ),
        title: const Text(
          'Detail Info',
          style: TextStyle(color: primaryColor, fontWeight: FontWeight.bold),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.share),
            color: Colors.black87,
            onPressed: () async {
              await Share.share(
                "${news["judul"]}\n\n${news["konten"]}",
              );
            },
          ),
        ],
      ),

      body: SingleChildScrollView(
        child: Column(
          children: [
            // HERO IMAGE
            SizedBox(
              height: 240,
              width: double.infinity,
              child: news["gambar_url"] != null &&
              news["gambar_url"].toString().isNotEmpty
                  ? Image.network(
                      news["gambar_url"],
                      fit: BoxFit.cover,
                    )
                  : Container(
                      color: Colors.grey.shade300,
                      child: const Icon(
                        Icons.article,
                        size: 100,
                      ),
                    )
            ),

            Transform.translate(
              offset: const Offset(0, -25),
              child: Container(
                width: double.infinity,
                padding: const EdgeInsets.all(20),
                decoration: const BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.vertical(top: Radius.circular(28)),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // CATEGORY
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 12,
                        vertical: 6,
                      ),
                      decoration: BoxDecoration(
                        color: primaryColor.withAlpha(26),
                        borderRadius: BorderRadius.circular(30),
                      ),
                      child: Text(
                        (news["kategori"] ?? "BERITA")
                            .toString()
                            .toUpperCase(),
                        style: const TextStyle(
                          color: primaryColor,
                          fontWeight: FontWeight.bold,
                          fontSize: 12,
                        ),
                      ),
                    ),

                    const SizedBox(height: 16),

                    Text(
                      news["judul"] ?? "",
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                        height: 1.3,
                      ),
                    ),

                    const SizedBox(height: 20),

                    // AUTHOR
                    Row(
                      children: [
                        const CircleAvatar(
                          radius: 22,
                          backgroundImage: NetworkImage(
                            'https://i.pravatar.cc/150',
                          ),
                        ),

                        const SizedBox(width: 12),

                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              news["penulis"] ?? "Admin",
                              style: TextStyle(fontWeight: FontWeight.w600),
                            ),
                            SizedBox(height: 2),
                            Text(
                              formatTanggal(news["created_at"] ?? ""),
                              style: const TextStyle(
                                color: Colors.grey,
                                fontSize: 12,
                              ),
                            )
                          ],
                        ),
                      ],
                    ),

                    const SizedBox(height: 30),

                    Text(
                      news["konten"] ?? "",
                      style: TextStyle(
                        fontSize: 16,
                        height: 1.8,
                        color: Colors.black87,
                      ),
                    ),

                    const SizedBox(height: 35),

                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
