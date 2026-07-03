import 'dart:convert';
import 'package:http/http.dart' as http;
import '../../config/api_config.dart';
import 'package:flutter/material.dart';
import 'show_screen.dart';

class BeritaPage extends StatefulWidget {
  const BeritaPage({super.key});

  static const Color primaryColor = Color(0xffAF101A);

  @override
  State<BeritaPage> createState() => _BeritaPageState();
}

class _BeritaPageState extends State<BeritaPage> {
  String selectedCategory = 'Semua';
  List news = [];
  bool loading = true;
  String searchText = '';

  @override
  void initState() {
    super.initState();

    loadNews();
  }

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

  Future<void> loadNews() async {
    try {

      final response = await http.get(
        Uri.parse(
          "${ApiConfig.baseUrl}/news",
        ),
      );

      debugPrint(
        "STATUS : ${response.statusCode}",
      );

      debugPrint(
        "BODY : ${response.body}",
      );

      if (response.statusCode == 200) {

        final result =
            jsonDecode(response.body);

        setState(() {
          news = result["data"];
          loading = false;
        });

        for (var item in news) {
          debugPrint(
            "ITEM NEWS = $item",
          );
        }

      }

    } catch (e) {

      debugPrint(
        "ERROR NEWS : $e",
      );

      setState(() {
        loading = false;
      });

    }

  }

  final TextEditingController searchController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final filteredNews =
    selectedCategory == "Semua"
      ? news
      : news.where((item) {
          return item["kategori"]
                  .toString()
                  .toLowerCase() ==
              selectedCategory
                  .toLowerCase();
        }).toList();
  
    return Scaffold(
      backgroundColor: const Color(0xffFCF9F8),

      appBar: AppBar(
        backgroundColor: const Color(0xffFCF9F8),
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Color(0xffAF101A)),
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
            padding: const EdgeInsets.fromLTRB(16, 0, 16, 12),
            child: TextField(
              controller: searchController,
              decoration: InputDecoration(
                hintText: 'Cari berita...',
                prefixIcon: const Icon(Icons.search),
                filled: true,
                fillColor: Colors.white,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(14),
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
                  _categoryChip('Berita'),
                  _categoryChip('Edukasi'),
                  _categoryChip('Pengumuman'),
                ],
              ),
            ),

      const SizedBox(height: 20),

      // LIST BERITA
      loading
          ? const Center(child: CircularProgressIndicator())
          : ListView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: filteredNews.length,
              itemBuilder: (context, index) {
                final item = filteredNews[index];
                return Padding(
                  padding: const EdgeInsets.only(bottom: 16),
                  child: _newsCard(
                    context,
                    kategori: item["kategori"]?.toString() ?? "Tidak Ada Kategori",
                    judul: item["judul"] ?? "",
                    deskripsi: item["konten"] ?? "",
                    waktu: formatTanggal(item["created_at"]),
                    image: item["gambar_url"] ?? "",
                    newsData: item,
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }

  Widget _categoryChip(String title) {
    final bool isSelected = selectedCategory == title;

    return Padding(
      padding: const EdgeInsets.only(right: 8),
      child: ChoiceChip(
        label: Text(title),
        selected: isSelected,
        selectedColor: BeritaPage.primaryColor,
        backgroundColor: const Color(0xffEAE7E7),
        labelStyle: TextStyle(
          color: isSelected ? Colors.white : Colors.black54,
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

  Widget _newsCard(
    BuildContext context, {
    required String kategori,
    required String judul,
    required String deskripsi,
    required String waktu,
    required String image,
    required Map newsData,
  }) {
    return InkWell(
      borderRadius: BorderRadius.circular(16),
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (_) =>
          DetailBeritaScreen(
            id: newsData["id"],
          ),),
        );
      },
      child: Container(
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: Colors.white,
          border: Border.all(color: const Color(0xffE4BEBE)),
          borderRadius: BorderRadius.circular(16),
        ),
        child: Row(
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
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
                    style: const TextStyle(fontWeight: FontWeight.w600),
                  ),

                  const SizedBox(height: 6),

                  Text(
                    deskripsi,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(color: Colors.black54, fontSize: 13),
                  ),

                  const SizedBox(height: 8),

                  Row(
                    children: [
                      const Icon(Icons.schedule, size: 14, color: Colors.grey),
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
              borderRadius: BorderRadius.circular(12),
              child: image.isNotEmpty
                ? Image.network(
                    image,
                    width: 90,
                    height: 90,
                    fit: BoxFit.cover,
                  )
                : Container(
                    width: 90,
                    height: 90,
                    color: Colors.grey.shade300,
                    child: const Icon(
                      Icons.article,
                    ),
                  ),
            ),
          ],
        ),
      ),
    );
  }
}
