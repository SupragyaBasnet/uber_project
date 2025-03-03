import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';

import '../../../../auth/captain/data/dto/captain_dto.dart';



class CaptainHomeLocalDataSource {
  final SharedPreferences sharedPreferences;

  CaptainHomeLocalDataSource({required this.sharedPreferences});

  static const String cachedCaptain = "CACHED_CAPTAIN";

  // ✅ Cache Captain Data
  Future<void> cacheCaptain(CaptainDTO captain) async {
    final jsonString = jsonEncode(captain.toJson());
    await sharedPreferences.setString(cachedCaptain, jsonString);
  }

  // ✅ Get Cached Captain Data
  Future<CaptainDTO?> getCachedCaptain() async {
    final jsonString = sharedPreferences.getString(cachedCaptain);
    if (jsonString != null) {
      return CaptainDTO.fromJson(jsonDecode(jsonString));
    }
    return null;
  }

  // ✅ Clear Cached Captain Data
  Future<void> clearCache() async {
    await sharedPreferences.remove(cachedCaptain);
  }
}
