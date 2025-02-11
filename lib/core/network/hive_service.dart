import 'package:hive_flutter/hive_flutter.dart';
import 'package:path_provider/path_provider.dart';

class HiveService {
  static const String userBoxName = 'userBox';
  static const String captainBoxName = 'captainBox';

  Future<void> init() async {
    // ✅ Initialize Hive Database
    var directory = await getApplicationDocumentsDirectory();
    await Hive.initFlutter(directory.path);

    // ✅ Open Boxes
    await Hive.openBox(userBoxName);
    await Hive.openBox(captainBoxName);
  }

  // =============== User Storage ===============
  Future<void> saveUserData(Map<String, dynamic> userData) async {
    var box = await Hive.openBox(userBoxName);
    await box.put('user', userData);
  }

  Future<Map<String, dynamic>?> getUserData() async {
    var box = await Hive.openBox(userBoxName);
    return box.get('user');
  }

  Future<void> deleteUserData() async {
    var box = await Hive.openBox(userBoxName);
    await box.delete('user');
  }

  // =============== Captain Storage ===============
  Future<void> saveCaptainData(Map<String, dynamic> captainData) async {
    var box = await Hive.openBox(captainBoxName);
    await box.put('captain', captainData);
  }

  Future<Map<String, dynamic>?> getCaptainData() async {
    var box = await Hive.openBox(captainBoxName);
    return box.get('captain');
  }

  Future<void> deleteCaptainData() async {
    var box = await Hive.openBox(captainBoxName);
    await box.delete('captain');
  }

  // =============== Clear All Data ===============
  Future<void> clearAllData() async {
    await Hive.deleteBoxFromDisk(userBoxName);
    await Hive.deleteBoxFromDisk(captainBoxName);
  }
}
