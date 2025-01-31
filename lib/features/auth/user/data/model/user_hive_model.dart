import 'package:hive/hive.dart';
import 'user_api_model.dart';

part 'user_hive_model.g.dart';

@HiveType(typeId: 1)
class UserHiveModel extends HiveObject {
  @HiveField(0)
  final String id;

  @HiveField(1)
  final String email;

  @HiveField(2)
  final String phonenumber;

  @HiveField(3)
  final String fullname;

  @HiveField(4)
  final String token;

  UserHiveModel({
    required this.id,
    required this.email,
    required this.phonenumber,
    required this.fullname,
    required this.token,
  });

  /// Convert `UserApiModel` to `UserHiveModel`
  factory UserHiveModel.fromApiModel(UserApiModel apiModel) {
    return UserHiveModel(
      id: apiModel.id,
      email: apiModel.email,
      phonenumber: apiModel.phonenumber,
      fullname: apiModel.fullname,
      token: apiModel.token,
    );
  }
}
