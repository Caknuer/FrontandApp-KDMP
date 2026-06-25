import 'dart:convert';
import 'package:http/http.dart' as http;

import '../config/api_config.dart';
import 'auth_service.dart';

class SaldoService {

  static Future<Map<String, dynamic>?> getSaldo() async {
    try {
      final userId = AuthService.currentUser?["id"];

      if (userId == null) {
        return null;
      }

      final response = await http.get(
        Uri.parse("${ApiConfig.baseUrl}/saldo/$userId"),
      );

      if (response.statusCode != 200) {
        return null;
      }

      final result = jsonDecode(response.body);

      return result["data"];
    } catch (e) {
      print(e);
      return null;
    }
  }

}