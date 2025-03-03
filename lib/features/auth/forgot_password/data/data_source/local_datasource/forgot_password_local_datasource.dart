// forgot_password_local_datasource.dart
import 'package:shared_preferences/shared_preferences.dart';

class ForgotPasswordLocalDataSource {
  Future<void> cacheEmail(String email) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('forgot_password_email', email);
  }

  Future<String?> getCachedEmail() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString('forgot_password_email');
  }

  Future<void> clearCachedEmail() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove('forgot_password_email');
  }
}
