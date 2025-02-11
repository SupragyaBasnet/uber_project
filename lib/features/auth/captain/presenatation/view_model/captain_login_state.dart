import 'package:equatable/equatable.dart';

abstract class CaptainLoginState extends Equatable {
  const CaptainLoginState();

  @override
  List<Object?> get props => [];
}

// Initial State
class CaptainLoginInitial extends CaptainLoginState {}

// Loading State (Show Progress Indicator)
class CaptainLoginLoading extends CaptainLoginState {}

// Success State (Captain Logged In Successfully)
class CaptainLoginSuccess extends CaptainLoginState {
  final String token;
  final String captainId;

  const CaptainLoginSuccess({
    required this.token,
    required this.captainId,
  });

  @override
  List<Object?> get props => [token, captainId];
}

// Failure State (API Error, Validation Error)
class CaptainLoginFailure extends CaptainLoginState {
  final String message;

  const CaptainLoginFailure({required this.message});

  @override
  List<Object?> get props => [message];
}
