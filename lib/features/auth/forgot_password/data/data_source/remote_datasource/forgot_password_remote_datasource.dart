// forgot_password_remote_datasource.dart
import 'package:dio/dio.dart';

class ForgotPasswordRemoteDataSource {
  final Dio dio;

  ForgotPasswordRemoteDataSource({required this.dio});

  Future<String> sendOtp(String email, String userType) async {
    final response = await dio.post(
      '/api/forgot-password/send-otp',
      data: {"email": email, "userType": userType},
    );
    return response.data["message"];
  }

  Future<String> verifyOtp(String email, String otp) async {
    final response = await dio.post(
      '/api/forgot-password/verify-otp',
      data: {"email": email, "otp": otp},
    );
    return response.data["message"];
  }

  Future<String> resetPassword(String email, String otp, String newPassword, String userType) async {
    final response = await dio.post(
      '/api/forgot-password/reset-password',
      data: {"email": email, "otp": otp, "password": newPassword, "userType": userType},
    );
    return response.data["message"];
  }
}
