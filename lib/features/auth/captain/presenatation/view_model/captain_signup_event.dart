import 'package:equatable/equatable.dart';

abstract class CaptainSignupEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

class CaptainSignupRequested extends CaptainSignupEvent {
  final Map<String, dynamic> captainData;

  CaptainSignupRequested(this.captainData);

  @override
  List<Object?> get props => [captainData];
}
