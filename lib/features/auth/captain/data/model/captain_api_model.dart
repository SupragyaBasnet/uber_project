import 'package:json_annotation/json_annotation.dart';
import '../../domain/entity/captain_entity.dart';

part 'captain_api_model.g.dart';

@JsonSerializable()
class CaptainApiModel {
  final String id;
  final String firstName;
  final String lastName;
  final String email;
  final String phoneNumber;
  final String vehicleType;
  final String vehiclePlate;
  final String vehicleName;
  final String vehicleCapacity;

  CaptainApiModel({
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

  factory CaptainApiModel.fromJson(Map<String, dynamic> json) =>
      _$CaptainApiModelFromJson(json);

  Map<String, dynamic> toJson() => _$CaptainApiModelToJson(this);

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
}
