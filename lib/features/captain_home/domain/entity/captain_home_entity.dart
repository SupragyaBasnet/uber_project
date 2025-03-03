import 'package:equatable/equatable.dart';

class CaptainHomeEntity extends Equatable {
  final String id;
  final String firstName;
  final String lastName;
  final String phoneNumber;
  final String email;
  final String profilePicture;
  final String licensePicture;
  final String theme;
  final double totalEarnings;
  final int rideCount;
  final double totalDistance;
  final String vehicleName;
  final String vehiclePlate;
  final String vehicleType;
  final int vehicleCapacity;

  const CaptainHomeEntity({
    required this.id,
    required this.firstName,
    required this.lastName,
    required this.phoneNumber,
    required this.email,
    required this.profilePicture,
    required this.licensePicture,
    required this.theme,
    required this.totalEarnings,
    required this.rideCount,
    required this.totalDistance,
    required this.vehicleName,
    required this.vehiclePlate,
    required this.vehicleType,
    required this.vehicleCapacity,
  });

  /// ✅ **Factory method to create `CaptainHomeEntity` from JSON**
  factory CaptainHomeEntity.fromJson(Map<String, dynamic> json) {
    return CaptainHomeEntity(
      id: json['id'] ?? '',
      firstName: json['firstName'] ?? 'Unknown',
      lastName: json['lastName'] ?? 'Unknown',
      phoneNumber: json['phoneNumber'] ?? '',
      email: json['email'] ?? '',
      profilePicture: json['profilePicture'] ?? "",
      licensePicture: json['licensePicture'] ?? "",
      theme: json['theme'] ?? "light",
      totalEarnings: (json['totalEarnings'] ?? 0.0).toDouble(),
      rideCount: (json['rideCount'] ?? 0),
      totalDistance: (json['totalDistance'] ?? 0.0).toDouble(),
      vehicleName: json['vehicleName'] ?? "Unknown",
      vehiclePlate: json['vehiclePlate'] ?? "Unknown",
      vehicleType: json['vehicleType'] ?? "Unknown",
      vehicleCapacity: (json['vehicleCapacity'] ?? 0),
    );
  }

  /// ✅ **Convert `CaptainHomeEntity` to JSON**
  Map<String, dynamic> toJson() {
    return {
      "id": id,
      "firstName": firstName,
      "lastName": lastName,
      "phoneNumber": phoneNumber,
      "email": email,
      "profilePicture": profilePicture,
      "licensePicture": licensePicture,
      "theme": theme,
      "totalEarnings": totalEarnings,
      "rideCount": rideCount,
      "totalDistance": totalDistance,
      "vehicleName": vehicleName,
      "vehiclePlate": vehiclePlate,
      "vehicleType": vehicleType,
      "vehicleCapacity": vehicleCapacity,
    };
  }

  /// ✅ **`copyWith` method to update only certain fields**
  CaptainHomeEntity copyWith({
    String? id,
    String? firstName,
    String? lastName,
    String? phoneNumber,
    String? email,
    String? profilePicture,
    String? licensePicture,
    String? theme,
    double? totalEarnings,
    int? rideCount,
    double? totalDistance,
    String? vehicleName,
    String? vehiclePlate,
    String? vehicleType,
    int? vehicleCapacity,
  }) {
    return CaptainHomeEntity(
      id: id ?? this.id,
      firstName: firstName ?? this.firstName,
      lastName: lastName ?? this.lastName,
      phoneNumber: phoneNumber ?? this.phoneNumber,
      email: email ?? this.email,
      profilePicture: profilePicture ?? this.profilePicture,
      licensePicture: licensePicture ?? this.licensePicture,
      theme: theme ?? this.theme,
      totalEarnings: totalEarnings ?? this.totalEarnings,
      rideCount: rideCount ?? this.rideCount,
      totalDistance: totalDistance ?? this.totalDistance,
      vehicleName: vehicleName ?? this.vehicleName,
      vehiclePlate: vehiclePlate ?? this.vehiclePlate,
      vehicleType: vehicleType ?? this.vehicleType,
      vehicleCapacity: vehicleCapacity ?? this.vehicleCapacity,
    );
  }

  /// ✅ **Equatable - Allows easy comparison in Bloc**
  @override
  List<Object?> get props => [
    id,
    firstName,
    lastName,
    phoneNumber,
    email,
    profilePicture,
    licensePicture,
    theme,
    totalEarnings,
    rideCount,
    totalDistance,
    vehicleName,
    vehiclePlate,
    vehicleType,
    vehicleCapacity,
  ];
}
