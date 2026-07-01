import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:firebase_auth/firebase_auth.dart';

import '../config/api_config.dart';

class ProfileService {

  static Future<Map<String, dynamic>?> getProfile() async {

    try {

      final token =
          await FirebaseAuth
              .instance
              .currentUser!
              .getIdToken();

      final response =
          await http.get(

        Uri.parse(
          "${ApiConfig.baseUrl}/auth/profile",
        ),

        headers: {
          "Authorization":
              "Bearer $token",
        },

      );

      if (response.statusCode != 200) {

        return null;

      }

      final result =
          jsonDecode(response.body);

      return result["data"];

    } catch (e) {

      print(e);

      return null;

    }

  }

  static Future<bool> updateProfile({
    required String nama,
    required String noHp,
    required String alamat,
    required String tempatLahir,
    required String tanggalLahir,
    required String jenisKelamin,
    required String pekerjaan,
    String? fotoProfileUrl,
  }) async {

    try {

      final token =
          await FirebaseAuth.instance.currentUser!
              .getIdToken();

      final response = await http.put(

        Uri.parse(
          "${ApiConfig.baseUrl}/auth/profile",
        ),

        headers: {
          "Authorization": "Bearer $token",
          "Content-Type": "application/json",
        },

        body: jsonEncode({

          "nama": nama,
          "no_hp": noHp,
          "alamat": alamat,
          "tempat_lahir": tempatLahir,
          "tanggal_lahir": tanggalLahir,
          "jenis_kelamin": jenisKelamin,
          "pekerjaan": pekerjaan,
          "foto_profile_url": fotoProfileUrl,

        }),

      );

      return response.statusCode == 200;

    } catch (e) {

      print(e);

      return false;

    }

  }

}