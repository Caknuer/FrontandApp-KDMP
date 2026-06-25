import 'package:flutter/material.dart';
import 'dashboard_screen.dart';
import 'info_screen.dart';
import 'page-profil/profile_screen.dart';
import 'detailtransaksi_screen.dart';
import '../../services/transaksi_setoran_service.dart';
import '../../services/penarikan_service.dart';
import 'package:intl/intl.dart';

class TransactionHistoryScreen extends StatefulWidget {
  const TransactionHistoryScreen({super.key});

  @override
  State<TransactionHistoryScreen> createState() =>
      _TransactionHistoryScreenState();
}

class _TransactionHistoryScreenState extends State<TransactionHistoryScreen> {
  int selectedFilter = 0;

  final List<String> filters = ['Semua', 'Simpan', 'Tarik'];

  List<dynamic> transactions = [];
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    loadData();
  }

  Future<void> loadData() async {
    if (!mounted) return;

    setState(() {
      isLoading = true;
    });

    final setoran = await TransaksiSetoranService.getByUser();

    final penarikan = await PenarikanService.getByUser();

    final allTransactions = [
      ...setoran.map((e) => {...e, "tipe": "setoran"}),

      ...penarikan.map((e) => {...e, "tipe": "penarikan"}),
    ];

    allTransactions.sort(
      (a, b) => DateTime.parse(
        b["created_at"],
      ).compareTo(DateTime.parse(a["created_at"])),
    );

    setState(() {
      transactions = allTransactions;
      isLoading = false;
    });
  }

  String getStatusText(String status) {
    switch (status) {
      case "approved":
        return "Berhasil";

      case "pending":
        return "Menunggu";

      case "rejected":
        return "Ditolak";

      default:
        return status;
    }
  }

  String formatRupiah(String nominal) {
    final number = int.tryParse(nominal) ?? 0;

    return NumberFormat.currency(
      locale: 'id_ID',
      symbol: '',
      decimalDigits: 0,
    ).format(number);
  }

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
      ),

      bottomNavigationBar: BottomNavigationBar(
        currentIndex: 1,
        selectedItemColor: const Color(0xffAF101A),
        unselectedItemColor: Colors.grey,

        onTap: (index) {
          if (index == 0) {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: (_) => const DashboardScreen()),
            );
          } else if (index == 1) {
            return;
          } else if (index == 2) {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: (_) => const InfoScreen()),
            );
          } else if (index == 3) {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: (_) => const ProfileScreen()),
            );
          }
        },

        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Beranda'),

          BottomNavigationBarItem(icon: Icon(Icons.history), label: 'Riwayat'),

          BottomNavigationBarItem(icon: Icon(Icons.info), label: 'Info'),

          BottomNavigationBarItem(icon: Icon(Icons.person), label: 'Akun'),
        ],
      ),

      body: isLoading
          ? const Center(child: CircularProgressIndicator())
          : RefreshIndicator(
              onRefresh: loadData,
              child: SingleChildScrollView(
                physics: const AlwaysScrollableScrollPhysics(),
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,

                  children: [
                    SizedBox(
                      height: 45,

                      child: ListView.builder(
                        scrollDirection: Axis.horizontal,
                        itemCount: filters.length,

                        itemBuilder: (context, index) {
                          final isSelected = selectedFilter == index;

                          return Padding(
                            padding: const EdgeInsets.only(right: 10),

                            child: GestureDetector(
                              onTap: () {
                                setState(() {
                                  selectedFilter = index;
                                });
                              },

                              child: Container(
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 22,
                                  vertical: 10,
                                ),

                                decoration: BoxDecoration(
                                  color: isSelected
                                      ? const Color(0xffD32F2F)
                                      : Colors.grey.shade200,

                                  borderRadius: BorderRadius.circular(30),
                                ),

                                child: Text(
                                  filters[index],

                                  style: TextStyle(
                                    color: isSelected
                                        ? Colors.white
                                        : Colors.black54,

                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              ),
                            ),
                          );
                        },
                      ),
                    ),

                    const SizedBox(height: 24),

                    buildTransactionGroup(context),
                  ],
                ),
              ),
            ),
    );
  }

  Widget buildTransactionGroup(BuildContext context) {
    final filteredTransactions = transactions.where((item) {
      if (selectedFilter == 1) {
        return item["tipe"] == "setoran";
      }

      if (selectedFilter == 2) {
        return item["tipe"] == "penarikan";
      }

      return true;
    }).toList();

    if (filteredTransactions.isEmpty) {
      return Center(
        child: Padding(
          padding: const EdgeInsets.only(top: 80),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: const [
              Icon(Icons.receipt_long, size: 80, color: Colors.grey),

              SizedBox(height: 16),

              Text(
                'Belum Ada Transaksi',
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),

              SizedBox(height: 8),

              Text(
                'Riwayat transaksi akan muncul di sini',
                textAlign: TextAlign.center,
                style: TextStyle(color: Colors.grey),
              ),
            ],
          ),
        ),
      );
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,

      children: [
        Column(
          children: filteredTransactions.map((transaction) {
            final bool isIncome = transaction["tipe"] == "setoran";
            final status = transaction['status'] ?? '';
            final statusText = getStatusText(status);

            Color iconBg;
            Color iconColor;
            IconData iconData;

            if (transaction["tipe"] ==
                "penarikan") {

              iconBg =
                  Colors.red.shade100;

              iconColor = Colors.red;

              iconData =
                  Icons.arrow_upward;

            }
            else {

              iconBg =
                  Colors.green.shade100;

              iconColor =
                  Colors.green;

              iconData =
                  Icons.arrow_downward;

            }

            if (status == 'rejected') {
              iconBg = Colors.red.shade100;
              iconColor = Colors.red;
              iconData = Icons.close;
            } else if (status == 'pending') {
              iconBg = Colors.orange.shade100;
              iconColor = Colors.orange;
              iconData = Icons.schedule;
            } else {
              iconBg = Colors.green.shade100;
              iconColor = Colors.green;
              iconData = Icons.check;
            }

            return InkWell(
              borderRadius: BorderRadius.circular(20),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) =>
                        DetailTransaksiScreen(transaction: transaction),
                  ),
                );
              },
              child: Container(
                margin: const EdgeInsets.only(bottom: 12),

                padding: const EdgeInsets.all(16),

                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(20),

                  boxShadow: [
                    BoxShadow(
                      color: Colors.black12, // 0.4 * 255
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
                        borderRadius: BorderRadius.circular(16),
                      ),

                      child: Icon(iconData, color: iconColor),
                    ),

                    const SizedBox(width: 16),

                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,

                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,

                            children: [
                              Expanded(
                                child: Text(
                                  transaction["tipe"] == "setoran"
                                      ? transaction["jenis_simpanan"]
                                      : "Penarikan Saldo",

                                  style: const TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 15,
                                  ),
                                ),
                              ),

                              Text(
                                "Rp ${formatRupiah((transaction['nominal'] ?? 0).toString())}",

                                style: TextStyle(
                                  color: isIncome ? Colors.green : Colors.red,

                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ],
                          ),

                          const SizedBox(height: 8),

                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,

                            children: [
                              Text(
                                DateFormat('dd/MM/yyyy HH:mm').format(
                                  DateTime.parse(
                                    transaction['created_at'] ??
                                        DateTime.now().toIso8601String(),
                                  ),
                                ),
                                style: const TextStyle(color: Colors.black54),
                              ),

                              Container(
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 10,
                                  vertical: 4,
                                ),

                                decoration: BoxDecoration(
                                  color: status == "approved"
                                      ? Colors.green.shade50
                                      : status == "pending"
                                      ? Colors.orange.shade50
                                      : Colors.red.shade50,

                                  borderRadius: BorderRadius.circular(20),
                                ),

                                child: Text(
                                  statusText,

                                  style: TextStyle(
                                    fontSize: 11,
                                    fontWeight: FontWeight.bold,

                                    color: status == "approved"
                                        ? Colors.green
                                        : status == "pending"
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
              ),
            );
          }).toList(),
        ),
      ],
    );
  }
}
