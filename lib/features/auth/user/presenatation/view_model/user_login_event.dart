import 'package:equatable/equatable.dart';

abstract class UserLoginEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

class UserLoginRequested extends UserLoginEvent {
  final Map<String, dynamic> credentials;

  UserLoginRequested(this.credentials);

  @override
  List<Object?> get props => [credentials];
}
