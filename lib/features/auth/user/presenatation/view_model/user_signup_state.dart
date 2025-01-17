abstract class UserSignupState {}

class UserSignupInitial extends UserSignupState {}

class UserSignupLoading extends UserSignupState {}

class UserSignupSuccess extends UserSignupState {}

class UserSignupError extends UserSignupState {
  final String errorMessage;

  UserSignupError(this.errorMessage);
}
