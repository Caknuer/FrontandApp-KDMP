import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'konfirmasi_penarikan_screen.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:firebase_auth/firebase_auth.dart';
import '../../config/api_config.dart';
import '../../services/penarikan_service.dart';

class TarikSimpananScreen extends StatefulWidget {
  const TarikSimpananScreen({super.key});

  @override
  State<TarikSimpananScreen> createState() =>
      _TarikSimpananScreenState();
}

class _TarikSimpananScreenState
    extends State<TarikSimpananScreen> {

  static const Color primaryColor =
      Color(0xFFAF101A);

  final TextEditingController nominalController =
      TextEditingController();

  final TextEditingController keteranganController =
      TextEditingController();

  Map<String, dynamic>? saldoData;

  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    loadSaldo();
  }

  Future<void> loadSaldo() async {

    try {

      final user =
          FirebaseAuth.instance.currentUser;

      if (user == null) {
        return;
      }

      final token =
          await user.getIdToken();

      final profileResponse =
          await http.get(
        Uri.parse(
          "${ApiConfig.baseUrl}/auth/profile",
        ),
        headers: {
          "Authorization":
              "Bearer $token",
        },
      );

      if (profileResponse.statusCode != 200) {
        return;
      }

      final profile =
          jsonDecode(profileResponse.body);

      final userId =
          profile["data"]["id"];

      final saldoResponse =
          await http.get(
        Uri.parse(
          "${ApiConfig.baseUrl}/saldo/$userId",
        ),
      );

      if (saldoResponse.statusCode == 200) {

        final result =
            jsonDecode(
              saldoResponse.body,
            );

        setState(() {
          saldoData =
              result["data"];
          isLoading = false;
        });

      }

    } catch (e) {

      print(e);

    }

  }

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

    if (isLoading) {
      return const Scaffold(
        body: Center(
          child:
              CircularProgressIndicator(),
        ),
      );
    }

    final saldoSukarela =
        saldoData?["simpanan_sukarela"] ?? 0;

    return Scaffold(
      backgroundColor:
          const Color(0xFFFCF9F8),

      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: .5,
        leading: IconButton(
          icon: const Icon(
            Icons.arrow_back,
            color: primaryColor,
          ),
          onPressed: () =>
              Navigator.pop(context),
        ),
        title: const Text(
          'Tarik Simpanan',
          style: TextStyle(
            color: primaryColor,
            fontWeight:
                FontWeight.bold,
          ),
        ),
      ),

      bottomNavigationBar: Padding(
        padding:
            const EdgeInsets.all(16),
        child: SizedBox(
          height: 54,
          child: ElevatedButton.icon(
            style:
                ElevatedButton.styleFrom(
              backgroundColor:
                  primaryColor,
              foregroundColor:
                  Colors.white,
              shape:
                  RoundedRectangleBorder(
                borderRadius:
                    BorderRadius.circular(
                  12,
                ),
              ),
            ),

            onPressed: () async {

              final nominal =
                  int.tryParse(
                        nominalController.text
                            .replaceAll(
                              ".",
                              "",
                            )
                            .replaceAll(
                              ",",
                              "",
                            ),
                      ) ??
                      0;

              if (nominal < 10000) {

                ScaffoldMessenger.of(
                        context)
                    .showSnackBar(
                  const SnackBar(
                    content: Text(
                      "Minimal penarikan Rp 10.000",
                    ),
                  ),
                );

                return;
              }

              if (nominal >
                  saldoSukarela) {

                ScaffoldMessenger.of(
                        context)
                    .showSnackBar(
                  const SnackBar(
                    content: Text(
                      "Saldo sukarela tidak mencukupi",
                    ),
                  ),
                );

                return;
              }

              final transaksi =
                  await PenarikanService.create(
                nominal: nominal.toString(),
                keterangan:
                    keteranganController.text,
              );

              if (transaksi == null) {

                if (!context.mounted) return;

                ScaffoldMessenger.of(context)
                    .showSnackBar(
                  const SnackBar(
                    content: Text(
                      "Gagal membuat penarikan",
                    ),
                  ),
                );

                return;
              }

              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) =>
                      KonfirmasiPenarikanScreen(
                    nominal: nominal.toString(),
                    keterangan:
                        keteranganController.text,
                    transaksiId:
                        transaksi["id"],
                  ),
                ),
              );
            },
            icon: const Icon(
              Icons.check_circle,
            ),
            label: const Text(
              "Lanjutkan",
            ),
          ),
        ),
      ),

      body: SingleChildScrollView(
        padding:
            const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment:
              CrossAxisAlignment.start,
          children: [

            Container(
              width: double.infinity,
              padding:
                  const EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: primaryColor,
                borderRadius:
                    BorderRadius.circular(
                  20,
                ),
              ),
              child: Column(
                crossAxisAlignment:
                    CrossAxisAlignment.start,
                children: [

                  const Text(
                    "Saldo Sukarela Tersedia",
                    style: TextStyle(
                      color:
                          Colors.white70,
                    ),
                  ),

                  const SizedBox(
                    height: 10,
                  ),

                  Text(
                    "Rp ${formatRupiah(
                      saldoSukarela
                          .toString(),
                    )}",
                    style:
                        const TextStyle(
                      color:
                          Colors.white,
                      fontSize: 28,
                      fontWeight:
                          FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(
              height: 24,
            ),

            const Text(
              "Nominal Penarikan",
              style: TextStyle(
                fontWeight:
                    FontWeight.w600,
              ),
            ),

            const SizedBox(
              height: 8,
            ),

            TextField(
              controller:
                  nominalController,
              keyboardType:
                  TextInputType.number,
              decoration:
                  InputDecoration(
                hintText:
                    "Masukkan nominal",
                prefixText: "Rp ",
                filled: true,
                fillColor:
                    const Color(
                  0xFFF6F3F2,
                ),
                border:
                    OutlineInputBorder(
                  borderRadius:
                      BorderRadius
                          .circular(
                    12,
                  ),
                ),
              ),
            ),

            const SizedBox(
              height: 6,
            ),

            const Text(
              "Minimal penarikan Rp 10.000",
              style: TextStyle(
                color: Colors.grey,
                fontSize: 12,
              ),
            ),

            const SizedBox(
              height: 20,
            ),

            const Text(
              "Keterangan (Opsional)",
              style: TextStyle(
                fontWeight:
                    FontWeight.w600,
              ),
            ),

            const SizedBox(
              height: 8,
            ),

            TextField(
              controller:
                  keteranganController,
              maxLines: 3,
              decoration:
                  InputDecoration(
                hintText:
                    "Tujuan penarikan...",
                filled: true,
                fillColor:
                    const Color(
                  0xFFF6F3F2,
                ),
                border:
                    OutlineInputBorder(
                  borderRadius:
                      BorderRadius
                          .circular(
                    12,
                  ),
                ),
              ),
            ),

            const SizedBox(
              height: 24,
            ),

            Container(
              padding:
                  const EdgeInsets.all(
                16,
              ),
              decoration:
                  BoxDecoration(
                color: Colors.white,
                borderRadius:
                    BorderRadius.circular(
                  16,
                ),
                border: Border.all(
                  color:
                      const Color(
                    0xFFE4BEBA,
                  ),
                ),
              ),
              child: Column(
                children: [

                  _saldoItem(
                    "Simpanan Pokok",
                    "Rp ${formatRupiah(
                      saldoData?[
                                  "simpanan_pokok"]
                              ?.toString() ??
                          "0",
                    )}",
                  ),

                  _saldoItem(
                    "Simpanan Wajib",
                    "Rp ${formatRupiah(
                      saldoData?[
                                  "simpanan_wajib"]
                              ?.toString() ??
                          "0",
                    )}",
                  ),

                  _saldoItem(
                    "Simpanan Sukarela",
                    "Rp ${formatRupiah(
                      saldoData?[
                                  "simpanan_sukarela"]
                              ?.toString() ??
                          "0",
                    )}",
                    valueColor:
                        primaryColor,
                  ),
                ],
              ),
            ),

            const SizedBox(
              height: 20,
            ),

            Container(
              padding:
                  const EdgeInsets.all(
                16,
              ),
              decoration:
                  BoxDecoration(
                color:
                    const Color(
                  0xFFF6F3F2,
                ),
                borderRadius:
                    BorderRadius.circular(
                  16,
                ),
              ),
              child: const Column(
                crossAxisAlignment:
                    CrossAxisAlignment
                        .start,
                children: [

                  Row(
                    children: [
                      Icon(
                        Icons.info,
                        color:
                            primaryColor,
                      ),
                      SizedBox(
                        width: 8,
                      ),
                      Text(
                        "Informasi",
                        style:
                            TextStyle(
                          color:
                              primaryColor,
                          fontWeight:
                              FontWeight
                                  .bold,
                        ),
                      ),
                    ],
                  ),

                  SizedBox(
                    height: 10,
                  ),

                  Text(
                    "Penarikan hanya dapat dilakukan dari Simpanan Sukarela dan akan diverifikasi oleh admin koperasi.",
                  ),
                ],
              ),
            ),

            const SizedBox(
              height: 100,
            ),
          ],
        ),
      ),
    );
  }

  Widget _saldoItem(
    String title,
    String value, {
    Color valueColor =
        Colors.black,
  }) {
    return Padding(
      padding:
          const EdgeInsets.symmetric(
        vertical: 8,
      ),
      child: Row(
        children: [
          Expanded(
            child: Text(title),
          ),
          Text(
            value,
            style: TextStyle(
              color: valueColor,
              fontWeight:
                  FontWeight.w600,
            ),
          ),
        ],
      ),
    );
  }
}