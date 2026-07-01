import 'dart:convert';
import 'package:http/http.dart' as http;

import '../config/api_config.dart';

class LegalityService {

  static Future<Map<String, dynamic>?> getLegality() async {

    try {

      final response = await http.get(
        Uri.parse(
          "${ApiConfig.baseUrl}/legalities",
        ),
      );

      print(
        "LEGALITY STATUS : ${response.statusCode}",
      );

      print(
        "LEGALITY BODY : ${response.body}",
      );

      if (response.statusCode != 200) {

        return null;

      }

      final result =
          jsonDecode(response.body);

      return result["data"];

    } catch (e) {

      print(
        "LEGALITY ERROR : $e",
      );

      return null;

    }

  }

}