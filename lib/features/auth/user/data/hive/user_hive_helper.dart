import 'package:hive/hive.dart';

import '../model/user_model.dart';


class UserHiveHelper {
  static const String boxName = 'userBox';

  Future<void> addUser(UserModel user) async {
    final box = await Hive.openBox<UserModel>(boxName);
    await box.put(user.phoneNumber, user);
  }

  Future<UserModel?> getUser(String phoneNumber) async {
    final box = await Hive.openBox<UserModel>(boxName);
    return box.get(phoneNumber);
  }
}
