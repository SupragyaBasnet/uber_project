import 'package:dio/dio.dart';
import '../model/captain_home_api_model.dart';

class CaptainHomeRemoteRepository {
  final Dio dio;

  CaptainHomeRemoteRepository({required this.dio});

  Future<CaptainApiModel> fetchCaptainProfile() async {
    try {
      final response = await dio.get('/captains/profile',
          options: Options(headers: {
            "Authorization": "Bearer ${await _getToken()}"
          }));

      return CaptainApiModel.fromJson(response.data);
    } catch (e) {
      throw Exception("Failed to fetch captain profile: $e");
    }
  }

  Future<void> updateCaptainProfile(Map<String, dynamic> updatedData) async {
    try {
      await dio.put('/captains/update',
          data: updatedData,
          options: Options(headers: {
            "Authorization": "Bearer ${await _getToken()}"
          }));
    } catch (e) {
      throw Exception("Failed to update profile: $e");
    }
  }

  Future<void> uploadProfilePicture(String filePath) async {
    try {
      FormData formData = FormData.fromMap({
        'profilePicture': await MultipartFile.fromFile(filePath),
      });

      await dio.post('/captains/upload-profile',
          data: formData,
          options: Options(headers: {
            "Authorization": "Bearer ${await _getToken()}"
          }));
    } catch (e) {
      throw Exception("Failed to upload profile picture: $e");
    }
  }

  Future<void> logoutCaptain() async {
    try {
      await dio.post('/captains/logout',
          options: Options(headers: {
            "Authorization": "Bearer ${await _getToken()}"
          }));
    } catch (e) {
      throw Exception("Failed to log out: $e");
    }
  }

  Future<String> _getToken() async {
    return "your_token"; // Replace with your token retrieval logic
  }
}
