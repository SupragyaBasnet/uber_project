// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'captain_api_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CaptainApiModel _$CaptainApiModelFromJson(Map<String, dynamic> json) =>
    CaptainApiModel(
      id: json['id'] as String,
      email: json['email'] as String,
      phonenumber: json['phonenumber'] as String,
      firstname: json['firstname'] as String,
      lastname: json['lastname'] as String,
      password: json['password'] as String,
      token: json['token'] as String,
      vehicle: VehicleModel.fromJson(json['vehicle'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$CaptainApiModelToJson(CaptainApiModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'email': instance.email,
      'phonenumber': instance.phonenumber,
      'firstname': instance.firstname,
      'lastname': instance.lastname,
      'password': instance.password,
      'token': instance.token,
      'vehicle': instance.vehicle,
    };

VehicleModel _$VehicleModelFromJson(Map<String, dynamic> json) => VehicleModel(
      color: json['color'] as String,
      plate: json['plate'] as String,
      capacity: (json['capacity'] as num).toInt(),
      vehicleType: json['vehicleType'] as String,
    );

Map<String, dynamic> _$VehicleModelToJson(VehicleModel instance) =>
    <String, dynamic>{
      'color': instance.color,
      'plate': instance.plate,
      'capacity': instance.capacity,
      'vehicleType': instance.vehicleType,
    };
