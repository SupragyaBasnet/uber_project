import 'package:equatable/equatable.dart';

abstract class UserLoginState extends Equatable {
  @override
  List<Object?> get props => [];
}

class UserLoginInitial extends UserLoginState {}

class UserLoginLoading extends UserLoginState {}

class UserLoginSuccess extends UserLoginState {
  final Map<String, dynamic> userData;

  UserLoginSuccess(this.userData);

  @override
  List<Object?> get props => [userData];
}

class UserLoginFailure extends UserLoginState {
  final String error;

  UserLoginFailure(this.error);

  @override
  List<Object?> get props => [error];
}
