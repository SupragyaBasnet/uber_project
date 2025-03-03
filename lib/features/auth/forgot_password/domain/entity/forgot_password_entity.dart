// forgot_password_entity.dart
class ForgotPasswordEntity {
  final String email;
  final String userType;
  final String? otp;
  final String? newPassword;
  final String? confirmPassword;

  ForgotPasswordEntity({
    required this.email,
    required this.userType,
    this.otp,
    this.newPassword,
    this.confirmPassword,
  });
}
