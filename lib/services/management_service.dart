import 'dart:convert';
import 'package:http/http.dart' as http;

import '../config/api_config.dart';

class ManagementService {

  static Future<List<dynamic>> getManagement() async {

    try {

      final response = await http.get(
        Uri.parse(
          "${ApiConfig.baseUrl}/managements",
        ),
      );

      print(
        "MANAGEMENT STATUS : ${response.statusCode}",
      );

      print(
        "MANAGEMENT BODY : ${response.body}",
      );

      if (response.statusCode != 200) {

        return [];

      }

      final result =
          jsonDecode(response.body);

      return result["data"];

    } catch (e) {

      print(
        "MANAGEMENT ERROR : $e",
      );

      return [];

    }

  }

}