import 'package:flutter/material.dart';
import 'show_screen.dart';

class BeritaPage extends StatefulWidget {
  const BeritaPage({super.key});

  static const Color primaryColor =Color(0xffAF101A);

  @override
  State<BeritaPage> createState() => _BeritaPageState();
}

class _BeritaPageState extends State<BeritaPage> {
  String selectedCategory = 'Semua';

  final TextEditingController searchController =
      TextEditingController();
      
  @override    
  Widget build(BuildContext context) {
    
    return Scaffold(
      backgroundColor: const Color(0xffFCF9F8),

      appBar: AppBar(
        backgroundColor: const Color(0xffFCF9F8),
        elevation: 0,
        leading: IconButton(
          icon: const Icon(
            Icons.arrow_back,
            color: Color(0xffAF101A),
          ),
          onPressed: () => Navigator.pop(context),
        ),
        title: const Text(
          'Berita',
          style: TextStyle(
            color: BeritaPage.primaryColor,
            fontWeight: FontWeight.bold,
          ),
        ),
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(70),
          child: Padding(
            padding: const EdgeInsets.fromLTRB(
              16,
              0,
              16,
              12,
            ),
            child: TextField(
              controller: searchController,
              decoration: InputDecoration(
                hintText: 'Cari berita...',
                prefixIcon: const Icon(Icons.search),
                filled: true,
                fillColor: Colors.white,
                border: OutlineInputBorder(
                  borderRadius:
                      BorderRadius.circular(14),
                  borderSide: BorderSide.none,
                ),
              ),
            ),
          ),
        ),
      ),

      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            // KATEGORI
            SizedBox(
              height: 42,
              child: ListView(
                scrollDirection: Axis.horizontal,
                children: [
                  _categoryChip('Semua'),
                  _categoryChip('Kegiatan'),
                  _categoryChip('Edukasi'),
                  _categoryChip('Pengumuman'),
                ],
              ),
            ),

            const SizedBox(height: 20),

            // LIST BERITA
            _newsCard(context,
              kategori: 'Edukasi',
              judul:
                  'Tips Mengelola Simpanan Sukarela dengan Bijak',
              deskripsi:
                  'Pelajari cara mengalokasikan dana cadangan koperasi untuk keperluan darurat keluarga...',
              waktu: '2 jam yang lalu',
              image:
                  'https://lh3.googleusercontent.com/aida-public/AB6AXuBeQ5soJxEMFQ4g4R2wYpn1mzTYqkw0bcAQaqWoihrWTEwnJcPRp8VJ-3fL-DfS_CdJW-uMGfp5iwTVaJ4X6QXUakDtKqLmojnrevCjVnbO0cd9aaeACIPosO9PXOiA0Bp7HvTyxTfTbS6SBQXapXFkZcoVyDCketsDNrs4iD15OW3WsSCzhcI0GE96t6I5irWEF23fUw4M2TGalajgUZFa8xanxF3Yl_3b8ONEq5qNUj1vDQNX2swq3tR7Cvx3UD3Fo1HTjKaWorHZ',
            ),

            const SizedBox(height: 16),

            _newsCard(context,
              kategori: 'Kegiatan',
              judul:
                  'Penyaluran Modal Usaha Tahap II bagi UMKM',
              deskripsi:
                  'Koperasi Desa telah menyalurkan dana bantuan modal kepada 20 pedagang lokal di pasar utama...',
              waktu: 'Kemarin',
              image:
                  'https://lh3.googleusercontent.com/aida-public/AB6AXuCP70P_k4gGlVuXP2N7q9KJB6-T5y8AwjOknpEyPXkfCBXlxBcIMhVBcKovDwguYKknw2bGDw7ZAK9S1LazhXN_VHS9-z-g2JL3XDB-YH0DBSr1TmuaLaqen1F4HVmuYYkSB8z30QibmqLvaiV3H3pcFBBgiJ10vqLftB5kOX-9r1EM-yfxr4ICzAYPU-jAHs3oozhKX8qKSsbC2-l0spRVG7tKCY2o-tDG0xGO3Ed14v6ct16tU3wnsaAryKgxMVqlFCu0a5R06c8V',
            ),

            const SizedBox(height: 16),

            _newsCard(
              context,
              kategori: 'Pengumuman',
              judul:
                  'Jadwal Libur Operasional Kantor Koperasi',
              deskripsi:
                  'Sehubungan dengan libur nasional, layanan tatap muka akan ditutup sementara...',
              waktu: '3 hari yang lalu',
              image:
                  'https://lh3.googleusercontent.com/aida-public/AB6AXuDz7AulAEzPpZdBojJcEMcbXrpT2V09RwU_6dtK3KLTANBQi5asRPFfkVTUXh1rTJoSF55f6AvdwoQ01cjpOWWGIPLza6hIb_5MQP_5p0eNOntAWAO-0mofIMy25_VrR0QGDeOc0vmECKVNB1qyeGq_hqauDGnJmcdEq3Ew4qDfqG1ITDqZKgj-xoKtt0lN5-6AiKCUTUENf16N9s22PHStZfi47fDhlFlyufNF7TAQwg9_RzKC9cl0JhcwcPIyBwyMyfK5uMgaOzRb',
            ),
          ],
        ),
      ),
    );
  }

  Widget _categoryChip(String title) {
    final bool isSelected =
        selectedCategory == title;

    return Padding(
      padding: const EdgeInsets.only(right: 8),
      child: ChoiceChip(
        label: Text(title),
        selected: isSelected,
        selectedColor:
            BeritaPage.primaryColor,
        backgroundColor:
            const Color(0xffEAE7E7),
        labelStyle: TextStyle(
          color: isSelected
              ? Colors.white
              : Colors.black54,
          fontWeight: FontWeight.w600,
        ),
        onSelected: (value) {
          setState(() {
            selectedCategory = title;
          });
        },
      ),
    );
  }

  Widget _newsCard(BuildContext context,{
    required String kategori,
    required String judul,
    required String deskripsi,
    required String waktu,
    required String image,
  }) {
    return InkWell(
      borderRadius: BorderRadius.circular(16),
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) =>
                const DetailBeritaScreen(),
          ),
        );
      },
      child: Container(
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: Colors.white,
          border: Border.all(
            color: const Color(0xffE4BEBE),
          ),
          borderRadius: BorderRadius.circular(16),
        ),
        child: Row(
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment:
                    CrossAxisAlignment.start,
                children: [
                  Text(
                    kategori,
                    style: const TextStyle(
                      color: Color(0xffAF101A),
                      fontWeight: FontWeight.bold,
                      fontSize: 12,
                    ),
                  ),

                  const SizedBox(height: 6),

                  Text(
                    judul,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(
                      fontWeight: FontWeight.w600,
                    ),
                  ),

                  const SizedBox(height: 6),

                  Text(
                    deskripsi,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(
                      color: Colors.black54,
                      fontSize: 13,
                    ),
                  ),

                  const SizedBox(height: 8),

                  Row(
                    children: [
                      const Icon(
                        Icons.schedule,
                        size: 14,
                        color: Colors.grey,
                      ),
                      const SizedBox(width: 4),
                      Text(
                        waktu,
                        style: const TextStyle(
                          color: Colors.grey,
                          fontSize: 12,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),

            const SizedBox(width: 12),

            ClipRRect(
              borderRadius:
                  BorderRadius.circular(12),
              child: Image.network(
                image,
                width: 90,
                height: 90,
                fit: BoxFit.cover,
              ),
            ),
          ],
        ),
      ),
    );
  }
}