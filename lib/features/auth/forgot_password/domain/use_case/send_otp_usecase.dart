import 'package:dartz/dartz.dart';
import '../../../../../core/error/failure.dart';

import '../repository/forgot_password_repository.dart';

class SendOtpUseCase {
  final ForgotPasswordRepository repository;

  SendOtpUseCase(this.repository);

  Future<Either<Failure, String>> call(String email, String userType) async {
    return await repository.sendOtp(email, userType);
  }
}
