import 'package:equatable/equatable.dart';

abstract class UserSignupState extends Equatable {
  @override
  List<Object?> get props => [];
}

class UserSignupInitial extends UserSignupState {}

class UserSignupLoading extends UserSignupState {}

class UserSignupSuccess extends UserSignupState {}

class UserSignupFailure extends UserSignupState {
  final String message;

  UserSignupFailure(this.message);

  @override
  List<Object?> get props => [message];
}
