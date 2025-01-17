import '../../data/hive/captain_hive_helper.dart';
import '../../data/model/captain_model.dart';

class CaptainRepository {
  final CaptainHiveHelper hiveHelper;

  CaptainRepository(this.hiveHelper);

  /// Login method for Captain
  Future<bool> login(String phoneNumber, String password) async {
    final captain = await hiveHelper.getCaptain(phoneNumber);
    if (captain != null && captain.password == password) {
      return true; // Successful login
    }
    return false; // Login failed
  }

  /// Register method for Captain
  Future<void> register(CaptainModel captain) async {
    await hiveHelper.addCaptain(captain);
  }
}
