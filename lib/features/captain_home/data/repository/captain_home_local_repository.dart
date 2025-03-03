import 'package:hive/hive.dart';
import '../model/captain_home_hive_model.dart';

class CaptainHomeLocalRepository {
  static const String _boxName = "captainBox";

  Future<void> saveCaptain(CaptainHomeHiveModel model) async {
    final box = await Hive.openBox<CaptainHomeHiveModel>(_boxName);
    await box.put(model.id, model);
  }

  Future<CaptainHomeHiveModel?> getCaptain() async {
    final box = await Hive.openBox<CaptainHomeHiveModel>(_boxName);
    return box.isNotEmpty ? box.get(box.keys.first) : null; // ✅ FIXED
  }

  Future<void> clearCaptain() async {
    final box = await Hive.openBox<CaptainHomeHiveModel>(_boxName);
    await box.clear();
  }
}
