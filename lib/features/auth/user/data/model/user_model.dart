import 'package:hive/hive.dart';

part 'user_model.g.dart';

@HiveType(typeId: 0)
class UserModel {
  @HiveField(0)
  final String phoneNumber;

  @HiveField(1)
  final String password;

  UserModel({required this.phoneNumber, required this.password});
}
