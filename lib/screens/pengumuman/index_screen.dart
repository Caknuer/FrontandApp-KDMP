import 'package:flutter/material.dart';

class PengumumanPage extends StatefulWidget {
  const PengumumanPage({super.key});

  @override
  State<PengumumanPage> createState() => _PengumumanPageState();
}

class _PengumumanPageState extends State<PengumumanPage> {
  final TextEditingController searchController =
      TextEditingController();

  final List<Map<String, String>> announcements = [
    {
      "title":
          "Pembagian Sisa Hasil Usaha (SHU) Tahun Buku 2023",
      "date": "25 Okt 2023",
      "image":
          "https://lh3.googleusercontent.com/aida-public/AB6AXuD7IhVBWytaHqI2UtPt4LfGiGwUC5uJrQ6sivV8deJUYlKfBzcEcypddA6JNpntz7P53zhlswOd0OjyZWgBtSsrO90SMzTFr48htC9eS-EcGGdmp5S2fxdOL7Zby2S-ACQRxCEX5zdk8I02LFt2ErakRRXni1N709oQxoEgx6rx8qS3rSCki4R_-x1k_mnx-LqysiPX3gORS3an7gjdlKYmxLjGoyhWfUeIEBOx1YP8scUZxGsUK-DNgSvOQlNefCC_dy6SPS08uIpU",
      "pinned": "true",
    },
    {
      "title": "Perubahan Jam Operasional Kantor",
      "date": "22 Okt 2023",
      "image":
          "https://lh3.googleusercontent.com/aida-public/AB6AXuBDuwFJaO-UbYKWFqDKGFuJV7GgqRWyMBrJ3mpwcaL9JDEmybKkdBsr1sUjApdTjFInPoof3-WX1KvCVaTlXbhlVRQZ56NchiE_W2RfRpZfHQLN0hFDZNv2cBkhINvria0_N9bNf5snQXRB6exHa38lNCM4yt5ZuJ0hcBjlwMu8Pk1Sc5Z0XOgWsl29M1gDf0CnYqGG5pxAErZd4ygWm4t4mAVsEd71GivNcybwR6COVo-IgRPbqtScSmJnywzH8ebYF6Lg73GWk6QY",
    },
    {
      "title":
          "Sosialisasi Program Pinjaman Modal Mikro",
      "date": "20 Okt 2023",
      "image":
          "https://lh3.googleusercontent.com/aida-public/AB6AXuBkAnUEGck-Wosy8XWfhwDpNGAxyvkUy8SD-rZXRO3gLEu4SSBopx91eqeyfaTgUco2j-5xXMgJalAesEm2wqCEMcOS7sS6laQFb2xGCp7ucA-1u_G4iniXm8ukkCAlH_HNaXitFOhopOy6mazuLKMhYKhVruAKTgMe8mCehiEU_X2nlP19q8ZsMvpewaZFDbuVu410QkYANVFOyh7NqZXP1EycjS-rqcytJxmultXaepzx8pepGgqt7mH91wNDDyjlgsilS_52QuJC",
    },
    {
      "title":
          "Laporan Keuangan Triwulan III Selesai",
      "date": "18 Okt 2023",
      "image":
          "https://lh3.googleusercontent.com/aida-public/AB6AXuAZQ2eQCNhkJN3R5RluRav0t2kp5R9vLOUcUJ1g_0r2v9M7jaAsHSNHroQc5ETZegE74c_sObZatTldU-wqBjQWEbiBeTDPwdJLXXNlfoI0bXG9mv18fazghPTxk26_mEGJFS0xylzWXdJ7Vxez51puGxnvCWK1jPk7ekA2-NJ1y3JpuBrlqRNqRIwNzUWdlI-lrcQlU1mz8uyVMidkiWUUiShEZkF7n4QmdF3D8r4CQE4Ypvt1nyEa1XlTE5BEuCifezx8v89T8L_G",
    },
  ];

  String searchText = '';

  @override
  Widget build(BuildContext context) {
    final filteredData = announcements.where((item) {
      return item['title']!
          .toLowerCase()
          .contains(searchText.toLowerCase());
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
        actions: [
          IconButton(
            icon: const Icon(
              Icons.search,
              color: Color(0xffAF101A),
            ),
            onPressed: () {},
          ),
        ],
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
            child: ListView.builder(
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
                            PengumumanDetailPage(
                          title:
                              item['title'] ?? '',
                          date:
                              item['date'] ?? '',
                          image:
                              item['image'] ?? '',
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
                          borderRadius:
                              BorderRadius.circular(
                            12,
                          ),
                          child: Image.network(
                            item['image']!,
                            width: 90,
                            height: 90,
                            fit: BoxFit.cover,
                          ),
                        ),

                        const SizedBox(width: 12),

                        Expanded(
                          child: Column(
                            crossAxisAlignment:
                                CrossAxisAlignment
                                    .start,
                            children: [
                              if (item['pinned'] ==
                                  'true')
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
                                item['date']!,
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
                                item['title']!,
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

  const PengumumanDetailPage({
    super.key,
    required this.title,
    required this.date,
    required this.image,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Detail Pengumuman'),
      ),
      body: ListView(
        children: [
          Image.network(
            image,
            height: 250,
            fit: BoxFit.cover,
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

                const Text(
                  'Isi pengumuman dapat ditampilkan di sini sesuai data dari API atau database.',
                  style: TextStyle(
                    height: 1.6,
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