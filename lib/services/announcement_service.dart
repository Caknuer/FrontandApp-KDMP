import 'dart:convert';
import 'package:http/http.dart' as http;

import '../config/api_config.dart';

class AnnouncementService {

  static Future<List<Map<String, dynamic>>> getAll() async {

    try {

      final response = await http.get(

        Uri.parse(
          "${ApiConfig.baseUrl}/announcement",
        ),

      );

      if (response.statusCode != 200) {

        return [];

      }

      final result =
          jsonDecode(response.body);

      return List<Map<String, dynamic>>.from(

        result["data"],

      );

    } catch (e) {

      print(
        "ANNOUNCEMENT ERROR : $e",
      );

      return [];

    }

  }

  static Future<Map<String, dynamic>?> getById(
    String id,
  ) async {

    try {

      final response = await http.get(

        Uri.parse(
          "${ApiConfig.baseUrl}/announcement/$id",
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
        "DETAIL ANNOUNCEMENT ERROR : $e",
      );

      return null;

    }

  }

}