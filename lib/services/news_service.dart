import 'dart:convert';
import 'package:http/http.dart' as http;

import '../config/api_config.dart';

class NewsService {

  static Future<List<Map<String, dynamic>>> getAll() async {

    try {

      final response = await http.get(

        Uri.parse(
          "${ApiConfig.baseUrl}/news",
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

      print("NEWS ERROR : $e");

      return [];

    }

  }

  static Future<Map<String, dynamic>?> getById(
    String id,
  ) async {

    try {

      final response = await http.get(

        Uri.parse(
          "${ApiConfig.baseUrl}/news/$id",
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

      print("DETAIL NEWS ERROR : $e");

      return null;

    }

  }

}