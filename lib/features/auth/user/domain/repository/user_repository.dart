
import '../../data/hive/user_hive_helper.dart';
import '../../data/model/user_model.dart';
import '../entity/user.dart';

class UserRepository {
  final UserHiveHelper hiveHelper;

  UserRepository(this.hiveHelper);

  Future<User?> login(String phoneNumber, String password) async {
    final user = await hiveHelper.getUser(phoneNumber);
    if (user != null && user.password == password) {
      return User(phoneNumber: user.phoneNumber);
    }
    return null;
  }

  Future<void> register(UserModel user) async {
    await hiveHelper.addUser(user);
  }
}
