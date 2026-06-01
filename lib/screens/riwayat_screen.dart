import 'package:flutter/material.dart';
import 'dashboard_screen.dart';
import 'info_screen.dart';
import 'profile_screen.dart';

class TransactionHistoryScreen extends StatefulWidget {
  const TransactionHistoryScreen({super.key});

  @override
  State<TransactionHistoryScreen> createState() =>
      _TransactionHistoryScreenState();
}

class _TransactionHistoryScreenState
    extends State<TransactionHistoryScreen> {
  int selectedFilter = 0;

  final List<String> filters = [
    'Semua',
    'Simpan',
    'Tarik',
  ];

  final List<Map<String, dynamic>> transactions = [
    {
      'title': 'Simpanan Sukarela',
      'amount': '+Rp 500.000',
      'time': '10:45 WIB',
      'status': 'Berhasil',
      'date': 'Hari Ini',
      'isIncome': true,
    },
    {
      'title': 'Penarikan Saldo',
      'amount': '-Rp 200.000',
      'time': '08:12 WIB',
      'status': 'Diproses',
      'date': 'Hari Ini',
      'isIncome': false,
    },
    {
      'title': 'Simpanan Wajib',
      'amount': '+Rp 100.000',
      'time': '14:20 WIB',
      'status': 'Berhasil',
      'date': '24 Okt 2023',
      'isIncome': true,
    },
    {
      'title': 'Simpanan Pokok',
      'amount': 'Rp 1.000.000',
      'time': '09:00 WIB',
      'status': 'Ditolak',
      'date': '24 Okt 2023',
      'isIncome': false,
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xffFCF9F8),

      appBar: AppBar(
        backgroundColor: const Color(0xffFCF9F8),
        elevation: 0,
        centerTitle: false,

        title: const Text(
          'Riwayat Transaksi',
          style: TextStyle(
            color: Color(0xffAF101A),
            fontWeight: FontWeight.bold,
          ),
        ),

        actions: [
          IconButton(
            onPressed: () {},

            icon: const Icon(
              Icons.search,
              color: Colors.black54,
            ),
          ),
        ],
      ),

      bottomNavigationBar: BottomNavigationBar(
      currentIndex: 1,
      selectedItemColor: const Color(0xffAF101A),
      unselectedItemColor: Colors.grey,

      onTap: (index) {

        if (index == 0) {

          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (_) => const DashboardScreen(),
            ),
          );

        } else if (index == 1) {

          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (_) => const TransactionHistoryScreen(),
            ),
          );

        } else if (index == 2) {

          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (_) => const InfoScreen(),
            ),
          );

        } else if (index == 3) {

          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (_) => const ProfileScreen(),
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
            label: 'Akun',
          ),
        ],
      ),

      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),

        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,

          children: [

            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(20),

              decoration: BoxDecoration(
                color: const Color(0xffD32F2F),
                borderRadius: BorderRadius.circular(24),
              ),

              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,

                children: [

                  Text(
                    'Total Transaksi Bulan Ini',
                    style: TextStyle(
                      color: Colors.white.withAlpha(230), // 0.9 * 255
                      fontSize: 14,
                    ),
                  ),

                  const SizedBox(height: 10),

                  Row(
                    crossAxisAlignment:
                        CrossAxisAlignment.end,

                    children: [

                      const Expanded(
                        child: Text(
                          'Rp 4.250.000',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 30,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ],
                  ),

                  const SizedBox(height: 20),

                  Row(
                    mainAxisAlignment:
                        MainAxisAlignment.spaceBetween,

                    children: const [

                      Row(
                        children: [

                          Icon(
                            Icons.calendar_month,
                            color: Colors.white,
                            size: 18,
                          ),

                          SizedBox(width: 6),

                          Text(
                            'Oktober 2023',
                            style: TextStyle(
                              color: Colors.white,
                            ),
                          ),
                        ],
                      ),

                      Text(
                        '24 Transaksi',
                        style: TextStyle(
                          color: Colors.white,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),

            const SizedBox(height: 24),

            SizedBox(
              height: 45,

              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: filters.length,

                itemBuilder: (context, index) {

                  final isSelected =
                      selectedFilter == index;

                  return Padding(
                    padding: const EdgeInsets.only(
                      right: 10,
                    ),

                    child: GestureDetector(
                      onTap: () {

                        setState(() {
                          selectedFilter = index;
                        });

                      },

                      child: Container(
                        padding:
                            const EdgeInsets.symmetric(
                          horizontal: 22,
                          vertical: 10,
                        ),

                        decoration: BoxDecoration(
                          color: isSelected
                              ? const Color(0xffD32F2F)
                              : Colors.grey.shade200,

                          borderRadius:
                              BorderRadius.circular(30),
                        ),

                        child: Text(
                          filters[index],

                          style: TextStyle(
                            color: isSelected
                                ? Colors.white
                                : Colors.black54,

                            fontWeight:
                                FontWeight.w600,
                          ),
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),

            const SizedBox(height: 24),

            buildTransactionGroup('Hari Ini'),

            const SizedBox(height: 24),

            buildTransactionGroup('24 Okt 2023'),

            const SizedBox(height: 40),

            Center(
              child: Column(
                children: const [

                  Icon(
                    Icons.receipt_long,
                    size: 40,
                    color: Colors.black26,
                  ),

                  SizedBox(height: 8),

                  Text(
                    'Menampilkan semua transaksi',
                    style: TextStyle(
                      color: Colors.black38,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget buildTransactionGroup(String date) {

    final filteredTransactions =
        transactions.where(
      (transaction) => transaction['date'] == date,
    ).toList();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,

      children: [

        Text(
          date.toUpperCase(),

          style: const TextStyle(
            fontWeight: FontWeight.bold,
            color: Colors.black54,
            letterSpacing: 1,
          ),
        ),

        const SizedBox(height: 12),

        Column(
          children: filteredTransactions.map((transaction) {

            final bool isIncome =
                transaction['isIncome'];

            Color iconBg;
            Color iconColor;
            IconData iconData;

            if (transaction['status'] == 'Ditolak') {

              iconBg = Colors.red.shade100;
              iconColor = Colors.red;
              iconData = Icons.close;

            } else if (isIncome) {

              iconBg = Colors.green.shade100;
              iconColor = Colors.green;
              iconData = Icons.south_west;

            } else {

              iconBg = Colors.red.shade100;
              iconColor = Colors.red;
              iconData = Icons.north_east;
            }

            return Container(
              margin: const EdgeInsets.only(
                bottom: 12,
              ),

              padding: const EdgeInsets.all(16),

              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius:
                    BorderRadius.circular(20),

                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withAlpha(102), // 0.4 * 255
                    blurRadius: 10,
                    offset: const Offset(0, 4),
                  ),
                ],
              ),

              child: Row(
                children: [

                  Container(
                    width: 50,
                    height: 50,

                    decoration: BoxDecoration(
                      color: iconBg,
                      borderRadius:
                          BorderRadius.circular(16),
                    ),

                    child: Icon(
                      iconData,
                      color: iconColor,
                    ),
                  ),

                  const SizedBox(width: 16),

                  Expanded(
                    child: Column(
                      crossAxisAlignment:
                          CrossAxisAlignment.start,

                      children: [

                        Row(
                          mainAxisAlignment:
                              MainAxisAlignment
                                  .spaceBetween,

                          children: [

                            Expanded(
                              child: Text(
                                transaction['title'],

                                style: const TextStyle(
                                  fontWeight:
                                      FontWeight.bold,
                                  fontSize: 15,
                                ),
                              ),
                            ),

                            Text(
                              transaction['amount'],

                              style: TextStyle(
                                color: isIncome
                                    ? Colors.green
                                    : Colors.black87,

                                fontWeight:
                                    FontWeight.bold,
                              ),
                            ),
                          ],
                        ),

                        const SizedBox(height: 8),

                        Row(
                          mainAxisAlignment:
                              MainAxisAlignment
                                  .spaceBetween,

                          children: [

                            Text(
                              transaction['time'],

                              style: const TextStyle(
                                color: Colors.black54,
                              ),
                            ),

                            Container(
                              padding:
                                  const EdgeInsets
                                      .symmetric(
                                horizontal: 10,
                                vertical: 4,
                              ),

                              decoration: BoxDecoration(
                                color:
                                    transaction['status'] ==
                                            'Berhasil'
                                        ? Colors
                                            .green
                                            .shade50
                                        : transaction['status'] ==
                                                'Diproses'
                                            ? Colors
                                                .orange
                                                .shade50
                                            : Colors
                                                .red
                                                .shade50,

                                borderRadius:
                                    BorderRadius
                                        .circular(20),
                              ),

                              child: Text(
                                transaction['status'],

                                style: TextStyle(
                                  fontSize: 11,
                                  fontWeight:
                                      FontWeight.bold,

                                  color:
                                      transaction['status'] ==
                                              'Berhasil'
                                          ? Colors.green
                                          : transaction['status'] ==
                                                  'Diproses'
                                              ? Colors.orange
                                              : Colors.red,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            );
          }).toList(),
        ),
      ],
    );
  }
}