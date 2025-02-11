import 'package:dartz/dartz.dart';
import '../../../../../core/error/failure.dart';

import '../repository/forgot_password_repository.dart';

class ResetPasswordUseCase {
  final ForgotPasswordRepository repository;

  ResetPasswordUseCase(this.repository);

  Future<Either<Failure, bool>> call(String email, String otp, String newPassword,String confirmPassword, String userType) async {
    return await repository.resetPassword(email, otp, newPassword, userType);
  }
}
