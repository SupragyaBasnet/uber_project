// forgot_password_remote_repository.dart
import '../data_source/remote_datasource/forgot_password_remote_datasource.dart';


class ForgotPasswordRemoteRepository {
  final ForgotPasswordRemoteDataSource remoteDataSource;

  ForgotPasswordRemoteRepository({required this.remoteDataSource});

  Future<String> sendOtp(String email, String userType) async {
    return await remoteDataSource.sendOtp(email, userType);
  }

  Future<String> verifyOtp(String email, String otp) async {
    return await remoteDataSource.verifyOtp(email, otp);
  }

  Future<String> resetPassword(String email, String otp, String newPassword, String userType) async {
    return await remoteDataSource.resetPassword(email, otp, newPassword, userType);
  }
}
