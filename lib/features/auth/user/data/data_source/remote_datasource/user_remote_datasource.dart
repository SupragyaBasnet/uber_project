import 'package:dio/dio.dart';
import '../../model/user_api_model.dart';


abstract class UserRemoteDataSource {
  Future<UserApiModel> loginUser(Map<String, dynamic> credentials);
  Future<UserApiModel> signupUser(Map<String, dynamic> userData);
}

class UserRemoteDataSourceImpl implements UserRemoteDataSource {
  final Dio dio;

  UserRemoteDataSourceImpl(this.dio);

  @override
  Future<UserApiModel> loginUser(Map<String, dynamic> credentials) async {
    final response = await dio.post('/users/login', data: credentials);
    return UserApiModel.fromJson(response.data);
  }

  @override
  Future<UserApiModel> signupUser(Map<String, dynamic> userData) async {
    final response = await dio.post('/users/register', data: userData);
    return UserApiModel.fromJson(response.data);
  }
}
