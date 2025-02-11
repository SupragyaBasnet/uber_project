import 'package:equatable/equatable.dart';

abstract class ForgotPasswordState extends Equatable {
  @override
  List<Object> get props => [];
}

/// **Initial State**
class ForgotPasswordInitial extends ForgotPasswordState {}

/// **Loading State**
class ForgotPasswordLoading extends ForgotPasswordState {}

/// **Success State**
class ForgotPasswordSuccess extends ForgotPasswordState {
  final String message;
  final int nextStep;

  ForgotPasswordSuccess({required this.message, required this.nextStep});

  @override
  List<Object> get props => [message, nextStep];
}

/// **Failure State**
class ForgotPasswordFailure extends ForgotPasswordState {
  final String message;

  ForgotPasswordFailure(this.message);

  @override
  List<Object> get props => [message];
}
