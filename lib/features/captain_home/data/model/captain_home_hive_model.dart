import 'package:hive/hive.dart';

part 'captain_home_hive_model.g.dart';

@HiveType(typeId: 0)
class CaptainHomeHiveModel extends HiveObject {
  @HiveField(0)
  final String id;

  @HiveField(1)
  final String firstName;

  @HiveField(2)
  final String lastName;

  @HiveField(3)
  final String phoneNumber;

  @HiveField(4)
  final String email;

  @HiveField(5)
  final String profilePicture;

  @HiveField(6)
  final String licensePicture;

  @HiveField(7)
  final String theme;

  @HiveField(8)
  final double totalEarnings;

  @HiveField(9)
  final int rideCount;

  @HiveField(10)
  final double totalDistance;

  @HiveField(11)
  final String vehicleName;

  @HiveField(12)
  final String vehiclePlate;

  @HiveField(13)
  final String vehicleType;

  @HiveField(14)
  final int vehicleCapacity;

  CaptainHomeHiveModel({
    required this.id,
    required this.firstName,
    required this.lastName,
    required this.phoneNumber,
    required this.email,
    required this.profilePicture,
    required this.licensePicture,
    required this.theme,
    required this.totalEarnings,
    required this.rideCount,
    required this.totalDistance,
    required this.vehicleName,
    required this.vehiclePlate,
    required this.vehicleType,
    required this.vehicleCapacity,
  });
}
