abstract class UserLoginState {}

class UserLoginInitial extends UserLoginState {}

class UserLoginLoading extends UserLoginState {}

class UserLoginSuccess extends UserLoginState {}

class UserLoginError extends UserLoginState {
  final String errorMessage;

  UserLoginError(this.errorMessage);
}
