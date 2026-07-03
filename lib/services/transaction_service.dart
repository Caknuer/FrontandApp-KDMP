import 'dart:convert';

import 'package:http/http.dart' as http;

import '../config/api_config.dart';

class TransactionService {

  // ===========================
  // DETAIL SETORAN
  // ===========================
  static Future<Map<String, dynamic>?> getSetoranById(
    String id,
  ) async {

    try {

      final response = await http.get(

        Uri.parse(
          "${ApiConfig.baseUrl}/transaksi-setoran/$id",
        ),

      );

      if (response.statusCode != 200) {

        return null;

      }

      final result =
          jsonDecode(response.body);

      return Map<String, dynamic>.from(
        result["data"],
      );

    } catch (e) {

      print(
        "DETAIL SETORAN ERROR : $e",
      );

      return null;

    }

  }

  // ===========================
  // DETAIL PENARIKAN
  // ===========================
  static Future<Map<String, dynamic>?> getPenarikanById(
    String id,
  ) async {

    try {

      final response = await http.get(

        Uri.parse(
          "${ApiConfig.baseUrl}/penarikan/$id",
        ),

      );

      if (response.statusCode != 200) {

        return null;

      }

      final result =
          jsonDecode(response.body);

      return Map<String, dynamic>.from(
        result["data"],
      );

    } catch (e) {

      print(
        "DETAIL PENARIKAN ERROR : $e",
      );

      return null;

    }

  }

}