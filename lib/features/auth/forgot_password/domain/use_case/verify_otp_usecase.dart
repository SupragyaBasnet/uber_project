import 'package:dartz/dartz.dart';
import '../../../../../core/error/failure.dart';
import '../repository/forgot_password_repository.dart';

class VerifyOtpUseCase {
  final ForgotPasswordRepository repository;

  VerifyOtpUseCase(this.repository);

  Future<Either<Failure, bool>> call(String email, String otp) async {
    return await repository.verifyOtp(email, otp);
  }
}
