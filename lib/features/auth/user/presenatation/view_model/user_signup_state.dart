import 'package:equatable/equatable.dart';

abstract class UserSignupState extends Equatable {
  @override
  List<Object?> get props => [];
}

class UserSignupInitial extends UserSignupState {}

class UserSignupLoading extends UserSignupState {}

class UserSignupSuccess extends UserSignupState {
  final Map<String, dynamic> userData;

  UserSignupSuccess(this.userData);

  @override
  List<Object?> get props => [userData];
}

class UserSignupFailure extends UserSignupState {
  final String error;

  UserSignupFailure(this.error);

  @override
  List<Object?> get props => [error];
}
