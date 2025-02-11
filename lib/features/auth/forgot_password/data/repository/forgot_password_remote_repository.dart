import 'package:dio/dio.dart';
import '../../../../../app/constants/api_endpoints.dart';

class ForgotPasswordRemoteRepository {
  final Dio dio;

  ForgotPasswordRemoteRepository(this.dio);

  /// Send OTP API Call
  Future<String> sendOtp(String email, String userType) async {
    try {
      final response = await dio.post(
        ApiEndpoints.sendOtp,
        data: {
          "email": email,
          "userType": userType,
        },
      );

      return response.data["message"];
    } catch (e) {
      throw Exception("Failed to send OTP: ${e.toString()}");
    }
  }

  /// Verify OTP API Call
  Future<String> verifyOtp(String email, String otp) async {
    try {
      final response = await dio.post(
        ApiEndpoints.verifyOtp,
        data: {
          "email": email,
          "otp": otp,
        },
      );

      return response.data["message"];
    } catch (e) {
      throw Exception("Failed to verify OTP: ${e.toString()}");
    }
  }

  /// Reset Password API Call
  Future<String> resetPassword(String email, String otp, String newPassword, String userType) async {
    try {
      final response = await dio.post(
        ApiEndpoints.resetPassword,
        data: {
          "email": email,
          "otp": otp,
          "password": newPassword,
          "userType": userType,
        },
      );

      return response.data["message"];
    } catch (e) {
      throw Exception("Failed to reset password: ${e.toString()}");
    }
  }
}
