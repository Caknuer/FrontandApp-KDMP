import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class DetailPengumumanPage extends StatelessWidget {

  final String title;
  final String content;
  final String image;
  final String createdAt;

  const DetailPengumumanPage({
    super.key,
    required this.title,
    required this.content,
    required this.image,
    required this.createdAt,
  });

  String formatTanggal() {

    try {

      final date =
          DateTime.parse(createdAt);

      return DateFormat(
        "dd MMMM yyyy",
        "id_ID",
      ).format(date);

    } catch (_) {

      return createdAt;

    }

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xffFCF9F8),

      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            pinned: true,
            backgroundColor: Colors.white,
            elevation: 0,
            leading: IconButton(
              icon: const Icon(
                Icons.arrow_back,
                color: Color(0xffAF101A),
              ),
              onPressed: () => Navigator.pop(context),
            ),
            title: const Text(
              'Detail Pengumuman',
              style: TextStyle(
                color: Color(0xff1B1C1C),
                fontWeight: FontWeight.w600,
              ),
            ),
            centerTitle: true,
            // actions: [
            //   IconButton(
            //     onPressed: () {},
            //     icon: const Icon(
            //       Icons.share,
            //       color: Color(0xffAF101A),
            //     ),
            //   ),
            // ],
            expandedHeight: 250,
            flexibleSpace: FlexibleSpaceBar(
              background: Stack(
                fit: StackFit.expand,
                children: [
                  image.isNotEmpty

                  ? Image.network(
                      image,
                      fit: BoxFit.cover,
                    )

                  : Container(
                      color: Colors.grey.shade300,

                      child: const Center(
                        child: Icon(
                          Icons.campaign,
                          size: 80,
                          color: Color(0xffAF101A),
                        ),
                      ),
                    ),
                  Container(
                    decoration: const BoxDecoration(
                      gradient: LinearGradient(
                        begin: Alignment.bottomCenter,
                        end: Alignment.topCenter,
                        colors: [
                          Color.fromRGBO(0, 0, 0, 0.5),
                          Colors.transparent,
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),

          SliverToBoxAdapter(
            child: Container(
              margin: const EdgeInsets.all(16),
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(20),
                boxShadow: const [
                  BoxShadow(
                    blurRadius: 10,
                    color: Colors.black12,
                  ),
                ],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 12,
                          vertical: 5,
                        ),
                        decoration: BoxDecoration(
                          color: const Color(0xffAF101A),
                          borderRadius:
                              BorderRadius.circular(20),
                        ),
                        child: const Text(
                          'PENGUMUMAN',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 11,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),

                      const SizedBox(width: 12),

                      const Icon(
                        Icons.calendar_today,
                        size: 16,
                        color: Colors.grey,
                      ),

                      const SizedBox(width: 4),

                      Text(
                        formatTanggal(),
                        style: TextStyle(
                          color: Colors.grey,
                        ),
                      ),
                    ],
                  ),

                  const SizedBox(height: 16),

                  Text(
                    title,
                    style: TextStyle(
                      fontSize: 26,
                      fontWeight: FontWeight.bold,
                      height: 1.3,
                    ),
                  ),

                  const SizedBox(height: 24),

                  Text(
                    content,
                    style: const TextStyle(
                      fontSize: 16,
                      height: 1.7,
                      color: Color(0xff5B403D),
                    ),
                  ),

                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton.icon(
                      onPressed: () {
                        // download pdf
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor:
                            const Color(0xffAF101A),
                        foregroundColor: Colors.white,
                        padding:
                            const EdgeInsets.symmetric(
                          vertical: 16,
                        ),
                        shape: RoundedRectangleBorder(
                          borderRadius:
                              BorderRadius.circular(14),
                        ),
                      ),
                      icon: const Icon(
                        Icons.picture_as_pdf,
                      ),
                      label: const Text(
                        'Unduh Lampiran PDF',
                      ),
                    ),
                  ),

                  const SizedBox(height: 12),

                  const Text(
                    'Ukuran file: 2.4 MB (PDF)\nPastikan koneksi internet stabil.',
                    style: TextStyle(
                      color: Colors.grey,
                      fontSize: 13,
                    ),
                  ),
                ],
              ),
            ),
          ),

          SliverToBoxAdapter(
            child: Container(
              margin: const EdgeInsets.symmetric(
                horizontal: 16,
              ),
              padding: const EdgeInsets.all(18),
              decoration: BoxDecoration(
                color: const Color(0xffEAE7E7),
                borderRadius: BorderRadius.circular(16),
              ),
              child: Column(
                crossAxisAlignment:
                    CrossAxisAlignment.start,
                children: const [
                  Text(
                    'Catatan Tambahan',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),

                  SizedBox(height: 16),

                  Row(
                    crossAxisAlignment:
                        CrossAxisAlignment.start,
                    children: [
                      Text(
                        '• ',
                        style: TextStyle(
                          color: Color(0xffAF101A),
                          fontSize: 18,
                        ),
                      ),
                      Expanded(
                        child: Text(
                          'Bagi anggota yang belum melakukan pembaharuan data KTP, harap menghubungi bagian administrasi sebelum tanggal 30 Oktober.',
                        ),
                      ),
                    ],
                  ),

                  SizedBox(height: 10),

                  Row(
                    crossAxisAlignment:
                        CrossAxisAlignment.start,
                    children: [
                      Text(
                        '• ',
                        style: TextStyle(
                          color: Color(0xffAF101A),
                          fontSize: 18,
                        ),
                      ),
                      Expanded(
                        child: Text(
                          'Pengambilan tunai hanya dapat diwakilkan dengan surat kuasa bermaterai dan KTP asli pemberi kuasa.',
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),

          const SliverToBoxAdapter(
            child: SizedBox(height: 100),
          ),
        ],
      ),
    );
  }
}