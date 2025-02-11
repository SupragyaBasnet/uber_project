// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'captain_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$CaptainDTOImpl _$$CaptainDTOImplFromJson(Map<String, dynamic> json) =>
    _$CaptainDTOImpl(
      id: json['id'] as String,
      firstName: json['firstName'] as String,
      lastName: json['lastName'] as String,
      email: json['email'] as String,
      phoneNumber: json['phoneNumber'] as String,
      vehicleType: json['vehicleType'] as String,
      vehiclePlate: json['vehiclePlate'] as String,
      vehicleName: json['vehicleName'] as String,
      vehicleCapacity: json['vehicleCapacity'] as String,
    );

Map<String, dynamic> _$$CaptainDTOImplToJson(_$CaptainDTOImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'firstName': instance.firstName,
      'lastName': instance.lastName,
      'email': instance.email,
      'phoneNumber': instance.phoneNumber,
      'vehicleType': instance.vehicleType,
      'vehiclePlate': instance.vehiclePlate,
      'vehicleName': instance.vehicleName,
      'vehicleCapacity': instance.vehicleCapacity,
    };
