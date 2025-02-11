import 'package:hive/hive.dart';
import 'captain_api_model.dart';

part 'captain_hive_model.g.dart';

@HiveType(typeId: 1) // Assign a unique Type ID for Hive
class CaptainHiveModel extends HiveObject {
  @HiveField(0)
  final String id;

  @HiveField(1)
  final String email;

  @HiveField(2)
  final String phonenumber;

  @HiveField(3)
  final String firstname;

  @HiveField(4)
  final String lastname;

  @HiveField(5)
  final String password;  // ✅ Added password

  @HiveField(6)
  final String token;

  @HiveField(7)
  final VehicleModel vehicle;  // ✅ Use the proper model instead of Map

  CaptainHiveModel({
    required this.id,
    required this.email,
    required this.phonenumber,
    required this.firstname,
    required this.lastname,
    required this.password,  // ✅ Added password
    required this.token,
    required this.vehicle,
  });

  /// Convert `CaptainApiModel` to `CaptainHiveModel` for local storage
  factory CaptainHiveModel.fromApiModel(CaptainApiModel apiModel) {
    return CaptainHiveModel(
      id: apiModel.id,
      email: apiModel.email,
      phonenumber: apiModel.phonenumber,
      firstname: apiModel.firstname,
      lastname: apiModel.lastname,
      password: apiModel.password,  // ✅ Added password
      token: apiModel.token,
      vehicle: apiModel.vehicle,
    );
  }
}
