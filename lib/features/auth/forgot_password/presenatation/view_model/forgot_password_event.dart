part of 'forgot_password_bloc.dart';

abstract class ForgotPasswordEvent extends Equatable {
  const ForgotPasswordEvent();

  @override
  List<Object> get props => [];
}

// ✅ Send OTP Event
class SendOtpEvent extends ForgotPasswordEvent {
  final String email;
  final String userType; // ✅ Added userType

  const SendOtpEvent(this.email, this.userType);

  @override
  List<Object> get props => [email, userType];
}

// ✅ Verify OTP Event (Fixed)
class VerifyOtpEvent extends ForgotPasswordEvent {
  final String email;
  final String otp;
  final String userType; // ✅ Added userType

  const VerifyOtpEvent(this.email, this.otp, this.userType);

  @override
  List<Object> get props => [email, otp, userType]; // ✅ Added userType
}

// ✅ Reset Password Event
class ResetPasswordEvent extends ForgotPasswordEvent {
  final String email;
  final String otp;
  final String newPassword;
  final String confirmPassword;
  final String userType; // ✅ Added userType

  const ResetPasswordEvent(this.email, this.otp, this.newPassword, this.confirmPassword, this.userType);

  @override
  List<Object> get props => [email, otp, newPassword, confirmPassword, userType]; // ✅ Added userType
}
