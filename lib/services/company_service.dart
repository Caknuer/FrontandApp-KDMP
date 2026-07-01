import 'dart:convert';
import 'package:http/http.dart' as http;

import '../config/api_config.dart';

class CompanyService {

  static Future<Map<String, dynamic>?> getProfile() async {

    try {

      final response = await http.get(
        Uri.parse(
          "${ApiConfig.baseUrl}/company",
        ),
      );

      print(
        "COMPANY STATUS : ${response.statusCode}",
      );

      print(
        "COMPANY BODY : ${response.body}",
      );

      if (response.statusCode != 200) {
        return null;
      }

      final result =
          jsonDecode(response.body);

      return result["data"];

    } catch (e) {

      print(
        "COMPANY ERROR : $e",
      );

      return null;

    }

  }

}