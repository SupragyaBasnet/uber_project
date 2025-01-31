import 'package:hive/hive.dart';
import 'package:uber_mobile_app_project/features/auth/user/data/model/user_hive_model.dart';

import '../../../../../../app/constants/hive_table_constant.dart';

abstract class UserLocalDatasource {
  Future<void> cacheUserData(UserHiveModel user);
  Future<UserHiveModel?> getCachedUser();
  Future<void> clearUserData();
}

class UserLocalDatasourceImpl implements UserLocalDatasource {
  final Box<UserHiveModel> _userBox;

  UserLocalDatasourceImpl(this._userBox);

  @override
  Future<void> cacheUserData(UserHiveModel user) async {
    await _userBox.put(HiveTableConstants.userBox, user); // ✅ Fixed
  }

  @override
  Future<UserHiveModel?> getCachedUser() async {
    return _userBox.get(HiveTableConstants.userBox); // ✅ Fixed
  }

  @override
  Future<void> clearUserData() async {
    await _userBox.delete(HiveTableConstants.userBox); // ✅ Fixed
  }
}
