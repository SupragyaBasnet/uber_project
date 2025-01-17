abstract class CaptainLoginEvent {}

class CaptainLoginSubmit extends CaptainLoginEvent {
  final String phoneNumber;
  final String password;

  CaptainLoginSubmit({
    required this.phoneNumber,
    required this.password,
  });
}
