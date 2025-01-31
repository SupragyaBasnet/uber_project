import 'package:equatable/equatable.dart';

abstract class CaptainSignupState extends Equatable {
  const CaptainSignupState();

  @override
  List<Object?> get props => [];
}

// Initial State
class CaptainSignupInitial extends CaptainSignupState {}

// Loading State (Show Progress Indicator)
class CaptainSignupLoading extends CaptainSignupState {}

// Success State (Captain Signed Up Successfully)
class CaptainSignupSuccess extends CaptainSignupState {}

// Failure State (API Error, Validation Error)
class CaptainSignupFailure extends CaptainSignupState {
  final String message;

  const CaptainSignupFailure(this.message);

  @override
  List<Object?> get props => [message];
}
