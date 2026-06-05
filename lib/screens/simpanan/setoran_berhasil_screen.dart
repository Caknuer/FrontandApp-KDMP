import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class SetoranBerhasilScreen extends StatelessWidget {
  const SetoranBerhasilScreen({super.key});

  static const Color primaryColor = Color(0xFFAF101A);

  void copyTransactionId(BuildContext context) {
    Clipboard.setData(
      const ClipboardData(
        text: 'TRX-20231024-0091',
      ),
    );

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('ID transaksi berhasil disalin'),
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
          'Notifikasi',
          style: TextStyle(
            color: Colors.black87,
            fontWeight: FontWeight.bold,
          ),
        ),

        actions: const [
          Padding(
            padding: EdgeInsets.only(right: 8),
            child: Icon(
              Icons.done_all,
              color: primaryColor,
            ),
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
                                color: primaryColor
                                    .withAlpha(50),
                                shape: BoxShape.circle,
                              ),

                              child: Container(
                                width: 80,
                                height: 80,

                                decoration:
                                    const BoxDecoration(
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

                            const SizedBox(height: 20),

                            const Text(
                              'Setoran Berhasil',
                              style: TextStyle(
                                fontSize: 28,
                                fontWeight:
                                    FontWeight.bold,
                              ),
                            ),

                            const SizedBox(height: 8),

                            const Text(
                              'Dana Anda telah berhasil ditambahkan ke saldo.',
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                color: Colors.grey,
                              ),
                            ),
                          ],
                        ),

                        const SizedBox(height: 24),

                        // NOMINAL
                        Container(
                          width: double.infinity,
                          padding:
                              const EdgeInsets.symmetric(
                            vertical: 20,
                            horizontal: 16,
                          ),

                          decoration: BoxDecoration(
                            color: const Color(
                              0xffF6F3F2,
                            ),
                            borderRadius:
                                BorderRadius.circular(16),
                          ),

                          child: const Column(
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
                                'Rp 500.000',
                                style: TextStyle(
                                  color: primaryColor,
                                  fontSize: 32,
                                  fontWeight:
                                      FontWeight.bold,
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
                            borderRadius:
                                BorderRadius.circular(16),
                            border: Border.all(
                              color: const Color(
                                0xffE4BEBA,
                              ),
                            ),
                          ),

                          child: Column(
                            children: [
                              Row(
                                children: [
                                  const Expanded(
                                    child: Text(
                                      'Rincian Transaksi',
                                      style: TextStyle(
                                        fontWeight:
                                            FontWeight
                                                .bold,
                                      ),
                                    ),
                                  ),

                                  Container(
                                    padding:
                                        const EdgeInsets
                                            .symmetric(
                                      horizontal: 10,
                                      vertical: 4,
                                    ),

                                    decoration:
                                        BoxDecoration(
                                      color: Colors
                                          .green.shade100,
                                      borderRadius:
                                          BorderRadius
                                              .circular(
                                        20,
                                      ),
                                    ),

                                    child: const Row(
                                      mainAxisSize:
                                          MainAxisSize
                                              .min,
                                      children: [
                                        Icon(
                                          Icons.verified,
                                          size: 14,
                                          color:
                                              Colors
                                                  .green,
                                        ),

                                        SizedBox(
                                            width: 4),

                                        Text(
                                          'Berhasil',
                                          style:
                                              TextStyle(
                                            fontSize:
                                                11,
                                            color: Colors
                                                .green,
                                            fontWeight:
                                                FontWeight
                                                    .bold,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),

                              const Divider(
                                height: 24,
                              ),

                              _detailRow(
                                'Jenis Transaksi',
                                'Simpanan Sukarela',
                              ),

                              _detailRow(
                                'Tanggal & Waktu',
                                '24 Okt 2023, 14:30 WIB',
                              ),

                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment
                                        .spaceBetween,

                                crossAxisAlignment:
                                    CrossAxisAlignment
                                        .start,

                                children: [
                                  const Text(
                                    'ID Transaksi',
                                    style: TextStyle(
                                      color:
                                          Colors.grey,
                                    ),
                                  ),

                                  Row(
                                    children: [
                                      const Text(
                                        'TRX-20231024-0091',
                                        style:
                                            TextStyle(
                                          fontWeight:
                                              FontWeight
                                                  .w600,
                                        ),
                                      ),

                                      IconButton(
                                        onPressed: () =>
                                            copyTransactionId(
                                          context,
                                        ),

                                        icon:
                                            const Icon(
                                          Icons.copy,
                                          size: 18,
                                          color:
                                              primaryColor,
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),

                              _detailRow(
                                'Sumber Dana',
                                'Transfer Bank BCA',
                              ),

                              const SizedBox(
                                height: 16,
                              ),

                              // BONUS CARD
                              Container(
                                padding:
                                    const EdgeInsets.all(
                                  12,
                                ),

                                decoration:
                                    BoxDecoration(
                                  color: const Color(
                                    0xffFFDAD6,
                                  ),
                                  borderRadius:
                                      BorderRadius
                                          .circular(
                                    12,
                                  ),
                                ),

                                child: const Row(
                                  children: [
                                    CircleAvatar(
                                      backgroundColor:
                                          Colors.white,
                                      child: Icon(
                                        Icons.redeem,
                                        color:
                                            primaryColor,
                                      ),
                                    ),

                                    SizedBox(
                                      width: 12,
                                    ),

                                    Expanded(
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment
                                                .start,

                                        children: [
                                          Text(
                                            'Koperasi Poin +50',
                                            style:
                                                TextStyle(
                                              fontWeight:
                                                  FontWeight
                                                      .bold,
                                            ),
                                          ),

                                          Text(
                                            'Terima kasih telah berkontribusi untuk desa.',
                                            style:
                                                TextStyle(
                                              fontSize:
                                                  12,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),

                                    Icon(
                                      Icons
                                          .chevron_right,
                                      color:
                                          Colors.grey,
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),

                        const SizedBox(height: 20),

                        const Padding(
                          padding:
                              EdgeInsets.symmetric(
                            horizontal: 12,
                          ),

                          child: Text(
                            '"Setoran Anda membantu pengembangan usaha mikro di lingkungan RW 04. Terima kasih atas partisipasi aktif Anda."',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              color: Colors.grey,
                              fontStyle:
                                  FontStyle.italic,
                            ),
                          ),
                        ),
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
                          onPressed: () {},

                          style:
                              ElevatedButton.styleFrom(
                            backgroundColor:
                                primaryColor,
                            shape:
                                RoundedRectangleBorder(
                              borderRadius:
                                  BorderRadius
                                      .circular(
                                12,
                              ),
                            ),
                          ),

                          icon: const Icon(
                            Icons
                                .account_balance_wallet,
                            color: Colors.white,
                          ),

                          label: const Text(
                            'Lihat Saldo',
                            style: TextStyle(
                              color: Colors.white,
                              fontWeight:
                                  FontWeight.bold,
                            ),
                          ),
                        ),
                      ),

                      const SizedBox(height: 12),

                      SizedBox(
                        width: double.infinity,
                        height: 56,

                        child: OutlinedButton(
                          onPressed: () {},

                          style:
                              OutlinedButton.styleFrom(
                            side: const BorderSide(
                              color: Color(
                                0xffE4BEBA,
                              ),
                            ),

                            shape:
                                RoundedRectangleBorder(
                              borderRadius:
                                  BorderRadius
                                      .circular(
                                12,
                              ),
                            ),
                          ),

                          child: const Text(
                            'Unduh Resi',
                            style: TextStyle(
                              color: primaryColor,
                              fontWeight:
                                  FontWeight.bold,
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

  static Widget _detailRow(
    String title,
    String value,
  ) {
    return Padding(
      padding: const EdgeInsets.only(
        bottom: 14,
      ),

      child: Row(
        mainAxisAlignment:
            MainAxisAlignment.spaceBetween,

        crossAxisAlignment:
            CrossAxisAlignment.start,

        children: [
          Text(
            title,
            style: const TextStyle(
              color: Colors.grey,
            ),
          ),

          Flexible(
            child: Text(
              value,
              textAlign: TextAlign.end,
              style: const TextStyle(
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        ],
      ),
    );
  }
}