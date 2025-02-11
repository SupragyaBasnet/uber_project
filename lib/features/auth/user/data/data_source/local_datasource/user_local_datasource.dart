import 'package:hive/hive.dart';
import '../../model/user_hive_model.dart';


abstract class UserLocalDataSource {
  Future<void> cacheUser(UserHiveModel user);
  Future<UserHiveModel?> getCachedUser();
  Future<void> clearCache();
}

class UserLocalDataSourceImpl implements UserLocalDataSource {
  final Box<UserHiveModel> userBox;

  UserLocalDataSourceImpl(this.userBox);

  @override
  Future<void> cacheUser(UserHiveModel user) async {
    await userBox.put('user', user);
  }

  @override
  Future<UserHiveModel?> getCachedUser() async {
    return userBox.get('user');
  }

  @override
  Future<void> clearCache() async {
    await userBox.delete('user');
  }
}
