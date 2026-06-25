import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../dashboard_screen.dart';
import '../riwayat_screen.dart';
import 'package:intl/intl.dart';

class SetoranBerhasilScreen extends StatelessWidget {

  final String transaksiId;
  final String nominal;
  final String jenis;
  final String metodePembayaran;

  const SetoranBerhasilScreen({
    super.key,
    required this.transaksiId,
    required this.nominal,
    required this.jenis,
    required this.metodePembayaran,
  });

  String get currentDate {
    final now = DateTime.now();

    return
        "${now.day}/${now.month}/${now.year} "
        "${now.hour}:${now.minute}";
  }

  String formatRupiah(String nominal) {
    final number =
        int.tryParse(nominal) ?? 0;

    return NumberFormat.currency(
      locale: 'id_ID',
      symbol: '',
      decimalDigits: 0,
    ).format(number);
  }

  static const Color primaryColor = Color(0xFFAF101A);

  void copyTransactionId(BuildContext context) {
    Clipboard.setData(
      ClipboardData(
        text: transaksiId,
      ),
    );

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('ID transaksi berhasil disalin')),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xffFCF9F8),

      appBar: AppBar(
        backgroundColor: const Color(0xffFCF9F8),
        elevation: 0,

        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: primaryColor),
          onPressed: () => Navigator.pop(context),
        ),

        title: const Text(
          'Notifikasi',
          style: TextStyle(color: Colors.black87, fontWeight: FontWeight.bold),
        ),

        actions: const [
          Padding(
            padding: EdgeInsets.only(right: 8),
            child: Icon(Icons.done_all, color: primaryColor),
          ),
        ],
      ),

      body: Stack(
        children: [
          Positioned(
            top: -80,
            right: -80,
            child: Container(
              width: 250,
              height: 250,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: primaryColor.withAlpha(50),
              ),
            ),
          ),

          Positioned(
            bottom: 100,
            left: -120,
            child: Container(
              width: 320,
              height: 320,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: primaryColor.withAlpha(50),
              ),
            ),
          ),

          SafeArea(
            child: Column(
              children: [
                Expanded(
                  child: SingleChildScrollView(
                    padding: const EdgeInsets.all(16),

                    child: Column(
                      children: [
                        const SizedBox(height: 12),

                        // SUCCESS ICON
                        Column(
                          children: [
                            Container(
                              padding: const EdgeInsets.all(18),

                              decoration: BoxDecoration(
                                color: primaryColor.withAlpha(50),
                                shape: BoxShape.circle,
                              ),

                              child: Container(
                                width: 80,
                                height: 80,

                                decoration: const BoxDecoration(
                                  color: primaryColor,
                                  shape: BoxShape.circle,
                                ),

                                child: const Icon(
                                  Icons.hourglass_top,
                                  color: Colors.white,
                                  size: 48,
                                ),
                              ),
                            ),

                            const SizedBox(height: 20),

                            const Text(
                              'Menunggu Verifikasi',
                              style: TextStyle(
                                fontSize: 28,
                                fontWeight: FontWeight.bold,
                              ),
                            ),

                            const SizedBox(height: 8),

                            const Text(
                              'Bukti pembayaran berhasil dikirim dan sedang menunggu verifikasi admin.',
                              textAlign: TextAlign.center,
                              style: TextStyle(color: Colors.grey),
                            ),
                          ],
                        ),

                        const SizedBox(height: 24),

                        // NOMINAL
                        Container(
                          width: double.infinity,
                          padding: const EdgeInsets.symmetric(
                            vertical: 20,
                            horizontal: 16,
                          ),

                          decoration: BoxDecoration(
                            color: const Color(0xffF6F3F2),
                            borderRadius: BorderRadius.circular(16),
                          ),

                          child: Column(
                            children: [
                              Text(
                                'JUMLAH SETORAN',
                                style: TextStyle(
                                  fontSize: 12,
                                  color: Colors.grey,
                                  letterSpacing: 2,
                                ),
                              ),

                              SizedBox(height: 8),

                              Text(
                                'Rp ${formatRupiah(nominal)}',
                                style: const TextStyle(
                                  color: primaryColor,
                                  fontSize: 32,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ],
                          ),
                        ),

                        const SizedBox(height: 20),

                        // DETAIL CARD
                        Container(
                          padding: const EdgeInsets.all(16),

                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(16),
                            border: Border.all(color: const Color(0xffE4BEBA)),
                          ),

                          child: Column(
                            children: [
                              Row(
                                children: [
                                  const Expanded(
                                    child: Text(
                                      'Rincian Transaksi',
                                      style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ),

                                  Container(
                                    padding: const EdgeInsets.symmetric(
                                      horizontal: 10,
                                      vertical: 4,
                                    ),

                                    decoration: BoxDecoration(
                                      color: Colors.orange.shade100,
                                      borderRadius: BorderRadius.circular(20),
                                    ),

                                    child: const Row(
                                      mainAxisSize: MainAxisSize.min,
                                      children: [
                                        Icon(
                                          Icons.pending_actions,
                                          size: 14,
                                          color: Colors.orange,
                                        ),

                                        SizedBox(width: 4),

                                        Text(
                                          'Menunggu Verifikasi',
                                          style: TextStyle(
                                            fontSize: 11,
                                            color: Colors.orange,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),

                              const Divider(height: 24),

                              _detailRow(
                                'Jenis Transaksi',
                                jenis,
                              ),

                              _detailRow(
                                'Tanggal & Waktu',
                                currentDate,
                              ),

                              Padding(
                                padding: const EdgeInsets.only(bottom: 14),
                                child: Row(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    const Expanded(
                                      flex: 3,
                                      child: Text(
                                        'ID Transaksi',
                                        style: TextStyle(
                                          color: Colors.grey,
                                        ),
                                      ),
                                    ),

                                    Expanded(
                                      flex: 5,
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.end,
                                        children: [
                                          Flexible(
                                            child: SelectableText(
                                              transaksiId,
                                              textAlign: TextAlign.end,
                                              style: const TextStyle(
                                                fontWeight: FontWeight.w600,
                                              ),
                                            ),
                                          ),

                                          IconButton(
                                            onPressed: () =>
                                                copyTransactionId(context),
                                            icon: const Icon(
                                              Icons.copy,
                                              size: 18,
                                              color: primaryColor,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ),

                              _detailRow(
                                'Metode Pembayaran',
                                metodePembayaran,
                              ),

                              _detailRow(
                                'Status',
                                'Pending',
                              ),

                              const SizedBox(height: 16),
                            ],
                          ),
                        ),

                        const SizedBox(height: 20),

                        Container(
                          padding: const EdgeInsets.all(16),
                          decoration: BoxDecoration(
                            color: const Color(0xffFFF3CD),
                            borderRadius: BorderRadius.circular(16),
                          ),
                          child: const Row(
                            children: [
                              Icon(
                                Icons.info_outline,
                                color: Colors.orange,
                              ),
                              SizedBox(width: 12),
                              Expanded(
                                child: Text(
                                  'Setoran akan diverifikasi maksimal 1x24 jam. Setelah disetujui saldo simpanan akan otomatis bertambah.',
                                ),
                              ),
                            ],
                          ),
                        )
                      ],
                    ),
                  ),
                ),

                // BUTTONS
                Padding(
                  padding: const EdgeInsets.all(16),

                  child: Column(
                    children: [
                      SizedBox(
                        width: double.infinity,
                        height: 56,

                        child: ElevatedButton.icon(
                          onPressed: () {
                            Navigator.pushAndRemoveUntil(
                              context,
                              MaterialPageRoute(
                                  builder: (context) =>
                                      const DashboardScreen()),
                              (route) => false,
                            );
                          },

                          style: ElevatedButton.styleFrom(
                            backgroundColor: primaryColor,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12),
                            ),
                          ),

                          icon: const Icon(
                            Icons.home_outlined,
                            color: Colors.white,
                          ),

                          label: const Text(
                            'Ke Beranda',
                            style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),

                      const SizedBox(height: 12),

                      SizedBox(
                        width: double.infinity,
                        height: 56,

                        child: OutlinedButton(
                          onPressed: () {Navigator.pushAndRemoveUntil(
                              context,
                              MaterialPageRoute(
                                  builder: (context) =>
                                      const TransactionHistoryScreen()),
                              (route) => false,
                            );
                          },

                          style: OutlinedButton.styleFrom(
                            side: const BorderSide(color: Color(0xffE4BEBA)),

                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12),
                            ),
                          ),

                          child: const Text(
                            'Lihat Riwayat Setoran',
                            style: TextStyle(
                              color: primaryColor,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  static Widget _detailRow(String title, String value) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 14),

      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,

        crossAxisAlignment: CrossAxisAlignment.start,

        children: [
          Text(title, style: const TextStyle(color: Colors.grey)),

          Flexible(
            child: Text(
              value,
              textAlign: TextAlign.end,
              style: const TextStyle(fontWeight: FontWeight.w600),
            ),
          ),
        ],
      ),
    );
  }
}
