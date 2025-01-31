import 'package:hive/hive.dart';

class HiveService {
  Future<void> openBoxes() async {
    await Hive.openBox('userBox');
    await Hive.openBox('captainBox');
  }

  Box getBox(String boxName) => Hive.box(boxName);

  Future<void> saveData(String boxName, String key, dynamic value) async {
    final box = Hive.box(boxName);
    await box.put(key, value);
  }

  dynamic getData(String boxName, String key) {
    final box = Hive.box(boxName);
    return box.get(key);
  }

  Future<void> clearBox(String boxName) async {
    final box = Hive.box(boxName);
    await box.clear();
  }
}
