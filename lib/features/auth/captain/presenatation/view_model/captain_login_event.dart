import 'package:equatable/equatable.dart';

abstract class CaptainLoginEvent extends Equatable {
  const CaptainLoginEvent();

  @override
  List<Object?> get props => [];
}

// Event for Captain Login
class CaptainLoginRequestEvent extends CaptainLoginEvent {
  final String phonenumber;
  final String password;

  const CaptainLoginRequestEvent({
    required this.phonenumber,
    required this.password,
  });

  @override
  List<Object?> get props => [phonenumber, password];
}
