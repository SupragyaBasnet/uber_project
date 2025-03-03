// forgot_password_local_repository.dart
import '../data_source/local_datasource/forgot_password_local_datasource.dart';

class ForgotPasswordLocalRepository {
  final ForgotPasswordLocalDataSource localDataSource;

  ForgotPasswordLocalRepository({required this.localDataSource});

  Future<void> cacheEmail(String email) async {
    await localDataSource.cacheEmail(email);
  }

  Future<String?> getCachedEmail() async {
    return await localDataSource.getCachedEmail();
  }

  Future<void> clearCachedEmail() async {
    await localDataSource.clearCachedEmail();
  }
}
