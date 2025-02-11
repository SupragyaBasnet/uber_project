import 'package:equatable/equatable.dart';

abstract class UserSignupEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

class UserSignupRequested extends UserSignupEvent {
  final Map<String, dynamic> userData;

  UserSignupRequested(this.userData);

  @override
  List<Object?> get props => [userData];
}
