import 'package:dio/dio.dart';
import '../../../../../../app/constants/api_endpoints.dart';
import '../../../../../../core/error/exception.dart';
import '../../model/user_api_model.dart';

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
          "phonenumber": phonenumber, // ✅ Ensure correct parameter names
          "password": password,
        },
      );

      if (response.statusCode == 200) {
        return UserApiModel.fromJson(response.data["user"]);
      } else {
        throw ServerException(response.data["message"] ?? "Login failed");
      }
    } catch (e) {
      throw ServerException(e.toString());
    }
  }

  @override
  Future<UserApiModel> registerUser(UserApiModel user) async {
    try {
      final response = await dio.post(
        ApiEndpoints.userRegister,
        data: user.toJson(), // ✅ Serialize UserModel correctly
      );

      if (response.statusCode == 201) {
        return UserApiModel.fromJson(response.data["user"]);
      } else {
        throw ServerException(response.data["message"] ?? "Registration failed");
      }
    } catch (e) {
      throw ServerException(e.toString());
    }
  }

  @override
  Future<void> logoutUser() async {
    try {
      await dio.get(ApiEndpoints.userLogout);
    } catch (e) {
      throw ServerException(e.toString());
    }
  }
}
