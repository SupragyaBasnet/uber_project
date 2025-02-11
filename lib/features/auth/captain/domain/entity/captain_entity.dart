import 'package:equatable/equatable.dart';

class CaptainEntity extends Equatable {
  final String id;
  final String firstName;
  final String lastName;
  final String email;
  final String phoneNumber;
  final String vehicleName;
  final String vehiclePlate;
  final String vehicleCapacity;
  final String vehicleType;

  const CaptainEntity({
    required this.id,
    required this.firstName,
    required this.lastName,
    required this.email,
    required this.phoneNumber,
    required this.vehicleName,
    required this.vehiclePlate,
    required this.vehicleCapacity,
    required this.vehicleType,
  });

  Map<String, dynamic> toMap() {
    return {
      "id": id,
      "fullname": {
        "firstname": firstName,
        "lastname": lastName,
      },
      "email": email,
      "phonenumber": phoneNumber,
      "vehicle": {
        "name": vehicleName,
        "plate": vehiclePlate,
        "capacity": vehicleCapacity,
        "vehicleType": vehicleType,
      }
    };
  }

  factory CaptainEntity.fromMap(Map<String, dynamic> map) {
    return CaptainEntity(
      id: map["id"] ?? "",
      firstName: map["fullname"]["firstname"] ?? "",
      lastName: map["fullname"]["lastname"] ?? "",
      email: map["email"] ?? "",
      phoneNumber: map["phonenumber"] ?? "",
      vehicleName: map["vehicle"]["name"] ?? "",
      vehiclePlate: map["vehicle"]["plate"] ?? "",
      vehicleCapacity: map["vehicle"]["capacity"] ?? "",
      vehicleType: map["vehicle"]["vehicleType"] ?? "",
    );
  }

  @override
  List<Object?> get props => [
    id,
    firstName,
    lastName,
    email,
    phoneNumber,
    vehicleName,
    vehiclePlate,
    vehicleCapacity,
    vehicleType,
  ];
}
