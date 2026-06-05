import 'package:flutter/material.dart';
import 'konfirmasi_setoran_screen.dart';

class SetorSimpananPage extends StatefulWidget {
  const SetorSimpananPage({super.key});

  @override
  State<SetorSimpananPage> createState() => _SetorSimpananPageState();
}

class _SetorSimpananPageState extends State<SetorSimpananPage> {
  final TextEditingController amountController = TextEditingController();
  final TextEditingController noteController = TextEditingController();

  bool sudahBayarPokok = true;

  late List<String> jenisSimpanan;
  String selectedJenis = '';

  @override
  void initState() {
    super.initState();

    jenisSimpanan = [
      if (!sudahBayarPokok) 'Simpanan Pokok',
      'Simpanan Wajib',
      'Simpanan Sukarela',
      'Simpanan Khusus',
    ];

    selectedJenis = jenisSimpanan.first;
  }

  @override
  void dispose() {
    amountController.dispose();
    noteController.dispose();
    super.dispose();
  }

  String getKeteranganJenis() {
    switch (selectedJenis) {
      case 'Simpanan Pokok':
        return 'Simpanan pokok hanya dibayarkan satu kali saat menjadi anggota.';
      case 'Simpanan Wajib':
        return 'Simpanan wajib dibayarkan setiap bulan.';
      case 'Simpanan Sukarela':
        return 'Simpanan sukarela dapat disetor kapan saja.';
      case 'Simpanan Khusus':
        return 'Simpanan khusus dapat disetor kapan saja sesuai kebutuhan.';
      default:
        return '';
    }
  }

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;

    return Scaffold(
      resizeToAvoidBottomInset: true,
      backgroundColor: const Color(0xFFFCF9F8),

      appBar: AppBar(
        backgroundColor: const Color(0xFFFCF9F8),
        elevation: 0,
        leading: IconButton(
          icon: const Icon(
            Icons.arrow_back,
            color: Color(0xFFAF101A),
          ),
          onPressed: () => Navigator.pop(context),
        ),
        title: const Text(
          'Setor Simpanan',
          style: TextStyle(
            color: Color(0xFFAF101A),
            fontWeight: FontWeight.bold,
          ),
        ),
      ),

      body: SafeArea(
        child: Stack(
          children: [
            SingleChildScrollView(
              padding: const EdgeInsets.fromLTRB(
                16,
                24,
                16,
                160,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [

                  // JENIS SIMPANAN

                  const Text(
                    'Pilih Jenis Simpanan',
                    style: TextStyle(
                      fontWeight: FontWeight.w600,
                      color: Color(0xFF5B403D),
                    ),
                  ),

                  const SizedBox(height: 12),

                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(16),
                      border: Border.all(
                        color: const Color(0xFFE4BEBA),
                      ),
                    ),
                    child: DropdownButtonHideUnderline(
                      child: DropdownButton<String>(
                        value: selectedJenis,
                        isExpanded: true,
                        items: jenisSimpanan.map((item) {
                          return DropdownMenuItem(
                            value: item,
                            child: Text(item),
                          );
                        }).toList(),
                        onChanged: (value) {
                          setState(() {
                            selectedJenis = value!;
                          });
                        },
                      ),
                    ),
                  ),

                  const SizedBox(height: 8),

                  Container(
                    width: double.infinity,
                    padding: const EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      color: const Color(0xFFF6F3F2),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Text(
                      getKeteranganJenis(),
                      style: const TextStyle(
                        fontSize: 13,
                        color: Color(0xFF5B403D),
                      ),
                    ),
                  ),

                  const SizedBox(height: 24),

                  // NOMINAL

                  Container(
                    width: double.infinity,
                    padding: const EdgeInsets.all(24),
                    decoration: BoxDecoration(
                      color: const Color(0xFFD32F2F),
                      borderRadius: BorderRadius.circular(24),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          'Nominal Setoran',
                          style: TextStyle(
                            color: Colors.white70,
                            fontWeight: FontWeight.w600,
                          ),
                        ),

                        const SizedBox(height: 20),

                        Row(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            Text(
                              'Rp',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: width * 0.07,
                                fontWeight: FontWeight.bold,
                              ),
                            ),

                            const SizedBox(width: 8),

                            Expanded(
                              child: TextField(
                                controller: amountController,
                                keyboardType: TextInputType.number,
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: width * 0.07,
                                  fontWeight: FontWeight.bold,
                                ),
                                decoration: const InputDecoration(
                                  hintText: '0',
                                  hintStyle: TextStyle(
                                    color: Colors.white54,
                                  ),
                                  border: UnderlineInputBorder(
                                    borderSide: BorderSide(
                                      color: Colors.white30,
                                    ),
                                  ),
                                  enabledBorder: UnderlineInputBorder(
                                    borderSide: BorderSide(
                                      color: Colors.white30,
                                    ),
                                  ),
                                  focusedBorder: UnderlineInputBorder(
                                    borderSide: BorderSide(
                                      color: Colors.white,
                                      width: 2,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),

                  const SizedBox(height: 8),

                  const Padding(
                    padding: EdgeInsets.only(left: 4),
                    child: Text(
                      'Minimal setoran Rp 10.000',
                      style: TextStyle(
                        fontSize: 12,
                        color: Colors.grey,
                      ),
                    ),
                  ),

                  const SizedBox(height: 24),

                  // KETERANGAN

                  const Text(
                    'Keterangan (Opsional)',
                    style: TextStyle(
                      fontWeight: FontWeight.w600,
                      color: Color(0xFF5B403D),
                    ),
                  ),

                  const SizedBox(height: 12),

                  TextField(
                    controller: noteController,
                    maxLines: 3,
                    decoration: InputDecoration(
                      hintText: 'Tambah catatan di sini...',
                      filled: true,
                      fillColor: const Color(0xFFF6F3F2),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(16),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(16),
                        borderSide: const BorderSide(
                          color: Color(0xFFE4BEBA),
                        ),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(16),
                        borderSide: const BorderSide(
                          color: Color(0xFFAF101A),
                          width: 2,
                        ),
                      ),
                    ),
                  ),

                  const SizedBox(height: 24),

                  // RINCIAN

                  const Text(
                    'Rincian Simpanan',
                    style: TextStyle(
                      fontWeight: FontWeight.w600,
                      color: Color(0xFF5B403D),
                    ),
                  ),

                  const SizedBox(height: 12),

                  Container(
                    width: double.infinity,
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(24),
                      border: Border.all(
                        color: const Color(0xFFE4BEBA),
                      ),
                    ),
                    child: Column(
                      children: [

                        if (sudahBayarPokok)
                          buildSaldoRow(
                            'Simpanan Pokok',
                            'Rp 500.000',
                          ),

                        if (sudahBayarPokok)
                          const SizedBox(height: 12),

                        buildSaldoRow(
                          'Simpanan Wajib',
                          'Rp 1.200.000',
                        ),

                        const SizedBox(height: 12),

                        buildSaldoRow(
                          'Simpanan Sukarela',
                          'Rp 750.000',
                        ),

                        const SizedBox(height: 12),

                        buildSaldoRow(
                          'Simpanan Khusus',
                          'Rp 300.000',
                        ),

                        const Divider(height: 32),

                        const Row(
                          mainAxisAlignment:
                              MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              'Total Saldo',
                              style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            Text(
                              'Rp 2.750.000',
                              style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                                color: Color(0xFFAF101A),
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

            // BUTTON

            Positioned(
              left: 16,
              right: 16,
              bottom: 24,
              child: SizedBox(
                height: 56,
                child: ElevatedButton.icon(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFFAF101A),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16),
                    ),
                  ),
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const KonfirmasiSetoranScreen(),
                      ),
                    );
                  },

                  icon: const Icon(
                    Icons.arrow_forward,
                    color: Colors.white,
                  ),

                  label: const Text(
                    'Lanjutkan',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget buildSaldoRow(
    String title,
    String amount,
  ) {
    return Row(
      mainAxisAlignment:
          MainAxisAlignment.spaceBetween,
      children: [
        Text(
          title,
          style: const TextStyle(
            color: Color(0xFF5B403D),
          ),
        ),
        Text(
          amount,
          style: const TextStyle(
            fontWeight: FontWeight.w600,
          ),
        ),
      ],
    );
  }
}