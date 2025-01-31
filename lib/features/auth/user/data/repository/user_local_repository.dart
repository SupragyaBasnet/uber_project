import 'package:hive/hive.dart';
import '../model/user_hive_model.dart';


class UserLocalRepository {
  final Box<UserHiveModel> userBox;

  UserLocalRepository(this.userBox);

  /// Save user data to Hive
  Future<void> saveUser(UserHiveModel user) async {
    await userBox.put('user', user);
  }

  /// Get user data from Hive
  UserHiveModel? getUser() {
    return userBox.get('user');
  }

  /// Delete user from local storage
  Future<void> deleteUser() async {
    await userBox.delete('user');
  }

  /// Check if user exists locally
  bool isUserLoggedIn() {
    return userBox.containsKey('user');
  }
}
