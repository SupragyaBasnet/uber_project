import 'package:json_annotation/json_annotation.dart';

part 'captain_dto.g.dart';

@JsonSerializable()
class CaptainDTO {
  final String phonenumber;
  final String email;
  final String password;
  final FullName fullname;
  final Vehicle vehicle;

  CaptainDTO({
    required this.phonenumber,
    required this.email,
    required this.password,
    required this.fullname,
    required this.vehicle,
  });

  /// Factory method to create a `CaptainDTO` from JSON
  factory CaptainDTO.fromJson(Map<String, dynamic> json) =>
      _$CaptainDTOFromJson(json);

  /// Method to convert `CaptainDTO` to JSON
  Map<String, dynamic> toJson() => _$CaptainDTOToJson(this);
}

/// Full Name Model
@JsonSerializable()
class FullName {
  final String firstname;
  final String lastname;

  FullName({
    required this.firstname,
    required this.lastname,
  });

  factory FullName.fromJson(Map<String, dynamic> json) =>
      _$FullNameFromJson(json);

  Map<String, dynamic> toJson() => _$FullNameToJson(this);
}

/// Vehicle Model
@JsonSerializable()
class Vehicle {
  final String color;
  final String plate;
  final int capacity;
  final String vehicleType;

  Vehicle({
    required this.color,
    required this.plate,
    required this.capacity,
    required this.vehicleType,
  });

  factory Vehicle.fromJson(Map<String, dynamic> json) =>
      _$VehicleFromJson(json);

  Map<String, dynamic> toJson() => _$VehicleToJson(this);
}
