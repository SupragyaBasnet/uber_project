import 'dart:io';
import 'package:equatable/equatable.dart';

abstract class CaptainSignupEvent extends Equatable {
  const CaptainSignupEvent();

  @override
  List<Object?> get props => [];
}

class CaptainSignupRequestEvent extends CaptainSignupEvent {
  final String firstname;
  final String lastname;
  final String phonenumber;
  final String email;
  final String password;
  final String vehicleColor;
  final String vehiclePlate;
  final String vehicleCapacity; // Kept as String (converted later)
  final String vehicleType;
  final File? image;

  const CaptainSignupRequestEvent({
    required this.firstname,
    required this.lastname,
    required this.phonenumber,
    required this.email,
    required this.password,
    required this.vehicleColor,
    required this.vehiclePlate,
    required this.vehicleCapacity,
    required this.vehicleType,
    this.image,
  });

  @override
  List<Object?> get props => [
    firstname,
    lastname,
    phonenumber,
    email,
    password,
    vehicleColor,
    vehiclePlate,
    vehicleCapacity,
    vehicleType,
    image,
  ];
}
