// forgot_password_repository.dart
import '../entity/forgot_password_entity.dart';

abstract class ForgotPasswordRepository {
  Future<void> cacheEmail(String email);
  Future<String?> getCachedEmail();
  Future<void> clearCachedEmail();
  Future<String> sendOtp(ForgotPasswordEntity entity);
  Future<String> verifyOtp(ForgotPasswordEntity entity);
  Future<String> resetPassword(ForgotPasswordEntity entity);
}
