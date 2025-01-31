// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'captain_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CaptainDTO _$CaptainDTOFromJson(Map<String, dynamic> json) => CaptainDTO(
      phonenumber: json['phonenumber'] as String,
      email: json['email'] as String,
      password: json['password'] as String,
      fullname: FullName.fromJson(json['fullname'] as Map<String, dynamic>),
      vehicle: Vehicle.fromJson(json['vehicle'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$CaptainDTOToJson(CaptainDTO instance) =>
    <String, dynamic>{
      'phonenumber': instance.phonenumber,
      'email': instance.email,
      'password': instance.password,
      'fullname': instance.fullname,
      'vehicle': instance.vehicle,
    };

FullName _$FullNameFromJson(Map<String, dynamic> json) => FullName(
      firstname: json['firstname'] as String,
      lastname: json['lastname'] as String,
    );

Map<String, dynamic> _$FullNameToJson(FullName instance) => <String, dynamic>{
      'firstname': instance.firstname,
      'lastname': instance.lastname,
    };

Vehicle _$VehicleFromJson(Map<String, dynamic> json) => Vehicle(
      color: json['color'] as String,
      plate: json['plate'] as String,
      capacity: (json['capacity'] as num).toInt(),
      vehicleType: json['vehicleType'] as String,
    );

Map<String, dynamic> _$VehicleToJson(Vehicle instance) => <String, dynamic>{
      'color': instance.color,
      'plate': instance.plate,
      'capacity': instance.capacity,
      'vehicleType': instance.vehicleType,
    };
