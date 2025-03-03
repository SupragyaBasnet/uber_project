import 'package:json_annotation/json_annotation.dart';

part 'captain_home_dto.g.dart';

@JsonSerializable()
class CaptainDTO {
  final String id;
  final String fullname;
  final String phone;
  final String? profilePicture;
  final double totalEarnings;
  final int rideCount;
  final double totalDistance;
  final String? vehicleType;
  final bool isAvailable;
  final double? latitude;
  final double? longitude;

  CaptainDTO({
    required this.id,
    required this.fullname,
    required this.phone,
    this.profilePicture,
    required this.totalEarnings,
    required this.rideCount,
    required this.totalDistance,
    this.vehicleType,
    required this.isAvailable,
    this.latitude,
    this.longitude,
  });

  // ✅ Factory method for JSON deserialization
  factory CaptainDTO.fromJson(Map<String, dynamic> json) =>
      _$CaptainDTOFromJson(json);

  // ✅ Method for JSON serialization
  Map<String, dynamic> toJson() => _$CaptainDTOToJson(this);
}
