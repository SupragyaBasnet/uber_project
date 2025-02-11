import 'package:hive/hive.dart';
import '../model/captain_hive_model.dart';


class CaptainLocalRepository {
  final Box<CaptainHiveModel> captainBox;

  CaptainLocalRepository(this.captainBox);

  /// Save captain data to Hive
  Future<void> saveCaptain(CaptainHiveModel captain) async {
    await captainBox.put('captain', captain);
  }

  /// Get captain data from Hive
  CaptainHiveModel? getCaptain() {
    return captainBox.get('captain');
  }

  /// Delete captain from local storage
  Future<void> deleteCaptain() async {
    await captainBox.delete('captain');
  }

  /// Check if captain exists locally
  bool isCaptainLoggedIn() {
    return captainBox.containsKey('captain');
  }
}
