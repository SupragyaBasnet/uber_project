import 'package:hive/hive.dart';

import '../../../../../../core/error/exception.dart';

abstract class ForgotPasswordLocalDatasource {
  Future<void> cacheOtp(String email, String otp);
  Future<String?> getCachedOtp(String email);
  Future<void> clearCachedOtp(String email);
}

class ForgotPasswordLocalDatasourceImpl implements ForgotPasswordLocalDatasource {
  static const String otpBoxName = "forgotPasswordOtpBox";

  @override
  Future<void> cacheOtp(String email, String otp) async {
    try {
      final box = await Hive.openBox(otpBoxName);
      await box.put(email.toLowerCase(), otp);
    } catch (e) {
      throw CacheException("Failed to cache OTP");
    }
  }

  @override
  Future<String?> getCachedOtp(String email) async {
    try {
      final box = await Hive.openBox(otpBoxName);
      return box.get(email.toLowerCase());
    } catch (e) {
      throw CacheException("Failed to retrieve cached OTP");
    }
  }

  @override
  Future<void> clearCachedOtp(String email) async {
    try {
      final box = await Hive.openBox(otpBoxName);
      await box.delete(email.toLowerCase());
    } catch (e) {
      throw CacheException("Failed to clear cached OTP");
    }
  }
}
