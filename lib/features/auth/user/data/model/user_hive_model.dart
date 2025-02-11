import 'package:hive/hive.dart';
import '../../domain/entity/user_entity.dart';

part 'user_hive_model.g.dart';

@HiveType(typeId: 2)
class UserHiveModel {
  @HiveField(0)
  final String id;

  @HiveField(1)
  final String firstName;

  @HiveField(2)
  final String lastName;

  @HiveField(3)
  final String email;

  @HiveField(4)
  final String phoneNumber;

  @HiveField(5)
  final String token;

  UserHiveModel({
    required this.id,
    required this.firstName,
    required this.lastName,
    required this.email,
    required this.phoneNumber,
    required this.token,
  });

  factory UserHiveModel.fromEntity(UserEntity user) {
    return UserHiveModel(
      id: user.id,
      firstName: user.firstName,
      lastName: user.lastName,
      email: user.email,
      phoneNumber: user.phoneNumber,
      token: user.token,
    );
  }

  UserEntity toEntity() {
    return UserEntity(
      id: id,
      firstName: firstName,
      lastName: lastName,
      email: email,
      phoneNumber: phoneNumber,
      token: token,
    );
  }
}
