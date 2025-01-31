class ForgotPasswordEntity {
  final String email;
  final String userType; // "user" or "captain"
  final String? otp;
  final String? newPassword;

  ForgotPasswordEntity({
    required this.email,
    required this.userType,
    this.otp,
    this.newPassword,
  });
}
