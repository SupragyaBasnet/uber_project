abstract class UserSignupEvent {}

class UserSignupSubmit extends UserSignupEvent {
  final String firstName;
  final String lastName;
  final String phoneNumber;
  final String password;

  UserSignupSubmit({
    required this.firstName,
    required this.lastName,
    required this.phoneNumber,
    required this.password,
  });
}
