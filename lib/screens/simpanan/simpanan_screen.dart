import 'package:flutter/material.dart';
import 'konfirmasi_setoran_screen.dart';
import '../../services/saldo_service.dart';
import 'package:intl/intl.dart';

class SetorSimpananPage extends StatefulWidget {
  const SetorSimpananPage({super.key});

  @override
  State<SetorSimpananPage> createState() => _SetorSimpananPageState();
}

class _SetorSimpananPageState extends State<SetorSimpananPage> {
  final TextEditingController amountController = TextEditingController();
  final TextEditingController noteController = TextEditingController();

  int jumlahBulan = 1;
  bool loading = true;
  Map<String, dynamic>? saldoData;
  bool loadingSaldo = true;
  bool sudahBayarPokok = true;

  late List<String> jenisSimpanan;
  String selectedJenis = '';

  String formatRupiah(String nominal) {
    final number = int.tryParse(nominal) ?? 0;

    return NumberFormat.currency(
      locale: 'id_ID',
      symbol: '',
      decimalDigits: 0,
    ).format(number);
  }

  @override
  void initState() {
    super.initState();

    jenisSimpanan = [
      if (!sudahBayarPokok) 'Simpanan Pokok',
      'Simpanan Wajib',
      'Simpanan Sukarela',
    ];

    selectedJenis = jenisSimpanan.first;

    setNominalDefault();

    loadSaldo();
  }

  Future<void> loadSaldo() async {
    try {
      final data = await SaldoService.getSaldo();

      setState(() {
        saldoData = data;
        loadingSaldo = false;
      });
    } catch (e) {
      setState(() {
        loadingSaldo = false;
      });
    }
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
        return "Simpanan pokok dibayarkan sekali saat menjadi anggota.";
      case 'Simpanan Wajib':
        return "Simpanan wajib bulan ini Rp 10.000.";
      case 'Simpanan Sukarela':
        return "Masukkan nominal sesuai kebutuhan Anda.";
      default:
        return '';
    }
  }

  void setNominalDefault() {
    if (selectedJenis == "Simpanan Pokok") {
      amountController.text = "100000";
    } else if (selectedJenis == "Simpanan Wajib") {
  amountController.text =
      (10000 * jumlahBulan).toString();
    } else {
      amountController.clear();
    }
  }

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;

    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: const Color(0xFFFCF9F8),

      appBar: AppBar(
        backgroundColor: const Color(0xFFFCF9F8),
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Color(0xFFAF101A)),
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
              padding: const EdgeInsets.fromLTRB(16, 24, 16, 160),
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
                      border: Border.all(color: const Color(0xFFE4BEBA)),
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
                            setNominalDefault();
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
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Icon(
                          Icons.info_outline,
                          size: 18,
                          color: Color(0xFFAF101A),
                        ),

                        const SizedBox(width: 8),

                        Expanded(
                          child: Text(
                            getKeteranganJenis(),
                            style: const TextStyle(
                              fontSize: 13,
                              color: Color(0xFF5B403D),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),

                  const SizedBox(height: 24),

                  if (selectedJenis == "Simpanan Wajib")
                    Column(
                      children: [

                        Container(
                          width: double.infinity,
                          padding: const EdgeInsets.all(16),
                          decoration: BoxDecoration(
                            color: const Color(0xFFFFF3CD),
                            borderRadius: BorderRadius.circular(16),
                            border: Border.all(
                              color: Colors.orange.shade300,
                            ),
                          ),
                          child: const Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                children: [
                                  Icon(
                                    Icons.warning_amber_rounded,
                                    color: Colors.orange,
                                  ),
                                  SizedBox(width: 8),
                                  Text(
                                    "Tagihan Simpanan Wajib",
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ],
                              ),
                              SizedBox(height: 8),
                              Text(
                                "Belum ada tunggakan",
                              ),
                            ],
                          ),
                        ),

                        const SizedBox(height: 16),

                        Container(
                          width: double.infinity,
                          padding: const EdgeInsets.all(16),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(16),
                            border: Border.all(
                              color: const Color(0xFFE4BEBA),
                            ),
                          ),
                          child: Column(
                            crossAxisAlignment:
                                CrossAxisAlignment.start,
                            children: [

                              const Text(
                                "Jumlah Bulan Pembayaran",
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: Color(0xFF5B403D),
                                ),
                              ),

                              const SizedBox(height: 12),

                              Row(
                                children: [
                                  IconButton(
                                    onPressed: () {
                                      if (jumlahBulan > 1) {
                                        setState(() {jumlahBulan--;
                                          amountController.text =
                                              (jumlahBulan * 10000).toString();
                                          }
                                        );
                                      }
                                    },
                                    icon: const Icon(
                                      Icons.remove_circle,
                                      color: Color(0xFFAF101A),
                                      size: 32,
                                    ),
                                  ),

                                  Expanded(
                                    child: Center(
                                      child: Column(
                                        children: [
                                          Text(
                                            "$jumlahBulan Bulan",
                                            style: const TextStyle(
                                              fontSize: 22,
                                              fontWeight:
                                                  FontWeight.bold,
                                              color:
                                                  Color(0xFFAF101A),
                                            ),
                                          ),

                                          const SizedBox(height: 4),

                                          Text(
                                            "Rp ${formatRupiah((jumlahBulan * 10000).toString())}",
                                            style: const TextStyle(
                                              color: Colors.grey,
                                            ),
                                          ),

                                        ],
                                      ),
                                    ),
                                  ),

                                  IconButton(
                                    onPressed: () {

                                      setState(() {

                                        jumlahBulan++;

                                        amountController.text =
                                            (jumlahBulan * 10000)
                                                .toString();

                                      });

                                    },
                                    icon: const Icon(
                                      Icons.add_circle,
                                      color: Color(0xFFAF101A),
                                      size: 25,
                                    ),
                                  ),

                                ],
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),

                  const SizedBox(height: 15),

                  // NOMINAL
                  Container(
                    width: double.infinity,
                    padding: const EdgeInsets.symmetric(
                      horizontal: 24,
                      vertical: 20,
                    ),
                    decoration: BoxDecoration(
                      color: const Color(0xFFD32F2F),
                      borderRadius: BorderRadius.circular(28),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.red.withAlpha(25),
                          blurRadius: 15,
                          offset: const Offset(0, 6),
                        ),
                      ],
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

                        if (selectedJenis == "Simpanan Wajib")
                          Center(
                            child: Text(
                              "Rp ${formatRupiah(amountController.text)}",
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: width * 0.10,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          )
                          else
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
                                readOnly: selectedJenis != "Simpanan Sukarela",
                                keyboardType: TextInputType.number,
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 38,
                                  fontWeight: FontWeight.w800,
                                ),
                                decoration: const InputDecoration(
                                  hintText: '0',
                                  hintStyle: TextStyle(color: Colors.white54),
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

                  const SizedBox(height: 12),

                  if (selectedJenis == "Simpanan Sukarela")
                    Wrap(
                      spacing: 8,
                      runSpacing: 8,
                      children: [
                        quickAmount("10000"),
                        quickAmount("25000"),
                        quickAmount("50000"),
                        quickAmount("100000"),
                        quickAmount("250000"),
                        quickAmount("500000"),
                      ],
                    ),

                  const SizedBox(height: 8),

                  const Padding(
                    padding: EdgeInsets.only(left: 4),
                    child: Text(
                      'Minimal setoran Rp 10.000',
                      style: TextStyle(fontSize: 12, color: Colors.grey),
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
                        borderSide: const BorderSide(color: Color(0xFFE4BEBA)),
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

                  const SizedBox(height: 12),

                  // BUTTON
                  SizedBox(
                    width: double.infinity,
                    height: 56,
                    child: ElevatedButton.icon(
                      style: ElevatedButton.styleFrom(
                        elevation: 8,
                        shadowColor: const Color(0xFFAF101A),
                        backgroundColor: const Color(0xFFAF101A),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(18),
                        ),
                      ),
                      onPressed: () {
                        if (amountController.text.isEmpty) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                              content: Text("Masukkan nominal setoran"),
                            ),
                          );
                          return;
                        }

                        if (int.tryParse(amountController.text) == null ||
                            int.parse(amountController.text) < 10000) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                              content: Text("Minimal setoran Rp 10.000"),
                            ),
                          );
                          return;
                        }

                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => KonfirmasiSetoranScreen(
                              jenis: selectedJenis,
                              nominal: amountController.text,
                              keterangan: noteController.text,
                            ),
                          ),
                        );
                      },

                      icon: const Icon(Icons.arrow_forward, color: Colors.white),

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
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget quickAmount(String nominal) {
    return InkWell(
      onTap: () {
        amountController.text = nominal;
        setState(() {});
      },
      borderRadius: BorderRadius.circular(14),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(14),
          border: Border.all(color: const Color(0xFFE4BEBA)),
        ),
        child: Text(
          "Rp ${int.parse(nominal) ~/ 1000}rb",
          style: const TextStyle(fontWeight: FontWeight.w600),
        ),
      ),
    );
  }

  Widget buildSaldoRow(String title, String amount) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(title, style: const TextStyle(color: Color(0xFF5B403D))),
        Text(amount, style: const TextStyle(fontWeight: FontWeight.w600)),
      ],
    );
  }
}
