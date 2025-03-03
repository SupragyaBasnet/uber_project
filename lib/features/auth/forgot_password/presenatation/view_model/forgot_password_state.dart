part of 'forgot_password_bloc.dart';

abstract class ForgotPasswordState extends Equatable {
  @override
  List<Object> get props => [];
}

class ForgotPasswordInitial extends ForgotPasswordState {}

class ForgotPasswordLoading extends ForgotPasswordState {}

class OtpSentState extends ForgotPasswordState {
  final String message;
  OtpSentState(this.message);
}

class OtpVerifiedState extends ForgotPasswordState {
  final String message;
  OtpVerifiedState(this.message);
}

class PasswordResetSuccess extends ForgotPasswordState {
  final String message;
  PasswordResetSuccess(this.message);
}

class ForgotPasswordError extends ForgotPasswordState {
  final String error;
  ForgotPasswordError(this.error);
}
