import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import '../config/api_config.dart';

class UploadService {

  static Future<String?> uploadImage(
    File imageFile,
  ) async {

    try {

      final request =
          http.MultipartRequest(
        "POST",
        Uri.parse(
          "${ApiConfig.baseUrl}/upload/image",
        ),
      );

      request.files.add(
        await http.MultipartFile.fromPath(
          "file",
          imageFile.path,
        ),
      );

      final response =
          await request.send();

      final body =
          await response.stream.bytesToString();
      
      print("UPLOAD STATUS : ${response.statusCode}");
      print("UPLOAD BODY : $body");

      final result =
          jsonDecode(body);

      if (response.statusCode == 200) {

        return result["url"];

      }

      return null;

    } catch (e) {

      print(
        "UPLOAD ERROR: $e",
      );

      return null;

    }

  }

}