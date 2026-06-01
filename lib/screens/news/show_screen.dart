import 'package:flutter/material.dart';

class DetailBeritaPage extends StatelessWidget {
  const DetailBeritaPage({super.key});

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
          style: TextStyle(
            color: primaryColor,
            fontWeight: FontWeight.bold,
          ),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.share),
            color: Colors.black87,
            onPressed: () {},
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
              child: Image.network(
                'https://images.unsplash.com/photo-1526304640581-d334cdbbf45e',
                fit: BoxFit.cover,
              ),
            ),

            Transform.translate(
              offset: const Offset(0, -25),
              child: Container(
                width: double.infinity,
                padding: const EdgeInsets.all(20),
                decoration: const BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.vertical(
                    top: Radius.circular(28),
                  ),
                ),
                child: Column(
                  crossAxisAlignment:
                      CrossAxisAlignment.start,
                  children: [
                    // CATEGORY
                    Container(
                      padding:
                          const EdgeInsets.symmetric(
                        horizontal: 12,
                        vertical: 6,
                      ),
                      decoration: BoxDecoration(
                        color:
                            primaryColor.withAlpha(
                          26,
                        ),
                        borderRadius:
                            BorderRadius.circular(
                          30,
                        ),
                      ),
                      child: const Text(
                        'EDUKASI',
                        style: TextStyle(
                          color: primaryColor,
                          fontWeight:
                              FontWeight.bold,
                          fontSize: 12,
                        ),
                      ),
                    ),

                    const SizedBox(height: 16),

                    const Text(
                      'Tips Mengelola Simpanan Sukarela dengan Bijak di Koperasi Desa',
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight:
                            FontWeight.bold,
                        height: 1.3,
                      ),
                    ),

                    const SizedBox(height: 20),

                    // AUTHOR
                    Row(
                      children: [
                        const CircleAvatar(
                          radius: 22,
                          backgroundImage:
                              NetworkImage(
                            'https://i.pravatar.cc/150',
                          ),
                        ),

                        const SizedBox(width: 12),

                        Column(
                          crossAxisAlignment:
                              CrossAxisAlignment
                                  .start,
                          children: const [
                            Text(
                              'Oleh Admin',
                              style: TextStyle(
                                fontWeight:
                                    FontWeight
                                        .w600,
                              ),
                            ),
                            SizedBox(height: 2),
                            Text(
                              '24 Okt 2023 • 5 min baca',
                              style: TextStyle(
                                color:
                                    Colors.grey,
                                fontSize: 12,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),

                    const SizedBox(height: 30),

                    const Text(
                      'Simpanan sukarela di koperasi seringkali menjadi instrumen keuangan yang kurang dimanfaatkan secara optimal oleh anggota. Padahal, dengan fleksibilitas penyetoran dan penarikan yang ditawarkan, produk ini bisa menjadi pilar penting dalam ketahanan finansial keluarga.',
                      style: TextStyle(
                        fontSize: 16,
                        height: 1.8,
                        color: Colors.black87,
                      ),
                    ),

                    const SizedBox(height: 20),

                    const Text(
                      'Langkah pertama dalam mengelola simpanan ini adalah dengan menentukan tujuan yang spesifik. Apakah untuk dana darurat, biaya pendidikan anak, atau modal usaha di musim depan. Tanpa tujuan yang jelas, simpanan sukarela cenderung akan terpakai untuk kebutuhan jangka pendek.',
                      style: TextStyle(
                        fontSize: 16,
                        height: 1.8,
                        color: Colors.black87,
                      ),
                    ),

                    const SizedBox(height: 24),

                    // QUOTE
                    Container(
                      padding:
                          const EdgeInsets.all(
                        18,
                      ),
                      decoration: BoxDecoration(
                        color:
                            primaryColor.withAlpha(26),
                        border: Border(
                          left: BorderSide(
                            color: primaryColor,
                            width: 4,
                          ),
                        ),
                        borderRadius:
                            BorderRadius.circular(
                          16,
                        ),
                      ),
                      child: const Text(
                        '"Keberhasilan finansial di koperasi bukan tentang seberapa besar nominal yang Anda simpan, melainkan tentang konsistensi dan disiplin dalam memisahkan dana masa depan dari kebutuhan saat ini."',
                        style: TextStyle(
                          fontSize: 16,
                          fontStyle:
                              FontStyle.italic,
                          height: 1.7,
                        ),
                      ),
                    ),

                    const SizedBox(height: 24),

                    const Text(
                      'Koperasi Desa menawarkan bagi hasil yang kompetitif dibandingkan tabungan biasa. Dengan memanfaatkan sistem setoran rutin, anggota dapat membangun aset secara bertahap tanpa terasa membebani pengeluaran harian.',
                      style: TextStyle(
                        fontSize: 16,
                        height: 1.8,
                      ),
                    ),

                    const SizedBox(height: 24),

                    const Text(
                      'Strategi Penempatan Dana',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight:
                            FontWeight.bold,
                      ),
                    ),

                    const SizedBox(height: 12),

                    const Text(
                      'Idealnya, alokasikan minimal 10% dari pendapatan bulanan ke dalam simpanan sukarela. Saat membutuhkan dana mendesak, proses penarikan jauh lebih cepat dibandingkan mengajukan pinjaman baru.',
                      style: TextStyle(
                        fontSize: 16,
                        height: 1.8,
                      ),
                    ),

                    const SizedBox(height: 35),

                    Row(
                      mainAxisAlignment:
                          MainAxisAlignment
                              .spaceBetween,
                      children: [
                        const Text(
                          'Artikel Terkait',
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight:
                                FontWeight.bold,
                          ),
                        ),
                        TextButton(
                          onPressed: () {},
                          child: const Text(
                            'Lihat Semua',
                          ),
                        ),
                      ],
                    ),

                    const SizedBox(height: 15),

                    _relatedItem(
                      category: 'Kegiatan',
                      title:
                          'Laporan Rapat Anggota Tahunan Koperasi Desa 2023',
                      date: '15 Okt 2023',
                    ),

                    const SizedBox(height: 12),

                    _relatedItem(
                      category: 'Edukasi',
                      title:
                          'Panduan Lengkap Mengajukan Pinjaman KUR di Koperasi',
                      date: '10 Okt 2023',
                    ),

                    const SizedBox(height: 30),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  static Widget _relatedItem({
    required String category,
    required String title,
    required String date,
  }) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius:
            BorderRadius.circular(16),
        border: Border.all(
          color: Colors.grey.shade200,
        ),
      ),
      child: Row(
        children: [
          ClipRRect(
            borderRadius:
                BorderRadius.circular(12),
            child: Image.network(
              'https://images.unsplash.com/photo-1506744038136-46273834b3fb',
              width: 90,
              height: 90,
              fit: BoxFit.cover,
            ),
          ),

          const SizedBox(width: 12),

          Expanded(
            child: Column(
              crossAxisAlignment:
                  CrossAxisAlignment.start,
              children: [
                Text(
                  category.toUpperCase(),
                  style: const TextStyle(
                    color: Color(0xffAF101A),
                    fontWeight:
                        FontWeight.bold,
                    fontSize: 11,
                  ),
                ),

                const SizedBox(height: 6),

                Text(
                  title,
                  maxLines: 2,
                  overflow:
                      TextOverflow.ellipsis,
                  style: const TextStyle(
                    fontWeight:
                        FontWeight.w600,
                  ),
                ),

                const SizedBox(height: 8),

                Text(
                  date,
                  style: const TextStyle(
                    fontSize: 11,
                    color: Colors.grey,
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