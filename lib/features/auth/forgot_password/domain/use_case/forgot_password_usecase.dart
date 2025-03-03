// forgot_password_usecase.dart
import '../entity/forgot_password_entity.dart';

import '../repository/forgot_password_repository.dart';

class ForgotPasswordUseCase {
  final ForgotPasswordRepository repository;

  ForgotPasswordUseCase({required this.repository});

  Future<void> cacheEmail(String email) {
    return repository.cacheEmail(email);
  }

  Future<String?> getCachedEmail() {
    return repository.getCachedEmail();
  }

  Future<void> clearCachedEmail() {
    return repository.clearCachedEmail();
  }

  Future<String> sendOtp(ForgotPasswordEntity entity) {
    return repository.sendOtp(entity);
  }

  Future<String> verifyOtp(ForgotPasswordEntity entity) {
    return repository.verifyOtp(entity);
  }

  Future<String> resetPassword(ForgotPasswordEntity entity) {
    return repository.resetPassword(entity);
  }
}
