import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';

class DetailTransaksiScreen extends StatelessWidget {
  final Map<String, dynamic> transaction;

  const DetailTransaksiScreen({
    super.key,
    required this.transaction,
  });

  static const Color primaryColor = Color(0xFFAF101A);

  @override
  Widget build(BuildContext context) {
    final String transactionId = transaction['id'] ?? '-';
    final status =
        transaction['status'] ?? '';

    String statusText = 'Menunggu';
    Color statusColor = Colors.orange;
    IconData statusIcon = Icons.schedule;

    if (status == 'approved') {
      statusText = 'Berhasil';
      statusColor = Colors.green;
      statusIcon = Icons.check_circle;
    } else if (status == 'rejected') {
      statusText = 'Ditolak';
      statusColor = Colors.red;
      statusIcon = Icons.close;
    }

    Color statusBg = Colors.orange.shade100;
      if (status == 'approved') {
        statusBg = Colors.green.shade100;
      } else if (status == 'rejected') {
        statusBg = Colors.red.shade100;
      }

    final metode = transaction['metode_pembayaran'] ?? '';
    final metodeIcon =
        metode == "Tunai"
            ? Icons.payments
            : Icons.qr_code;

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
                color: statusBg,
                shape: BoxShape.circle,
                boxShadow: [
                  BoxShadow(
                    color: Colors.greenAccent.withAlpha(100),
                    blurRadius: 20,
                  ),
                ],
              ),

              child: Icon(
                statusIcon,
                color: statusColor,
                size: 50,
              ),
            ),

            const SizedBox(height: 16),

            Text(
              statusText,
              style: TextStyle(
                color: statusColor,
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),

            const SizedBox(height: 8),

            Row(
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
                  NumberFormat.currency(
                    locale: 'id_ID',
                    symbol: '',
                    decimalDigits: 0,
                  ).format(
                    transaction['nominal'] ?? 0,
                  ),
                  style: const TextStyle(
                    fontSize: 34,
                    fontWeight: FontWeight.w800,
                  ),
                )
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
                    transaction['jenis_simpanan'] ?? '-',
                  ),

                  _detailItem(
                    'Tanggal',
                    DateFormat(
                      'dd MMMM yyyy',
                      'id_ID',
                    ).format(
                      DateTime.parse(
                        transaction['created_at'] ??
                            DateTime.now().toIso8601String(),
                      )
                    ),
                  ),

                  _detailItem(
                    'Waktu',
                    DateFormat(
                      'HH:mm',
                    ).format(
                      DateTime.parse(
                        transaction['created_at'],
                      ),
                    ) + " WIB",
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
                          children: [
                            Icon(
                              metodeIcon,
                            ),
                            SizedBox(width: 6),
                            Text(
                               transaction['metode_pembayaran'] ?? '-',
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

                        children: [

                          Text(
                            'ID Transaksi',
                            style: TextStyle(
                              color: Colors.grey,
                              fontSize: 12,
                            ),
                          ),

                          SizedBox(height: 4),

                          SizedBox(
                            width: 180,
                            child: Text(
                              transactionId,
                              overflow: TextOverflow.ellipsis,
                              style: const TextStyle(
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          )
                        ],
                      ),

                      ElevatedButton.icon(
                        onPressed: () async {
                          await Clipboard.setData(
                            ClipboardData(
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