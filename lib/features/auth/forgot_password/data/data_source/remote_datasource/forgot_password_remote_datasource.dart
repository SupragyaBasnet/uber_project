import 'package:dio/dio.dart';
import '../../../../../../app/constants/api_endpoints.dart';
import '../../../../../../core/error/exception.dart';
import '../../../../user/data/model/user_api_model.dart';


abstract class UserRemoteDatasource {
  Future<UserApiModel> loginUser(String phonenumber, String password);
  Future<UserApiModel> registerUser(UserApiModel user);
  Future<void> logoutUser();
}

class UserRemoteDatasourceImpl implements UserRemoteDatasource {
  final Dio dio;

  UserRemoteDatasourceImpl(this.dio);

  @override
  Future<UserApiModel> loginUser(String phonenumber, String password) async {
    try {
      final response = await dio.post(
        ApiEndpoints.userLogin,
        data: {
          "phonenumber": phonenumber,
          "password": password,
        },
      );

      if (response.statusCode == 200 && response.data.containsKey("user")) {
        return UserApiModel.fromJson(response.data["user"]); // ✅ Safe parsing
      } else {
        throw ServerException(response.data["message"] ?? "Login failed");
      }
    } on DioException catch (e) {
      throw ServerException(e.response?.data["message"] ?? "Login request failed");
    }
  }

  @override
  Future<UserApiModel> registerUser(UserApiModel user) async {
    try {
      final response = await dio.post(
        ApiEndpoints.userRegister,
        data: user.toJson(),
      );

      if (response.statusCode == 201 && response.data.containsKey("user")) {
        return UserApiModel.fromJson(response.data["user"]); // ✅ Safe parsing
      } else {
        throw ServerException(response.data["message"] ?? "Registration failed");
      }
    } on DioException catch (e) {
      throw ServerException(e.response?.data["message"] ?? "Registration request failed");
    }
  }

  @override
  Future<void> logoutUser() async {
    try {
      await dio.post(ApiEndpoints.userLogout); // ✅ Changed GET to POST for logout
    } on DioException catch (e) {
      throw ServerException(e.response?.data["message"] ?? "Logout request failed");
    }
  }
}
