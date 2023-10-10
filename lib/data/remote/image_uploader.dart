import 'package:dio/dio.dart';
import 'package:http_parser/http_parser.dart';
import 'package:logger/logger.dart';
import 'package:nutech_flutter_apps/data/remote/environment.dart';

class ImageUploader {
  static Dio _dio = Dio();

  static Future<void> uploadImage(String imagePath, String token) async {
    try {
      FormData formData = FormData.fromMap({
        "file": await MultipartFile.fromFile(
          imagePath,
          filename: "profile_image.jpeg",
          contentType: MediaType('image', 'jpeg'),
        ),
      });

      // Ganti URL dengan benar sesuai dengan kebutuhan Anda
      Response response = await _dio.put(
        "https://take-home-test-api.nutech-integrasi.app/profile/image",
        data: formData,
        options: Options(
          headers: {
            "Authorization": "Bearer $token",
          },
        ),
      );

      if (response.statusCode == 200) {
        print("Gambar berhasil diupload");
      } else {
        print("Gagal mengunggah gambar. Status code: ${response.statusCode}");
      }
    } catch (error) {
      throw error;
    }
  }
}
