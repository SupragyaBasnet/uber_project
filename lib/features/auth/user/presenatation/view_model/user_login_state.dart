import 'package:equatable/equatable.dart';

abstract class UserLoginState extends Equatable {
  @override
  List<Object?> get props => [];
}

class UserLoginInitial extends UserLoginState {}

class UserLoginLoading extends UserLoginState {}

class UserLoginSuccess extends UserLoginState {
  final String token;
  final String userId;

  UserLoginSuccess({required this.token, required this.userId});

  @override
  List<Object?> get props => [token, userId];
}

class UserLoginFailure extends UserLoginState {
  final String message;

  UserLoginFailure({required this.message});

  @override
  List<Object?> get props => [message];
}
