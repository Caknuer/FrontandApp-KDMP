import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import '../../config/api_config.dart';
import 'show_screen.dart';

class PengumumanPage extends StatefulWidget {
  const PengumumanPage({super.key});

  @override
  State<PengumumanPage> createState() => _PengumumanPageState();
}

class _PengumumanPageState extends State<PengumumanPage> {

  @override
  void initState() {
    super.initState();
    loadAnnouncements();
  }

  Future<void> loadAnnouncements() async {

    try {

      final response =
          await http.get(
        Uri.parse(
          "${ApiConfig.baseUrl}/announcements",
        ),
      );

      if (response.statusCode == 200) {

        final result =
            jsonDecode(response.body);

        setState(() {

          announcements =
              result["data"];

          loading = false;

        });

      }

    } catch (e) {

      debugPrint(e.toString());

      setState(() {
        loading = false;
      });

    }

  }

  final TextEditingController searchController =
      TextEditingController();

  List announcements = [];

  bool loading = true;

  String searchText = '';
  
  String formatTanggal(String date) {
    try {
      final parsed =
          DateTime.parse(date);

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
        'Desember'
      ];

      return
        "${parsed.day} "
        "${bulan[parsed.month]} "
        "${parsed.year}";

    } catch (_) {

      return date;

    }

  }

  @override
  Widget build(BuildContext context) {
    final filteredData =
        announcements.where((item) {

      return item["judul"]
          .toString()
          .toLowerCase()
          .contains(
            searchText.toLowerCase(),
          );

    }).toList();

    return Scaffold(
      backgroundColor: const Color(0xffFCF9F8),

      appBar: AppBar(
        backgroundColor: const Color(0xffFCF9F8),
        elevation: 0,
        title: const Text(
          'Pengumuman',
          style: TextStyle(
            color: Color(0xffAF101A),
            fontWeight: FontWeight.bold,
          ),
        ),
        leading: IconButton(
          icon: const Icon(
            Icons.arrow_back,
            color: Color(0xffAF101A),
          ),
          onPressed: () => Navigator.pop(context),
        ),
      ),

      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(16),
            child: TextField(
              controller: searchController,
              onChanged: (value) {
                setState(() {
                  searchText = value;
                });
              },
              decoration: InputDecoration(
                hintText: 'Cari pengumuman...',
                prefixIcon: const Icon(Icons.search),
                filled: true,
                fillColor: const Color(0xffF6F3F2),
                border: OutlineInputBorder(
                  borderRadius:
                      BorderRadius.circular(14),
                  borderSide: BorderSide.none,
                ),
              ),
            ),
          ),

          Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: 16,
            ),
            child: Row(
              mainAxisAlignment:
                  MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  'Daftar Pengumuman',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                IconButton(
                  icon: const Icon(
                    Icons.filter_list,
                  ),
                  onPressed: () {},
                ),
              ],
            ),
          ),

          Expanded(
            child: loading

                ? const Center(
                    child:
                        CircularProgressIndicator(),
                  )

                : ListView.builder(
              padding:
                  const EdgeInsets.symmetric(
                horizontal: 16,
              ),
              itemCount: filteredData.length,
              itemBuilder: (context, index) {
                final item = filteredData[index];

                return GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) =>
                        DetailPengumumanPage(
                          title: item['judul'] ?? '',
                          content: item['konten'] ?? '',
                          image: item['gambar_url'] ?? '',
                          createdAt: item['created_at'] ?? '',
                        ),
                      ),
                    );
                  },
                  child: Container(
                    margin:
                        const EdgeInsets.only(
                      bottom: 14,
                    ),
                    padding:
                        const EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius:
                          BorderRadius.circular(
                        16,
                      ),
                      border: Border.all(
                        color: Colors.grey
                            .shade300,
                      ),
                    ),
                    child: Row(
                      children: [
                        ClipRRect(
                          borderRadius: BorderRadius.circular(12),
                          child: item['gambar_url'] != null

                              ? Image.network(
                                  item['gambar_url'],
                                  width: 90,
                                  height: 90,
                                  fit: BoxFit.cover,
                                )

                              : Container(
                                  width: 90,
                                  height: 90,
                                  color: Colors.grey.shade200,
                                  child: const Icon(
                                    Icons.campaign,
                                    color: Color(0xffAF101A),
                                    size: 40,
                                  ),
                                ),
                        ),

                        const SizedBox(width: 12),

                        Expanded(
                          child: Column(
                            crossAxisAlignment:
                                CrossAxisAlignment
                                    .start,
                            children: [
                                Container(
                                  padding:
                                      const EdgeInsets
                                          .symmetric(
                                    horizontal: 8,
                                    vertical: 3,
                                  ),
                                  decoration:
                                      BoxDecoration(
                                    color:
                                        Colors.red
                                            .shade100,
                                    borderRadius:
                                        BorderRadius
                                            .circular(
                                      6,
                                    ),
                                  ),
                                  child:
                                      const Text(
                                    'TERSEMAT',
                                    style:
                                        TextStyle(
                                      fontSize:
                                          10,
                                    ),
                                  ),
                                ),

                              const SizedBox(
                                  height: 6),

                              Text(
                                formatTanggal(
                                  item['created_at'],
                                ),
                                style:
                                    TextStyle(
                                  color:
                                      Colors.grey
                                          .shade600,
                                  fontSize: 12,
                                ),
                              ),

                              const SizedBox(
                                  height: 4),

                              Text(
                                item['judul']!,
                                maxLines: 2,
                                overflow:
                                    TextOverflow
                                        .ellipsis,
                                style:
                                    const TextStyle(
                                  fontSize: 16,
                                  fontWeight:
                                      FontWeight
                                          .w600,
                                ),
                              ),

                              const SizedBox(
                                  height: 10),

                              const Row(
                                children: [
                                  Text(
                                    'Selengkapnya',
                                    style:
                                        TextStyle(
                                      color:
                                          Color(
                                        0xffAF101A,
                                      ),
                                      fontWeight:
                                          FontWeight
                                              .bold,
                                    ),
                                  ),
                                  Icon(
                                    Icons
                                        .chevron_right,
                                    color:
                                        Color(
                                      0xffAF101A,
                                    ),
                                    size: 18,
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}

class PengumumanDetailPage
    extends StatelessWidget {
  final String title;
  final String date;
  final String image;
  final String content;

  const PengumumanDetailPage({
    super.key,
    required this.title,
    required this.date,
    required this.image,
    required this.content,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Detail Pengumuman'),
      ),
      body: ListView(
        children: [
          image.isNotEmpty

          ? Image.network(
              image,
              height: 250,
              fit: BoxFit.cover,
            )

          : Container(
              height: 250,
              color: Colors.grey.shade200,
              child: const Center(
                child: Icon(
                  Icons.campaign,
                  size: 80,
                  color: Color(0xffAF101A),
                ),
              ),
            ),

          Padding(
            padding:
                const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment:
                  CrossAxisAlignment.start,
              children: [
                Text(
                  date,
                  style: TextStyle(
                    color:
                        Colors.grey.shade600,
                  ),
                ),

                const SizedBox(height: 10),

                Text(
                  title,
                  style:
                      const TextStyle(
                    fontSize: 24,
                    fontWeight:
                        FontWeight.bold,
                  ),
                ),

                const SizedBox(height: 20),

                Text(
                  content,
                  style: const TextStyle(
                    height: 1.6,
                  ),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}