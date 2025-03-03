// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'captain_home_api_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CaptainApiModel _$CaptainApiModelFromJson(Map<String, dynamic> json) =>
    CaptainApiModel(
      id: json['id'] as String,
      firstName: json['firstName'] as String,
      lastName: json['lastName'] as String,
      phoneNumber: json['phoneNumber'] as String,
      email: json['email'] as String,
      profilePicture: json['profilePicture'] as String?,
      licensePicture: json['licensePicture'] as String?,
      theme: json['theme'] as String?,
      totalEarnings: (json['totalEarnings'] as num?)?.toDouble(),
      rideCount: (json['rideCount'] as num?)?.toInt(),
      totalDistance: (json['totalDistance'] as num?)?.toDouble(),
      vehicleName: json['vehicleName'] as String?,
      vehiclePlate: json['vehiclePlate'] as String?,
      vehicleType: json['vehicleType'] as String?,
      vehicleCapacity: (json['vehicleCapacity'] as num?)?.toInt(),
    );

Map<String, dynamic> _$CaptainApiModelToJson(CaptainApiModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'firstName': instance.firstName,
      'lastName': instance.lastName,
      'phoneNumber': instance.phoneNumber,
      'email': instance.email,
      'profilePicture': instance.profilePicture,
      'licensePicture': instance.licensePicture,
      'theme': instance.theme,
      'totalEarnings': instance.totalEarnings,
      'rideCount': instance.rideCount,
      'totalDistance': instance.totalDistance,
      'vehicleName': instance.vehicleName,
      'vehiclePlate': instance.vehiclePlate,
      'vehicleType': instance.vehicleType,
      'vehicleCapacity': instance.vehicleCapacity,
    };
