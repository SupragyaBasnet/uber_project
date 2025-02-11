import 'package:hive/hive.dart';
import '../../domain/entity/captain_entity.dart';

part 'captain_hive_model.g.dart'; // ✅ This must match your generated file

@HiveType(typeId: 1)
class CaptainHiveModel {
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
  final String vehicleType;

  @HiveField(6)
  final String vehiclePlate;

  @HiveField(7)
  final String vehicleName;

  @HiveField(8)
  final String vehicleCapacity;

  CaptainHiveModel({
    required this.id,
    required this.firstName,
    required this.lastName,
    required this.email,
    required this.phoneNumber,
    required this.vehicleType,
    required this.vehiclePlate,
    required this.vehicleName,
    required this.vehicleCapacity,
  });

  /// ✅ Convert Hive Model to Entity
  CaptainEntity toEntity() {
    return CaptainEntity(
      id: id,
      firstName: firstName,
      lastName: lastName,
      email: email,
      phoneNumber: phoneNumber,
      vehicleType: vehicleType,
      vehiclePlate: vehiclePlate,
      vehicleName: vehicleName,
      vehicleCapacity: vehicleCapacity,
    );
  }

  /// ✅ Convert Entity to Hive Model
  factory CaptainHiveModel.fromEntity(CaptainEntity entity) {
    return CaptainHiveModel(
      id: entity.id,
      firstName: entity.firstName,
      lastName: entity.lastName,
      email: entity.email,
      phoneNumber: entity.phoneNumber,
      vehicleType: entity.vehicleType,
      vehiclePlate: entity.vehiclePlate,
      vehicleName: entity.vehicleName,
      vehicleCapacity: entity.vehicleCapacity,
    );
  }
}
