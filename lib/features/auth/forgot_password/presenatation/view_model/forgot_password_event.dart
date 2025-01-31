import 'package:equatable/equatable.dart';

abstract class ForgotPasswordEvent extends Equatable {
  @override
  List<Object> get props => [];
}

/// **Step 1: Send OTP**
class SendOtpEvent extends ForgotPasswordEvent {
  final String email;
  final String userType;

  SendOtpEvent({required this.email, required this.userType});

  @override
  List<Object> get props => [email, userType];
}

/// **Step 2: Verify OTP**
class VerifyOtpEvent extends ForgotPasswordEvent {
  final String email;
  final String otp;

  VerifyOtpEvent({required this.email, required this.otp});

  @override
  List<Object> get props => [email, otp];
}

/// **Step 3: Reset Password**
class ResetPasswordEvent extends ForgotPasswordEvent {
  final String email;
  final String otp;
  final String newPassword;
  final String confirmPassword; // ✅ Fixed missing confirmPassword
  final String userType;

  ResetPasswordEvent({
    required this.email,
    required this.otp,
    required this.newPassword,
    required this.confirmPassword, // ✅ Added confirmPassword
    required this.userType,
  });

  @override
  List<Object> get props => [email, otp, newPassword, confirmPassword, userType];
}
