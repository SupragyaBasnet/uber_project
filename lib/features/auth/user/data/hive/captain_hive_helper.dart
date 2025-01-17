import 'package:hive/hive.dart';
import '../model/captain_model.dart';

class CaptainHiveHelper {
  final String _boxName = 'captainBox';

  /// Opens the Hive box for captains.
  Future<Box<CaptainModel>> _openBox() async {
    if (!Hive.isBoxOpen(_boxName)) {
      return await Hive.openBox<CaptainModel>(_boxName);
    }
    return Hive.box<CaptainModel>(_boxName);
  }

  /// Adds a captain to the Hive box.
  Future<void> addCaptain(CaptainModel captain) async {
    final box = await _openBox();
    await box.put(captain.phoneNumber, captain);
  }

  /// Retrieves a captain from the Hive box.
  Future<CaptainModel?> getCaptain(String phoneNumber) async {
    final box = await _openBox();
    return box.get(phoneNumber);
  }
}
