import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class DetailTransaksiScreen extends StatelessWidget {
  final Map<String, dynamic> transaction;

  const DetailTransaksiScreen({
    super.key,
    required this.transaction,
  });

  static const Color primaryColor = Color(0xFFAF101A);

  @override
  Widget build(BuildContext context) {
    const String transactionId = 'TRX-98231';

    return Scaffold(
      backgroundColor: const Color(0xFFFCF9F8),

      appBar: AppBar(
        backgroundColor: const Color(0xFFFCF9F8),
        elevation: 0,
        leading: IconButton(
          icon: const Icon(
            Icons.arrow_back,
            color: primaryColor,
          ),
          onPressed: () => Navigator.pop(context),
        ),
        title: const Text(
          'Detail Transaksi',
          style: TextStyle(
            color: Colors.black87,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),

      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),

        child: Column(
          children: [

            // STATUS
            const SizedBox(height: 16),

            Container(
              width: 80,
              height: 80,

              decoration: BoxDecoration(
                color: Color(0xFFE8F5E9),
                shape: BoxShape.circle,
                boxShadow: [
                  BoxShadow(
                    color: Colors.greenAccent.withAlpha(100),
                    blurRadius: 20,
                  ),
                ],
              ),

              child: const Icon(
                Icons.check_circle,
                color: Colors.green,
                size: 50,
              ),
            ),

            const SizedBox(height: 16),

            const Text(
              'Berhasil',
              style: TextStyle(
                fontSize: 24,
                color: Colors.green,
                fontWeight: FontWeight.bold,
              ),
            ),

            const SizedBox(height: 8),

            const Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'Rp ',
                  style: TextStyle(
                    color: Colors.grey,
                    fontSize: 16,
                  ),
                ),
                Text(
                  '500.000',
                  style: TextStyle(
                    fontSize: 34,
                    fontWeight: FontWeight.w800,
                  ),
                ),
              ],
            ),

            const SizedBox(height: 32),

            // CARD DETAIL
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(20),

              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(16),
                border: Border.all(
                  color: const Color(0xFFF0EDED),
                ),
              ),

              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [

                  const Text(
                    'RINCIAN TRANSAKSI',
                    style: TextStyle(
                      color: Colors.grey,
                      fontWeight: FontWeight.w600,
                      letterSpacing: 1,
                    ),
                  ),

                  const SizedBox(height: 24),

                  _detailItem(
                    'Jenis Transaksi',
                    'Simpanan Sukarela',
                  ),

                  _detailItem(
                    'Tanggal',
                    '25 Oktober 2023',
                  ),

                  _detailItem(
                    'Waktu',
                    '10:45 WIB',
                  ),

                  Padding(
                    padding: const EdgeInsets.only(bottom: 24),

                    child: Row(
                      mainAxisAlignment:
                          MainAxisAlignment.spaceBetween,

                      children: [
                        const Text(
                          'Metode Pembayaran',
                          style: TextStyle(
                            color: Colors.grey,
                          ),
                        ),

                        Row(
                          children: const [
                            Icon(
                              Icons.qr_code,
                              color: primaryColor,
                              size: 20,
                            ),
                            SizedBox(width: 6),
                            Text(
                              'QRIS',
                              style: TextStyle(
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),

                  const Divider(),

                  const SizedBox(height: 10),

                  Row(
                    mainAxisAlignment:
                        MainAxisAlignment.spaceBetween,

                    children: [

                      Column(
                        crossAxisAlignment:
                            CrossAxisAlignment.start,

                        children: const [

                          Text(
                            'ID Transaksi',
                            style: TextStyle(
                              color: Colors.grey,
                              fontSize: 12,
                            ),
                          ),

                          SizedBox(height: 4),

                          Text(
                            transactionId,
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),

                      ElevatedButton.icon(
                        onPressed: () async {
                          await Clipboard.setData(
                            const ClipboardData(
                              text: transactionId,
                            ),
                          );

                          if (context.mounted) {
                            ScaffoldMessenger.of(context)
                                .showSnackBar(
                              const SnackBar(
                                content: Text(
                                  'ID Transaksi berhasil disalin!',
                                ),
                              ),
                            );
                          }
                        },

                        style: ElevatedButton.styleFrom(
                          backgroundColor:
                              const Color(0xFFDFE0E0),
                          elevation: 0,
                        ),

                        icon: const Icon(
                          Icons.copy,
                          size: 18,
                          color: Colors.black54,
                        ),

                        label: const Text(
                          'Salin',
                          style: TextStyle(
                            color: Colors.black87,
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),

            const SizedBox(height: 24),

            // ACTION BUTTONS
            Row(
              children: [

                Expanded(
                  child: OutlinedButton.icon(
                    onPressed: () {},

                    style: OutlinedButton.styleFrom(
                      side: const BorderSide(
                        color: primaryColor,
                        width: 2,
                      ),

                      shape: RoundedRectangleBorder(
                        borderRadius:
                            BorderRadius.circular(12),
                      ),

                      padding:
                          const EdgeInsets.symmetric(
                        vertical: 14,
                      ),
                    ),

                    icon: const Icon(
                      Icons.download,
                      color: primaryColor,
                    ),

                    label: const Text(
                      'Unduh Bukti',
                      style: TextStyle(
                        color: primaryColor,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ),

                const SizedBox(width: 12),

                Expanded(
                  child: ElevatedButton.icon(
                    onPressed: () {},

                    style: ElevatedButton.styleFrom(
                      backgroundColor: primaryColor,

                      shape: RoundedRectangleBorder(
                        borderRadius:
                            BorderRadius.circular(12),
                      ),

                      padding:
                          const EdgeInsets.symmetric(
                        vertical: 14,
                      ),
                    ),

                    icon: const Icon(
                      Icons.share,
                      color: Colors.white,
                    ),

                    label: const Text(
                      'Bagikan',
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  static Widget _detailItem(
    String title,
    String value,
  ) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 24),

      child: Row(
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
            style: const TextStyle(
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      ),
    );
  }
}