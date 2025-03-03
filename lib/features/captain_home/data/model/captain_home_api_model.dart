import 'package:json_annotation/json_annotation.dart';

import '../../domain/entity/captain_home_entity.dart';

part 'captain_home_api_model.g.dart';

@JsonSerializable()
class CaptainApiModel {
  final String id;
  final String firstName;
  final String lastName;
  final String phoneNumber;
  final String email;
  final String? profilePicture;
  final String? licensePicture;
  final String? theme;
  final double? totalEarnings;
  final int? rideCount;
  final double? totalDistance;
  final String? vehicleName;
  final String? vehiclePlate;
  final String? vehicleType;
  final int? vehicleCapacity;

  CaptainApiModel({
    required this.id,
    required this.firstName,
    required this.lastName,
    required this.phoneNumber,
    required this.email,
    this.profilePicture,
    this.licensePicture,
    this.theme,
    this.totalEarnings,
    this.rideCount,
    this.totalDistance,
    this.vehicleName,
    this.vehiclePlate,
    this.vehicleType,
    this.vehicleCapacity,
  });

  // JSON serialization methods
  factory CaptainApiModel.fromJson(Map<String, dynamic> json) =>
      _$CaptainApiModelFromJson(json);

  Map<String, dynamic> toJson() => _$CaptainApiModelToJson(this);

  // Convert to Entity
  CaptainHomeEntity toEntity() {
    return CaptainHomeEntity(
      id: id,
      firstName: firstName,
      lastName: lastName,
      phoneNumber: phoneNumber,
      email: email,
      profilePicture: profilePicture ?? "",
      licensePicture: licensePicture ?? "",
      theme: theme ?? "light",
      totalEarnings: totalEarnings ?? 0.0,
      rideCount: rideCount ?? 0,
      totalDistance: totalDistance ?? 0.0,
      vehicleName: vehicleName ?? "Unknown",
      vehiclePlate: vehiclePlate ?? "Unknown",
      vehicleType: vehicleType ?? "Unknown",
      vehicleCapacity: vehicleCapacity ?? 0,
    );
  }
}
