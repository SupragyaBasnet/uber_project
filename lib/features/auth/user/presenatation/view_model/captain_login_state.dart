abstract class CaptainLoginState {}

class CaptainLoginInitial extends CaptainLoginState {}

class CaptainLoginLoading extends CaptainLoginState {}

class CaptainLoginSuccess extends CaptainLoginState {}

class CaptainLoginError extends CaptainLoginState {
  final String errorMessage;

  CaptainLoginError(this.errorMessage);
}
