import 'dart:convert';
import 'package:http/http.dart' as http;

import '../config/api_config.dart';
import 'auth_service.dart';

class TransaksiSetoranService {

  static Future<Map<String, dynamic>?> create({
    required String jenis,
    required String nominal,
    required String keterangan,
    required String metodePembayaran,
    String buktiPembayaran = "",
  }) async {

    try {

      final user = AuthService.currentUser;

      print("========== TRANSAKSI SETORAN ==========");
      print("CURRENT USER:");
      print(user);

      if (user == null) {

        print("ERROR: CURRENT USER NULL");

        return null;
      }

      print("USER ID: ${user["id"]}");

      final body = {
        "user_id": user["id"],
        "jenis_simpanan": jenis,
        "nominal": int.tryParse(
              nominal.replaceAll(",", ""),
            ) ??
            0,
        "metode_pembayaran": metodePembayaran,
        "bukti_pembayaran": buktiPembayaran,
        "keterangan": keterangan,
      };

      print("BODY KIRIM:");
      print(jsonEncode(body));

      final response = await http.post(
        Uri.parse(
          "${ApiConfig.baseUrl}/transaksi-setoran",
        ),
        headers: {
          "Content-Type": "application/json",
        },
        body: jsonEncode(body),
      );

      print(
        "SETORAN STATUS : ${response.statusCode}",
      );

      print(
        "SETORAN BODY : ${response.body}",
      );

      if (response.statusCode == 201) {

        final result =
            jsonDecode(response.body);

        return result["data"];
      }

      return null;

    } catch (e) {

      print(
        "SETORAN ERROR : $e",
      );

      return null;

    }

  }

  static Future<List<dynamic>> getByUser() async {

    try {

      final user =
          AuthService.currentUser;

      if (user == null) {

        print("CURRENT USER NULL");

        return [];
      }

      final response = await http.get(
        Uri.parse(
          "${ApiConfig.baseUrl}/transaksi-setoran/user/${user["id"]}",
        ),
      );

      print(
        "GET RIWAYAT STATUS : ${response.statusCode}",
      );

      print(
        "GET RIWAYAT BODY : ${response.body}",
      );

      final result =
          jsonDecode(response.body);

      if (response.statusCode == 200) {

        return result["data"];

      }

      return [];

    } catch (e) {

      print(
        "GET SETORAN ERROR : $e",
      );

      return [];

    }

  }

}