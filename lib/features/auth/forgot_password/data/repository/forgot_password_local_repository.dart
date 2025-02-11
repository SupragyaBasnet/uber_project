import 'package:hive/hive.dart';
import '../model/forgot_password_hive_model.dart';

class ForgotPasswordLocalRepository {
  final Box<ForgotPasswordHiveModel> forgotPasswordBox;

  ForgotPasswordLocalRepository(this.forgotPasswordBox);

  /// Save OTP verification data to Hive
  Future<void> saveForgotPasswordData(ForgotPasswordHiveModel data) async {
    await forgotPasswordBox.put('forgot_password', data);
  }

  /// Get OTP verification data from Hive
  ForgotPasswordHiveModel? getForgotPasswordData() {
    return forgotPasswordBox.get('forgot_password');
  }

  /// Delete OTP data from local storage
  Future<void> deleteForgotPasswordData() async {
    await forgotPasswordBox.delete('forgot_password');
  }

  /// Check if OTP data exists
  bool isOTPVerified() {
    return forgotPasswordBox.containsKey('forgot_password');
  }
}
