import 'dart:async';
import 'package:flutter/material.dart';
import 'setoran_berhasil_screen.dart';
import 'dart:io';
import 'package:image_picker/image_picker.dart';
import '../../services/transaksi_setoran_service.dart';
import '../../services/upload_service.dart';
import 'package:intl/intl.dart';

class KonfirmasiSetoranScreen extends StatefulWidget {
  final String jenis;
  final String nominal;
  final String keterangan;
  final List<String> selectedTagihan;

  const KonfirmasiSetoranScreen({
    super.key,
    required this.jenis,
    required this.nominal,
    required this.keterangan,
    required this.selectedTagihan,
  });

  @override
  State<KonfirmasiSetoranScreen> createState() =>
      _KonfirmasiSetoranScreenState();
  }

class _KonfirmasiSetoranScreenState
    extends State<KonfirmasiSetoranScreen> {
  static const Color primaryColor = Color(0xFFAF101A);
  String metodePembayaran = "QRIS";
  File? buktiPembayaran;
  bool isLoading = false;

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

  String formatRupiah(String nominal) {
    final number =
        int.tryParse(nominal) ?? 0;

    return NumberFormat.currency(
      locale: 'id_ID',
      symbol: '',
      decimalDigits: 0,
    ).format(number);
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
          24,
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
                    widget.jenis,
                  ),

                  const SizedBox(height: 12),

                  _detailRow(
                    'Nominal Setoran',
                     'Rp ${formatRupiah(widget.nominal)}',
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

                  Align(
                    alignment: Alignment.centerLeft,
                    child: Text(                   
                      widget.keterangan.isEmpty
                          ? "-"
                          : widget.keterangan,
                      style: TextStyle(
                        fontStyle: FontStyle.italic,
                      ),
                    ),
                  ),
                ],
              ),
            ),

            const Divider(),

            const SizedBox(height: 8),

            Align(
              alignment: Alignment.centerLeft,
              child: Text(
                "Tagihan yang Dibayar",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),

            const SizedBox(height: 8),

            ...widget.selectedTagihan.map(
              (periode) => Padding(
                padding: const EdgeInsets.only(
                  bottom: 4,
                ),
                child: Row(
                  children: [
                    const Icon(
                      Icons.check_circle,
                      size: 18,
                      color: Colors.green,
                    ),
                    const SizedBox(width: 8),
                    Text(periode),
                  ],
                ),
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

            Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(16),
                border: Border.all(
                  color: const Color(0xffE4BEBA),
                ),
              ),
              child: Column(
                children: [
                  RadioListTile<String>(
                    value: "QRIS",
                    groupValue: metodePembayaran,
                    title: const Text("QRIS"),
                    subtitle: const Text(
                      "Upload bukti pembayaran"
                    ),
                    onChanged: (value) {
                      setState(() {
                        metodePembayaran = value!;
                      });
                    },
                  ),

                  RadioListTile<String>(
                    value: "Tunai",
                    groupValue: metodePembayaran,
                    title: const Text("Tunai"),
                    subtitle: const Text(
                      "Bayar di kantor koperasi"
                    ),
                    onChanged: (value) {
                      setState(() {
                        metodePembayaran = value!;
                      });
                    },
                  ),
                ],
              ),
            ),

            const SizedBox(height: 16),

            if (metodePembayaran == "QRIS")
              _buildCard(
                title: "Bayar via QRIS",
                icon: Icons.qr_code,
                child: Column(
                  children: [

                    Image.network(
                      "https://api.qrserver.com/v1/create-qr-code/?size=300x300&data=KOPERASI",
                      height: 220,
                    ),

                    const SizedBox(height: 16),

                    ElevatedButton.icon(
                      onPressed: () async {

                        final picker =
                            ImagePicker();

                        final image =
                            await picker.pickImage(
                          source:
                              ImageSource.gallery,
                          imageQuality: 70,
                        );

                        if (image != null) {
                          setState(() {
                            buktiPembayaran =
                                File(image.path);
                          });
                        }

                      },
                      icon: const Icon(
                        Icons.upload,
                      ),
                      label: const Text(
                        "Upload Bukti Pembayaran",
                      ),
                    ),

                    if (buktiPembayaran != null)
                      Container(
                        margin:
                            const EdgeInsets.only(
                          top: 16,
                        ),
                        child: ClipRRect(
                          borderRadius:
                              BorderRadius.circular(
                            12,
                          ),
                          child: Image.file(
                            buktiPembayaran!,
                            height: 220,
                          ),
                        ),
                      ),
                  ],
                ),
              ),

              if (metodePembayaran == "Tunai")
                _buildCard(
                  title: "Bayar Tunai",
                  icon: Icons.payments,
                  child: Column(
                    crossAxisAlignment:
                        CrossAxisAlignment.start,
                    children: [

                      const Text(
                        "Silakan datang ke kantor koperasi dan lakukan pembayaran kepada petugas.",
                      ),

                      const SizedBox(height: 12),

                      Container(
                        padding:
                            const EdgeInsets.all(12),
                        decoration: BoxDecoration(
                          color:
                              const Color(0xffF0EDED),
                          borderRadius:
                              BorderRadius.circular(
                            12,
                          ),
                        ),
                        child: const Text(
                          "Status akan diverifikasi oleh admin setelah pembayaran diterima.",
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
                            'Admin akan melakukan verifikasi dalam 1x24 jam setelah konfirmasi diterima.',
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

              const SizedBox(height: 24),

              SizedBox(
                width: double.infinity,
                height: 55,
                child: ElevatedButton(
                  onPressed: () async {

                    if (metodePembayaran == "QRIS" &&
                        buktiPembayaran == null) {

                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text(
                            "Upload bukti pembayaran terlebih dahulu",
                          ),
                        ),
                      );

                      return;
                    }

                    String buktiUrl = "";

                    if (metodePembayaran == "QRIS" &&
                        buktiPembayaran != null) {

                      final uploadedUrl =
                          await UploadService.uploadImage(
                        buktiPembayaran!,
                      );

                      if (uploadedUrl == null) {

                        if (!mounted) return;

                        ScaffoldMessenger.of(context)
                            .showSnackBar(
                          const SnackBar(
                            content: Text(
                              "Upload bukti gagal",
                            ),
                          ),
                        );

                        return;
                      }

                      buktiUrl = uploadedUrl;
                    }

                    final transaksi =
                        await TransaksiSetoranService.create(
                      jenis: widget.jenis,
                      nominal: widget.nominal,
                      keterangan: widget.keterangan,
                      metodePembayaran: metodePembayaran,
                      buktiPembayaran: buktiUrl,
                      periodeTagihan: widget.selectedTagihan,
                    );

                    if (transaksi == null) {

                      if (!mounted) return;

                      ScaffoldMessenger.of(context)
                          .showSnackBar(
                        const SnackBar(
                          content: Text(
                            "Gagal menyimpan transaksi",
                          ),
                        ),
                      );

                      return;
                    }

                    if (!mounted) return;

                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                        builder: (_) => SetoranBerhasilScreen(
                          nominal: widget.nominal,
                          jenis: widget.jenis,
                          metodePembayaran:
                              metodePembayaran,
                          transaksiId:
                              transaksi["id"],
                        ),
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

              const SizedBox(height: 24),
          ],
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
              Icon(
                icon,
                color: primaryColor,
              ),
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