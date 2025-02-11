import 'package:dio/dio.dart';
import '../../../../../../core/network/api_service.dart';
import '../../model/captain_api_model.dart';


abstract class CaptainRemoteDataSource {
  Future<CaptainApiModel> loginCaptain(Map<String, dynamic> credentials);
  Future<CaptainApiModel> registerCaptain(Map<String, dynamic> captainData);
}

class CaptainRemoteDataSourceImpl implements CaptainRemoteDataSource {
  final ApiService apiService;

  CaptainRemoteDataSourceImpl(this.apiService); // ✅ Use `ApiService` instead of `Dio`

  @override
  Future<CaptainApiModel> loginCaptain(Map<String, dynamic> credentials) async {
    try {
      final response = await apiService.postRequest('/captains/login', data: credentials);
      return CaptainApiModel.fromJson(response.data);
    } catch (e) {
      throw Exception("Login failed: $e");
    }
  }

  @override
  Future<CaptainApiModel> registerCaptain(Map<String, dynamic> captainData) async {
    try {
      final response = await apiService.postRequest('/captains/register', data: captainData);
      return CaptainApiModel.fromJson(response.data);
    } catch (e) {
      throw Exception("Registration failed: $e");
    }
  }
}
