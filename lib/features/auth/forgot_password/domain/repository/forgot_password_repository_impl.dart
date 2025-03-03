import '../../data/data_source/local_datasource/forgot_password_local_datasource.dart';
import '../../data/data_source/remote_datasource/forgot_password_remote_datasource.dart';
import '../../domain/repository/forgot_password_repository.dart';

import '../../domain/entity/forgot_password_entity.dart';

class ForgotPasswordRepositoryImpl implements ForgotPasswordRepository {
  final ForgotPasswordLocalDataSource localDataSource;
  final ForgotPasswordRemoteDataSource remoteDataSource;

  ForgotPasswordRepositoryImpl({
    required this.localDataSource,
    required this.remoteDataSource,
  });

  @override
  Future<void> cacheEmail(String email) async {
    return localDataSource.cacheEmail(email);
  }

  @override
  Future<String?> getCachedEmail() async {
    return localDataSource.getCachedEmail();
  }

  @override
  Future<void> clearCachedEmail() async {
    return localDataSource.clearCachedEmail();
  }

  @override
  Future<String> sendOtp(ForgotPasswordEntity entity) async {
    return remoteDataSource.sendOtp(entity.email, entity.userType);
  }

  @override
  Future<String> verifyOtp(ForgotPasswordEntity entity) async {
    return remoteDataSource.verifyOtp(entity.email, entity.otp ?? "");
  }

  @override
  Future<String> resetPassword(ForgotPasswordEntity entity) async {
    return remoteDataSource.resetPassword(
      entity.email,
      entity.otp ?? "",
      entity.newPassword ?? "",
      entity.userType,
    );
  }
}
