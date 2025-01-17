import 'package:hive/hive.dart';

part 'captain_model.g.dart';

@HiveType(typeId: 1)
class CaptainModel {
  @HiveField(0)
  final String phoneNumber;

  @HiveField(1)
  final String password;

  CaptainModel({required this.phoneNumber, required this.password});
}
