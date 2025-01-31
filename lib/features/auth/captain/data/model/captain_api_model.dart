import 'package:json_annotation/json_annotation.dart';

part 'captain_api_model.g.dart';

@JsonSerializable()
class CaptainApiModel {
  final String id;
  final String email;
  final String phonenumber;
  final String firstname;
  final String lastname;
  final String password;  // ✅ Added password
  final String token;
  final VehicleModel vehicle;  // ✅ Replaced Map with a model

  CaptainApiModel({
    required this.id,
    required this.email,
    required this.phonenumber,
    required this.firstname,
    required this.lastname,
    required this.password,  // ✅ Added password
    required this.token,
    required this.vehicle,
  });

  /// Convert JSON to `CaptainApiModel`
  factory CaptainApiModel.fromJson(Map<String, dynamic> json) =>
      _$CaptainApiModelFromJson(json);

  /// Convert `CaptainApiModel` to JSON
  Map<String, dynamic> toJson() => _$CaptainApiModelToJson(this);
}

/// ✅ Vehicle Model
@JsonSerializable()
class VehicleModel {
  final String color;
  final String plate;
  final int capacity;
  final String vehicleType;

  VehicleModel({
    required this.color,
    required this.plate,
    required this.capacity,
    required this.vehicleType,
  });

  factory VehicleModel.fromJson(Map<String, dynamic> json) =>
      _$VehicleModelFromJson(json);

  Map<String, dynamic> toJson() => _$VehicleModelToJson(this);
}
