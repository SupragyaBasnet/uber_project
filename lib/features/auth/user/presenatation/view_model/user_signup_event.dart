import 'dart:io';
import 'package:equatable/equatable.dart';

abstract class UserSignupEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

class UserSignupRequestEvent extends UserSignupEvent {
  final String firstname;
  final String lastname;
  final String phonenumber;
  final String email;
  final String password;
  final File? image; // New Optional Image Field

  UserSignupRequestEvent({
    required this.firstname,
    required this.lastname,
    required this.phonenumber,
    required this.email,
    required this.password,
    this.image, // Optional Image Parameter
  });

  @override
  List<Object?> get props => [firstname, lastname, phonenumber, email, password, image];
}
