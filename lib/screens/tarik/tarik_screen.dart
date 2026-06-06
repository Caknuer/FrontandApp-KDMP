import 'package:flutter/material.dart';
import 'konfirmasi_penarikan_screen.dart';

class TarikSimpananScreen extends StatefulWidget {
  const TarikSimpananScreen({super.key});

  @override
  State<TarikSimpananScreen> createState() =>
      _TarikSimpananScreenState();
}

class _TarikSimpananScreenState
    extends State<TarikSimpananScreen> {
  static const Color primaryColor = Color(0xFFAF101A);

  String selectedSimpanan =
      'Simpanan Sukarela (Rp 750.000)';

  final TextEditingController nominalController =
      TextEditingController();

  final TextEditingController keteranganController =
      TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFFCF9F8),

      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: .5,
        leading: IconButton(
          icon: const Icon(
            Icons.arrow_back,
            color: primaryColor,
          ),
          onPressed: () => Navigator.pop(context),
        ),
        title: const Text(
          'Tarik Simpanan',
          style: TextStyle(
            color: primaryColor,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),

      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(16),
        child: SizedBox(
          height: 54,
          child: ElevatedButton.icon(
            style: ElevatedButton.styleFrom(
              backgroundColor: primaryColor,
              foregroundColor: Colors.white,
              shape: RoundedRectangleBorder(
                borderRadius:
                    BorderRadius.circular(12),
              ),
            ),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) =>
                      const KonfirmasiPenarikanScreen(),
                ),
              );
            },
            icon: const Icon(
              Icons.check_circle,
            ),
            label: const Text(
              "Selesai",
            ),
          ),
        ),
      ),

      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),

        child: Column(
          crossAxisAlignment:
              CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 8),

            // JENIS SIMPANAN
            const Text(
              "Jenis Simpanan",
              style: TextStyle(
                fontWeight: FontWeight.w600,
                color: Colors.black54,
              ),
            ),

            const SizedBox(height: 8),

            DropdownButtonFormField<String>(
              initialValue: selectedSimpanan,
              decoration: InputDecoration(
                filled: true,
                fillColor:
                    const Color(0xFFF6F3F2),
                border: OutlineInputBorder(
                  borderRadius:
                      BorderRadius.circular(12),
                ),
              ),
              items: const [
                DropdownMenuItem(
                  value:
                      'Simpanan Sukarela (Rp 750.000)',
                  child: Text(
                    'Simpanan Sukarela (Rp 750.000)',
                  ),
                ),
                DropdownMenuItem(
                  value:
                      'Simpanan Pokok (Rp 500.000)',
                  child: Text(
                    'Simpanan Pokok (Rp 500.000)',
                  ),
                ),
                DropdownMenuItem(
                  value:
                      'Simpanan khusus (Rp 1.200.000)',
                  child: Text(
                    'Simpanan khusus (Rp 1.200.000)',
                  ),
                ),
              ],
              onChanged: (value) {
                setState(() {
                  selectedSimpanan =
                      value ?? selectedSimpanan;
                });
              },
            ),

            const SizedBox(height: 20),

            // NOMINAL
            Container(
              padding: const EdgeInsets.all(24),
              decoration: BoxDecoration(
                color: primaryColor,
                borderRadius:
                    BorderRadius.circular(20),
              ),
              child: Column(
                crossAxisAlignment:
                    CrossAxisAlignment.start,
                children: [
                  const Text(
                    "Nominal Penarikan",
                    style: TextStyle(
                      color: Colors.white70,
                    ),
                  ),

                  const SizedBox(height: 16),

                  TextField(
                    controller: nominalController,
                    keyboardType:
                        TextInputType.number,
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 30,
                      fontWeight: FontWeight.bold,
                    ),
                    decoration:
                        const InputDecoration(
                      prefixText: "Rp ",
                      prefixStyle: TextStyle(
                        color: Colors.white,
                        fontSize: 30,
                        fontWeight:
                            FontWeight.bold,
                      ),
                      border: InputBorder.none,
                      hintText: "0",
                      hintStyle: TextStyle(
                        color: Colors.white54,
                      ),
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 8),

            const Padding(
              padding: EdgeInsets.only(left: 4),
              child: Text(
                "Minimal penarikan Rp 10.000",
                style: TextStyle(
                  fontSize: 12,
                  color: Colors.grey,
                ),
              ),
            ),

            const SizedBox(height: 20),

            // KETERANGAN
            const Text(
              "Keterangan (Opsional)",
              style: TextStyle(
                fontWeight: FontWeight.w600,
                color: Colors.black54,
              ),
            ),

            const SizedBox(height: 8),

            TextField(
              controller: keteranganController,
              maxLines: 3,
              decoration: InputDecoration(
                hintText:
                    "Tujuan penarikan...",
                filled: true,
                fillColor:
                    const Color(0xFFF6F3F2),
                border: OutlineInputBorder(
                  borderRadius:
                      BorderRadius.circular(12),
                ),
              ),
            ),

            const SizedBox(height: 24),

            // RINCIAN SALDO
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius:
                    BorderRadius.circular(16),
                border: Border.all(
                  color:
                      const Color(0xFFE4BEBA),
                ),
              ),
              child: Column(
                children: [
                  const Row(
                    children: [
                      Icon(
                        Icons
                            .account_balance_wallet,
                        color: primaryColor,
                      ),
                      SizedBox(width: 8),
                      Text(
                        "Rincian Saldo",
                        style: TextStyle(
                          fontWeight:
                              FontWeight.bold,
                          fontSize: 18,
                        ),
                      ),
                    ],
                  ),

                  const Divider(height: 24),

                  _saldoItem(
                    "Simpanan Pokok",
                    "Rp 500.000",
                  ),

                  _saldoItem(
                    "Simpanan Wajib",
                    "Rp 1.200.000",
                  ),

                  _saldoItem(
                    "Simpanan Sukarela",
                    "Rp 750.000",
                    valueColor: primaryColor,
                  ),

                  const Divider(
                    height: 24,
                    thickness: 1,
                  ),

                  const Row(
                    children: [
                      Expanded(
                        child: Text(
                          "Total Saldo Tersedia",
                          style: TextStyle(
                            fontWeight:
                                FontWeight.bold,
                          ),
                        ),
                      ),
                      Text(
                        "Rp 2.450.000",
                        style: TextStyle(
                          color: primaryColor,
                          fontWeight:
                              FontWeight.bold,
                          fontSize: 20,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),

            const SizedBox(height: 16),

            // INFO
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color:
                    const Color(0xFFF6F3F2),
                borderRadius:
                    BorderRadius.circular(16),
                border: Border.all(
                  color:
                      const Color(0xFFE4BEBA),
                ),
              ),
              child: const Column(
                crossAxisAlignment:
                    CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Icon(
                        Icons.info,
                        color: primaryColor,
                      ),
                      SizedBox(width: 8),
                      Text(
                        "Instruksi Penarikan",
                        style: TextStyle(
                          color: primaryColor,
                          fontWeight:
                              FontWeight.bold,
                        ),
                      ),
                    ],
                  ),

                  SizedBox(height: 12),

                  Text(
                    "Silakan kunjungi kantor koperasi pada jam operasional (Senin - Jumat, 08:00 - 16:00) untuk melakukan penarikan tunai setelah menekan tombol di bawah.",
                    style: TextStyle(
                      color: Colors.black54,
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 100),
          ],
        ),
      ),
    );
  }

  Widget _saldoItem(
    String title,
    String value, {
    Color valueColor = Colors.black,
  }) {
    return Padding(
      padding:
          const EdgeInsets.symmetric(vertical: 8),
      child: Row(
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
            style: TextStyle(
              color: valueColor,
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      ),
    );
  }
}