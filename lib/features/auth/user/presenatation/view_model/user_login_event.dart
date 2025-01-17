abstract class UserLoginEvent {}

class UserLoginSubmit extends UserLoginEvent {
  final String phoneNumber;
  final String password;

  UserLoginSubmit({required this.phoneNumber, required this.password});
}
