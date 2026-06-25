import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:flutter/services.dart';

class KonfirmasiPenarikanScreen extends StatelessWidget {

  final String nominal;
  final String keterangan;
  final String transaksiId;

  const KonfirmasiPenarikanScreen({
    super.key,
    required this.nominal,
    required this.keterangan,
    required this.transaksiId,
  });

  static const Color primaryColor = Color(0xFFAF101A);
  
  String formatRupiah(String nominal) {
    final value =
        int.tryParse(nominal) ?? 0;

    return NumberFormat.currency(
      locale: 'id_ID',
      symbol: '',
      decimalDigits: 0,
    ).format(value);

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFFCF9F8),

      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0.5,
        leading: IconButton(
          icon: const Icon(
            Icons.arrow_back,
            color: primaryColor,
          ),
          onPressed: () => Navigator.pop(context),
        ),
        title: const Text(
          'Koperasi Desa',
          style: TextStyle(
            color: primaryColor,
            fontWeight: FontWeight.bold,
          ),
        ),
        actions: [
          IconButton(
            onPressed: () {
              Navigator.popUntil(
                context,
                (route) => route.isFirst,
              );
            },
            icon: const Icon(
              Icons.close,
              color: Colors.black54,
            ),
          ),
        ],
      ),

      bottomNavigationBar: Container(
        padding: const EdgeInsets.all(16),
        decoration: const BoxDecoration(
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              blurRadius: 10,
              color: Colors.black12,
              offset: Offset(0, -2),
            ),
          ],
        ),
        child: SizedBox(
          height: 52,
          child: ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: primaryColor,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
            ),
            onPressed: () {
              Navigator.popUntil(
                context,
                (route) => route.isFirst,
              );
            },
            child: const Text(
              'Kembali ke Beranda',
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        ),
      ),

      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),

        child: Column(
          children: [
            const SizedBox(height: 16),

            // SUCCESS SECTION
            Container(
              width: 96,
              height: 96,
              decoration: BoxDecoration(
                color: primaryColor.withAlpha(13), // 0.1 * 255
                shape: BoxShape.circle,
              ),
              child: Center(
                child: Container(
                  width: 78,
                  height: 78,
                  decoration: const BoxDecoration(
                    color: primaryColor,
                    shape: BoxShape.circle,
                  ),
                  child: const Icon(
                    Icons.check_circle,
                    color: Colors.white,
                    size: 48,
                  ),
                ),
              ),
            ),

            const SizedBox(height: 20),

            const Text(
              'Menunggu Verifikasi',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 26,
                fontWeight: FontWeight.bold,
              ),
            ),

            const SizedBox(height: 10),

            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 24),
              child: Text(
                'Permintaan penarikan berhasil dikirim dan sedang menunggu verifikasi admin koperasi.',
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Colors.black54,
                  height: 1.5,
                ),
              ),
            ),

            const SizedBox(height: 24),

            // DETAIL CARD
            Container(
              padding: const EdgeInsets.all(16),

              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(16),
                border: Border.all(
                  color: Colors.grey.shade200,
                ),
              ),

              child: Column(
                children: [
                  Row(
                    children: const [
                      Icon(
                        Icons.receipt_long,
                        size: 18,
                        color: primaryColor,
                      ),
                      SizedBox(width: 6),
                      Text(
                        'Rincian Penarikan',
                        style: TextStyle(
                          color: primaryColor,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ],
                  ),

                  const SizedBox(height: 14),

                  Divider(color: Colors.grey.shade200),

                  const SizedBox(height: 10),

                  _detailRow(
                    'Nominal Penarikan',
                    'Rp ${formatRupiah(nominal)}',
                  ),

                  const SizedBox(height: 14),

                  _detailRow(
                    'Jenis Simpanan',
                    'Simpanan Sukarela',
                  ),

                  const SizedBox(height: 14),

                  Row(
                    crossAxisAlignment:
                        CrossAxisAlignment.start,
                    children: [
                      Expanded(
                      child: Text(
                        'ID Transaksi',
                        style: const TextStyle(
                          color: Colors.black54,
                        ),
                      ),
                    ),

                      Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 10,
                          vertical: 6,
                        ),
                        decoration: BoxDecoration(
                          color: const Color(0xFFF0EDED),
                          borderRadius:
                              BorderRadius.circular(8),
                        ),
                        child: Text(
                          transaksiId,
                          style: const TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),

                      IconButton(
                        onPressed: () async {
                          await Clipboard.setData(
                            ClipboardData(
                              text: transaksiId,
                            ),
                          );

                          if (context.mounted) {

                            ScaffoldMessenger.of(context)
                                .showSnackBar(
                              const SnackBar(
                                content: Text(
                                  "ID transaksi berhasil disalin",
                                ),
                              ),
                            );

                          }

                        },
                        icon: const Icon(
                          Icons.copy,
                          color: primaryColor,
                          size: 18,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),

            const SizedBox(height: 14),

            Row(
              children: [

                const Expanded(
                  child: Text(
                    'Status',
                    style: TextStyle(
                      color: Colors.black54,
                    ),
                  ),
                ),

                Container(
                  padding:
                      const EdgeInsets.symmetric(
                    horizontal: 12,
                    vertical: 6,
                  ),
                  decoration: BoxDecoration(
                    color:
                        Colors.orange.shade100,
                    borderRadius:
                        BorderRadius.circular(20),
                  ),
                  child: Text(
                    'Pending',
                    style: TextStyle(
                      color:
                          Colors.orange.shade800,
                      fontWeight:
                          FontWeight.bold,
                    ),
                  ),
                ),
              ],
            ),

            const SizedBox(height: 20),

            // INSTRUCTION CARD
            Container(
              padding: const EdgeInsets.all(16),

              decoration: BoxDecoration(
                color: primaryColor.withAlpha(13), // 0.05 * 255
                borderRadius: BorderRadius.circular(12),
                border: const Border(
                  left: BorderSide(
                    color: primaryColor,
                    width: 4,
                  ),
                ),
              ),

              child: Column(
                crossAxisAlignment:
                    CrossAxisAlignment.start,
                children: [
                  const Row(
                    children: [
                      Icon(
                        Icons.info,
                        color: primaryColor,
                        size: 18,
                      ),
                      SizedBox(width: 6),
                      Text(
                        'Instruksi Selanjutnya',
                        style: TextStyle(
                          color: primaryColor,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),

                  const SizedBox(height: 16),

                  Container(
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: const Color(0xFFFFF3CD),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: const Column(
                      crossAxisAlignment:
                          CrossAxisAlignment.start,
                      children: [

                        Text(
                          "Informasi",
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: primaryColor,
                          ),
                        ),

                        SizedBox(height: 8),

                        Text(
                          "Permintaan penarikan akan diverifikasi oleh admin dalam waktu maksimal 1x24 jam.",
                        ),
                      ],
                    ),
                  ),

                  const SizedBox(height: 16),

                  _stepItem(
                    '1',
                    'Kunjungi Kantor Koperasi Desa terdekat.',
                  ),

                  const SizedBox(height: 12),

                  _stepItem(
                    '2',
                    'Bawa KTP asli dan tunjukkan ID Transaksi di atas.',
                  ),

                  const SizedBox(height: 12),

                  _stepItem(
                    '3',
                    'Jam operasional: Senin - Jumat, 08:00 - 16:00.',
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  static Widget _detailRow(
    String title,
    String value,
  ) {
    return Row(
      children: [
        Expanded(
          child: Text(
            title,
            style: const TextStyle(
              color: Colors.black54,
            ),
          ),
        ),
        Text(
          value,
          style: const TextStyle(
            fontWeight: FontWeight.w600,
          ),
        ),
      ],
    );
  }

  static Widget _stepItem(
    String number,
    String text,
  ) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          width: 24,
          height: 24,
          alignment: Alignment.center,
          decoration: const BoxDecoration(
            color: primaryColor,
            shape: BoxShape.circle,
          ),
          child: Text(
            number,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 11,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),

        const SizedBox(width: 10),

        Expanded(
          child: Text(
            text,
            style: const TextStyle(height: 1.5),
          ),
        ),
      ],
    );
  }
}