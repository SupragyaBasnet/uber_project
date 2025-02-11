import 'package:equatable/equatable.dart';

abstract class UserLoginEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

class UserLoginSubmitted extends UserLoginEvent {
  final String phonenumber;
  final String password;

  UserLoginSubmitted({required this.phonenumber, required this.password});

  @override
  List<Object?> get props => [phonenumber, password];
}
