import 'package:equatable/equatable.dart';

class UserEntity extends Equatable {
  final String id;
  final String firstName;
  final String lastName;
  final String email;
  final String phoneNumber;
  final String token;

  const UserEntity({
    required this.id,
    required this.firstName,
    required this.lastName,
    required this.email,
    required this.phoneNumber,
    required this.token,
  });

  @override
  List<Object?> get props => [id, firstName, lastName, email, phoneNumber, token];

  Map<String, dynamic> toMap() {
    return {
      "id": id,
      "fullname": {
        "firstname": firstName,
        "lastname": lastName,
      },
      "email": email,
      "phonenumber": phoneNumber,
      "token": token,
    };
  }

  factory UserEntity.fromMap(Map<String, dynamic> map) {
    return UserEntity(
      id: map["id"] ?? "",
      firstName: map["fullname"]["firstname"] ?? "",
      lastName: map["fullname"]["lastname"] ?? "",
      email: map["email"] ?? "",
      phoneNumber: map["phonenumber"] ?? "",
      token: map["token"] ?? "",
    );
  }
}
