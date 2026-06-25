import 'dart:convert';
import 'package:http/http.dart' as http;

import '../config/api_config.dart';
import 'auth_service.dart';

class SimpananService {

  static Future<bool> create({
    required String jenis,
    required String nominal,
    required String keterangan,
  }) async {

    try {

      final userId =
          AuthService.currentUser?["id"];

      if (userId == null) {
        return false;
      }

      final response =
          await http.post(
        Uri.parse(
          "${ApiConfig.baseUrl}/simpanan",
        ),
        headers: {
          "Content-Type":
              "application/json",
        },
        body: jsonEncode({
          "user_id": userId,
          "jenis_simpanan": jenis,
          "nominal":
              int.parse(nominal),
          "keterangan":
              keterangan,
        }),
      );

      print(response.body);

      return response.statusCode == 201;

    } catch (e) {

      print(e);

      return false;

    }

  }

}