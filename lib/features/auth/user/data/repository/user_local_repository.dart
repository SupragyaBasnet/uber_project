import '../../domain/entity/user_entity.dart';
import '../data_source/local_datasource/user_local_datasource.dart';

class UserLocalRepository {
  final UserLocalDataSource localDataSource;

  UserLocalRepository(this.localDataSource);

  Future<UserEntity?> getCachedUser() async {
    final data = await localDataSource.getCachedUser();
    if (data != null) {
      return UserEntity(
        id: data.id,
        firstName: data.firstName,
        lastName: data.lastName,
        email: data.email,
        phoneNumber: data.phoneNumber,
        token: data.token,
      );
    }
    return null;
  }
}
