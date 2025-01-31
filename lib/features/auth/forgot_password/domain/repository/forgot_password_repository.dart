import 'package:dartz/dartz.dart';
import '../../../../../core/error/failure.dart';


abstract class ForgotPasswordRepository {
  /// Send OTP to Email
  Future<Either<Failure, String>> sendOtp(String email, String userType);

  /// Verify OTP
  Future<Either<Failure, bool>> verifyOtp(String email, String otp);

  /// Reset Password
  Future<Either<Failure, bool>> resetPassword(String email, String otp, String newPassword, String userType);
}
