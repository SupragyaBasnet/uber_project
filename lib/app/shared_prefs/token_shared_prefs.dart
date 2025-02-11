import 'package:shared_preferences/shared_preferences.dart';

class TokenSharedPrefs {
  static const String _tokenKey = "auth_token";
  static const String _refreshTokenKey = "refresh_token";

  /// ✅ Save Auth Token
  static Future<void> saveAuthToken(String token) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString(_tokenKey, token);
  }

  /// ✅ Retrieve Auth Token
  static Future<String?> getAuthToken() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString(_tokenKey);
  }

  /// ✅ Save Refresh Token (Optional)
  static Future<void> saveRefreshToken(String refreshToken) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString(_refreshTokenKey, refreshToken);
  }

  /// ✅ Retrieve Refresh Token (Optional)
  static Future<String?> getRefreshToken() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString(_refreshTokenKey);
  }

  /// ✅ Clear Token (Logout)
  static Future<void> clearToken() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.remove(_tokenKey);
    await prefs.remove(_refreshTokenKey);
  }
}
