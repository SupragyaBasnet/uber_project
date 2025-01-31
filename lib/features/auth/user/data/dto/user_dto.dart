import 'package:dio/dio.dart';

import '../../../../../app/constants/api_endpoints.dart';
import '../../../../../core/error/exception.dart';

abstract class ForgotPasswordRemoteDataSource {
  Future<void> sendOtp(String email, String userType);
  Future<void> verifyOtp(String email, String otp);
  Future<void> resetPassword(String email, String otp, String newPassword, String userType);
}

class ForgotPasswordRemoteDataSourceImpl implements ForgotPasswordRemoteDataSource {
  final Dio dio;

  ForgotPasswordRemoteDataSourceImpl(this.dio);

  @override
  Future<void> sendOtp(String email, String userType) async {
    try {
      final response = await dio.post(
        ApiEndpoints.sendOtp,
        data: {
          "email": email.toLowerCase(),
          "userType": userType,
        },
      );

      if (response.statusCode != 200) {
        throw ServerException(response.data["message"]);
      }
    } catch (e) {
      throw ServerException(e.toString());
    }
  }

  @override
  Future<void> verifyOtp(String email, String otp) async {
    try {
      final response = await dio.post(
        ApiEndpoints.verifyOtp,
        data: {
          "email": email.toLowerCase(),
          "otp": otp,
        },
      );

      if (response.statusCode != 200) {
        throw ServerException(response.data["message"]);
      }
    } catch (e) {
      throw ServerException(e.toString());
    }
  }

  @override
  Future<void> resetPassword(String email, String otp, String newPassword, String userType) async {
    try {
      final response = await dio.post(
        ApiEndpoints.resetPassword,
        data: {
          "email": email.toLowerCase(),
          "otp": otp,
          "password": newPassword,
          "userType": userType,
        },
      );

      if (response.statusCode != 200) {
        throw ServerException(response.data["message"]);
      }
    } catch (e) {
      throw ServerException(e.toString());
    }
  }
}