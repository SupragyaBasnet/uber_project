// captain_signup_state.dart
abstract class CaptainSignupState {}

class CaptainSignupInitial extends CaptainSignupState {}

class CaptainSignupLoading extends CaptainSignupState {}

class CaptainSignupSuccess extends CaptainSignupState {}

class CaptainSignupError extends CaptainSignupState {
  final String errorMessage;

  CaptainSignupError(this.errorMessage);
}
