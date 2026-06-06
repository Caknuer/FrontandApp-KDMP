import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'setoran_berhasil_screen.dart';

class KonfirmasiSetoranScreen extends StatefulWidget {
  const KonfirmasiSetoranScreen({super.key});

  @override
  State<KonfirmasiSetoranScreen> createState() =>
      _KonfirmasiSetoranScreenState();
}

class _KonfirmasiSetoranScreenState
    extends State<KonfirmasiSetoranScreen> {
  static const Color primaryColor = Color(0xFFAF101A);

  late Timer timer;

  Duration remainingTime = const Duration(
    hours: 23,
    minutes: 55,
    seconds: 18,
  );

  @override
  void initState() {
    super.initState();

    timer = Timer.periodic(
      const Duration(seconds: 1),
      (_) {
        if (remainingTime.inSeconds > 0) {
          setState(() {
            remainingTime =
                remainingTime - const Duration(seconds: 1);
          });
        }
      },
    );
  }

  @override
  void dispose() {
    timer.cancel();
    super.dispose();
  }

  String get countdown {
    final h = remainingTime.inHours
        .toString()
        .padLeft(2, '0');

    final m = (remainingTime.inMinutes % 60)
        .toString()
        .padLeft(2, '0');

    final s = (remainingTime.inSeconds % 60)
        .toString()
        .padLeft(2, '0');

    return '$h:$m:$s';
  }

  void copyId() {
    Clipboard.setData(
      const ClipboardData(text: 'SET-98231'),
    );

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('ID berhasil disalin'),
      ),
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
          icon: const Icon(
            Icons.arrow_back,
            color: primaryColor,
          ),
          onPressed: () => Navigator.pop(context),
        ),

        title: const Text(
          'Konfirmasi Setoran',
          style: TextStyle(
            color: primaryColor,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),

      body: SingleChildScrollView(
        padding: const EdgeInsets.fromLTRB(
          16,
          8,
          16,
          100,
        ),

        child: Column(
          children: [
            // STATUS CARD
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(24),

              decoration: BoxDecoration(
                color: primaryColor,
                borderRadius: BorderRadius.circular(20),
              ),

              child: Column(
                children: [
                  const Icon(
                    Icons.pending_actions,
                    size: 50,
                    color: Colors.white,
                  ),

                  const SizedBox(height: 12),

                  const Text(
                    'Menunggu Pembayaran',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
                  ),

                  const SizedBox(height: 6),

                  const Text(
                    'Segera selesaikan transaksi Anda',
                    style: TextStyle(
                      color: Colors.white70,
                    ),
                  ),

                  const SizedBox(height: 20),

                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 20,
                      vertical: 10,
                    ),

                    decoration: BoxDecoration(
                      color: Colors.white.withAlpha(26),
                      borderRadius:
                          BorderRadius.circular(50),
                    ),

                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        const Icon(
                          Icons.timer,
                          color: Colors.white,
                          size: 18,
                        ),

                        const SizedBox(width: 8),

                        Text(
                          'Sisa waktu: $countdown',
                          style: const TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 16),

            // DETAIL SIMPANAN
            _buildCard(
              title: 'Detail Simpanan',
              icon: Icons.receipt_long,
              child: Column(
                children: [
                  _detailRow(
                    'Jenis Simpanan',
                    'Simpanan Sukarela',
                  ),

                  const SizedBox(height: 12),

                  _detailRow(
                    'Nominal Setoran',
                    'Rp 500.000',
                    valueColor: primaryColor,
                    big: true,
                  ),

                  const Divider(height: 24),

                  const Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      'Catatan',
                      style: TextStyle(
                        color: Colors.grey,
                      ),
                    ),
                  ),

                  const SizedBox(height: 4),

                  const Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      '"Tabungan untuk usaha mikro"',
                      style: TextStyle(
                        fontStyle: FontStyle.italic,
                      ),
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 16),

            Align(
              alignment: Alignment.centerLeft,
              child: Text(
                'Metode Pembayaran',
                style: TextStyle(
                  color: Colors.grey.shade700,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),

            const SizedBox(height: 12),

            // QRIS
            _buildCard(
              title: 'Bayar via QRIS (Instant)',
              icon: Icons.qr_code_2,
              trailing: Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 8,
                  vertical: 4,
                ),

                decoration: BoxDecoration(
                  color: primaryColor.withAlpha(26),
                  borderRadius:
                      BorderRadius.circular(20),
                ),

                child: const Text(
                  'OTOMATIS',
                  style: TextStyle(
                    color: primaryColor,
                    fontSize: 10,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),

              child: Column(
                children: [
                  Container(
                    padding: const EdgeInsets.all(20),

                    decoration: BoxDecoration(
                      color: const Color(0xffF0EDED),
                      borderRadius:
                          BorderRadius.circular(12),
                      border: Border.all(
                        color: Colors.grey.shade300,
                        style: BorderStyle.solid,
                      ),
                    ),

                    child: Column(
                      children: [
                        Container(
                          width: 220,
                          height: 220,
                          padding:
                              const EdgeInsets.all(10),
                          color: Colors.white,

                          child: Image.network(
                            'https://api.qrserver.com/v1/create-qr-code/?size=300x300&data=SET-98231',
                            fit: BoxFit.cover,
                          ),
                        ),

                        const SizedBox(height: 12),

                        const Text(
                          'Scan QRIS untuk pembayaran instan melalui aplikasi bank atau e-wallet pilihan Anda.',
                          textAlign: TextAlign.center,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 16),

            // TUNAI
            _buildCard(
              title: 'Bayar Tunai',
              icon: Icons.payments,

              child: Column(
                crossAxisAlignment:
                    CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Bayar Tunai di Kantor Koperasi',
                    style: TextStyle(
                      color: primaryColor,
                      fontWeight: FontWeight.bold,
                    ),
                  ),

                  const SizedBox(height: 8),

                  const Text(
                    'Kunjungi kantor terdekat dan tunjukkan ID Transaksi kepada petugas.',
                  ),

                  const SizedBox(height: 12),

                  Container(
                    padding: const EdgeInsets.all(12),

                    decoration: BoxDecoration(
                      color: const Color(0xffF0EDED),
                      borderRadius:
                          BorderRadius.circular(10),
                    ),

                    child: Row(
                      children: [
                        const Expanded(
                          child: Text(
                            'SET-98231',
                            style: TextStyle(
                              fontSize: 20,
                              fontWeight:
                                  FontWeight.bold,
                              letterSpacing: 2,
                            ),
                          ),
                        ),

                        ElevatedButton.icon(
                          onPressed: copyId,

                          style:
                              ElevatedButton.styleFrom(
                            backgroundColor:
                                primaryColor,
                          ),

                          icon: const Icon(
                            Icons.copy,
                            size: 18,
                            color: Colors.white,
                          ),

                          label: const Text(
                            'Salin',
                            style: TextStyle(
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 16),

            // INFO
            Container(
              padding: const EdgeInsets.all(16),

              decoration: BoxDecoration(
                color: const Color(0xffFFDAD6),
                borderRadius: BorderRadius.circular(16),
              ),

              child: const Row(
                crossAxisAlignment:
                    CrossAxisAlignment.start,
                children: [
                  Icon(
                    Icons.warning,
                    color: Colors.red,
                  ),

                  SizedBox(width: 12),

                  Expanded(
                    child: Column(
                      crossAxisAlignment:
                          CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Silakan transfer sebelum 24 jam untuk menghindari pembatalan otomatis.',
                        ),

                        SizedBox(height: 8),

                        Text(
                          'Admin akan melakukan verifikasi dalam 2x24 jam setelah konfirmasi diterima.',
                          style: TextStyle(
                            fontWeight:
                                FontWeight.bold,
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
      ),

      bottomNavigationBar: Container(
        padding: const EdgeInsets.all(16),
        color: Colors.white,

        child: SizedBox(
          height: 55,

          child: ElevatedButton(
            onPressed: () {
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                  builder: (_) =>
                      const SetoranBerhasilScreen(),
                ),
              );
            },

            style: ElevatedButton.styleFrom(
              backgroundColor: primaryColor,
              shape: RoundedRectangleBorder(
                borderRadius:
                    BorderRadius.circular(14),
              ),
            ),

            child: const Text(
              'Selesai',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildCard({
    required String title,
    required IconData icon,
    required Widget child,
    Widget? trailing,
  }) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(16),

      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: const Color(0xffE4BEBA),
        ),
      ),

      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              const Icon(Icons.info),
              const SizedBox(width: 8),
              Expanded(
                child: Text(title),
              ),
              trailing,
            ].whereType<Widget>().toList(),
          ),

          const SizedBox(height: 16),

          child,
        ],
      ),
    );
  }

  Widget _detailRow(
    String title,
    String value, {
    bool big = false,
    Color? valueColor,
  }) {
    return Row(
      mainAxisAlignment:
          MainAxisAlignment.spaceBetween,

      children: [
        Text(
          title,
          style: const TextStyle(
            color: Colors.grey,
          ),
        ),

        Text(
          value,
          style: TextStyle(
            color: valueColor,
            fontSize: big ? 22 : 14,
            fontWeight:
                big ? FontWeight.bold : FontWeight.w500,
          ),
        ),
      ],
    );
  }
}