import 'package:dio/dio.dart';
import '../../../../../../core/network/api_service.dart';
import '../../model/user_api_model.dart';


abstract class UserRemoteDataSource {
  Future<UserApiModel> loginUser(Map<String, dynamic> credentials);
  Future<UserApiModel> signupUser(Map<String, dynamic> userData);
}

class UserRemoteDataSourceImpl implements UserRemoteDataSource {
  final ApiService apiService;

  UserRemoteDataSourceImpl(this.apiService); // ✅ Use `ApiService` instead of `Dio`

  @override
  Future<UserApiModel> loginUser(Map<String, dynamic> credentials) async {
    try {
      final response = await apiService.postRequest('/users/login', data: credentials);
      return UserApiModel.fromJson(response.data);
    } catch (e) {
      throw Exception("Login failed: $e");
    }
  }

  @override
  Future<UserApiModel> signupUser(Map<String, dynamic> userData) async {
    try {
      final response = await apiService.postRequest('/users/register', data: userData);
      return UserApiModel.fromJson(response.data);
    } catch (e) {
      throw Exception("Signup failed: $e");
    }
  }
}
