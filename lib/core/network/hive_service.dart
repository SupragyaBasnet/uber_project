import 'package:hive_flutter/hive_flutter.dart';
import 'package:path_provider/path_provider.dart';

import '../../features/auth/user/data/model/user_model.dart';
import '../../features/auth/user/data/model/captain_model.dart';

class HiveService {
  /// Initializes Hive and registers all required adapters.
  Future<void> init() async {
    // Initialize Hive with a directory
    final directory = await getApplicationDocumentsDirectory();
    await Hive.initFlutter(directory.path);

    // Register Adapters
    Hive.registerAdapter(UserModelAdapter());
    Hive.registerAdapter(CaptainModelAdapter());
  }

  /// Opens a Hive box for the given box name.
  Future<Box<T>> openBox<T>(String boxName) async {
    if (!Hive.isBoxOpen(boxName)) {
      return await Hive.openBox<T>(boxName);
    }
    return Hive.box<T>(boxName);
  }

  /// Closes all Hive boxes.
  Future<void> closeAllBoxes() async {
    await Hive.close();
  }

  /// Deletes a specific Hive box.
  Future<void> deleteBox(String boxName) async {
    if (Hive.isBoxOpen(boxName)) {
      await Hive.box(boxName).close();
    }
    await Hive.deleteBoxFromDisk(boxName);
  }
}
