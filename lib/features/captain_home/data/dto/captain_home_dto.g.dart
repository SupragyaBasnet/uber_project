// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'captain_home_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CaptainDTO _$CaptainDTOFromJson(Map<String, dynamic> json) => CaptainDTO(
      id: json['id'] as String,
      fullname: json['fullname'] as String,
      phone: json['phone'] as String,
      profilePicture: json['profilePicture'] as String?,
      totalEarnings: (json['totalEarnings'] as num).toDouble(),
      rideCount: (json['rideCount'] as num).toInt(),
      totalDistance: (json['totalDistance'] as num).toDouble(),
      vehicleType: json['vehicleType'] as String?,
      isAvailable: json['isAvailable'] as bool,
      latitude: (json['latitude'] as num?)?.toDouble(),
      longitude: (json['longitude'] as num?)?.toDouble(),
    );

Map<String, dynamic> _$CaptainDTOToJson(CaptainDTO instance) =>
    <String, dynamic>{
      'id': instance.id,
      'fullname': instance.fullname,
      'phone': instance.phone,
      'profilePicture': instance.profilePicture,
      'totalEarnings': instance.totalEarnings,
      'rideCount': instance.rideCount,
      'totalDistance': instance.totalDistance,
      'vehicleType': instance.vehicleType,
      'isAvailable': instance.isAvailable,
      'latitude': instance.latitude,
      'longitude': instance.longitude,
    };
