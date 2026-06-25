import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:firebase_auth/firebase_auth.dart';

import '../config/api_config.dart';

class PenarikanService {

  static Future<Map<String, dynamic>?> create({
    required String nominal,
    required String keterangan,
  }) async {

    try {

      final user =
          FirebaseAuth.instance.currentUser;

      if (user == null) {

        print("USER FIREBASE NULL");

        return null;
      }

      final token =
          await user.getIdToken();

      // Ambil profile anggota
      final profileResponse =
          await http.get(
        Uri.parse(
          "${ApiConfig.baseUrl}/auth/profile",
        ),
        headers: {
          "Authorization":
              "Bearer $token",
        },
      );

      print(
        "PROFILE STATUS : ${profileResponse.statusCode}",
      );

      print(
        "PROFILE BODY : ${profileResponse.body}",
      );

      if (profileResponse.statusCode != 200) {
        return null;
      }

      final profile =
          jsonDecode(
            profileResponse.body,
          );

      final userId =
          profile["data"]["id"];

      final body = {
        "user_id": userId,
        "nominal":
            double.tryParse(
                  nominal
                      .replaceAll(".", "")
                      .replaceAll(",", ""),
                ) ??
                0,
        "keterangan": keterangan,
      };

      print("BODY PENARIKAN:");
      print(jsonEncode(body));

      final response =
          await http.post(
        Uri.parse(
          "${ApiConfig.baseUrl}/penarikan",
        ),
        headers: {
          "Content-Type":
              "application/json",
        },
        body: jsonEncode(body),
      );

      print(
        "PENARIKAN STATUS : ${response.statusCode}",
      );

      print(
        "PENARIKAN BODY : ${response.body}",
      );

      if (response.statusCode == 201) {

        final result =
            jsonDecode(response.body);

        // controller create masih pakai .select()
        // jadi hasilnya array
        if (result["data"] is List) {
          return result["data"][0];
        }

        return result["data"];
      }

      return null;

    } catch (e) {

      print(
        "PENARIKAN ERROR : $e",
      );

      return null;

    }

  }

  static Future<List<dynamic>> getByUser() async {

    try {

      final user =
          FirebaseAuth.instance.currentUser;

      if (user == null) {
        return [];
      }

      final token =
          await user.getIdToken();

      final profileResponse =
          await http.get(
        Uri.parse(
          "${ApiConfig.baseUrl}/auth/profile",
        ),
        headers: {
          "Authorization":
              "Bearer $token",
        },
      );

      if (profileResponse.statusCode != 200) {
        return [];
      }

      final profile =
          jsonDecode(
            profileResponse.body,
          );

      final userId =
          profile["data"]["id"];

      final response =
          await http.get(
        Uri.parse(
          "${ApiConfig.baseUrl}/penarikan/user/$userId",
        ),
      );

      print(
        "GET PENARIKAN STATUS : ${response.statusCode}",
      );

      print(
        "GET PENARIKAN BODY : ${response.body}",
      );

      if (response.statusCode == 200) {

        final result =
            jsonDecode(
              response.body,
            );

        return result["data"];
      }

      return [];

    } catch (e) {

      print(
        "GET PENARIKAN ERROR : $e",
      );

      return [];

    }

  }

}