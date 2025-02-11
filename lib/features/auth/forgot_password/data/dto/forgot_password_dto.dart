import 'package:json_annotation/json_annotation.dart';

part 'forgot_password_dto.g.dart';

@JsonSerializable()
class ForgotPasswordDTO {
  final String email;
  final String userType;

  ForgotPasswordDTO({
    required this.email,
    required this.userType,
  });

  /// Factory method to create an instance from JSON
  factory ForgotPasswordDTO.fromJson(Map<String, dynamic> json) =>
      _$ForgotPasswordDTOFromJson(json);

  /// Method to convert instance to JSON
  Map<String, dynamic> toJson() => _$ForgotPasswordDTOToJson(this);
}

/// OTP Verification DTO
@JsonSerializable()
class VerifyOtpDTO {
  final String email;
  final String otp;

  VerifyOtpDTO({
    required this.email,
    required this.otp,
  });

  factory VerifyOtpDTO.fromJson(Map<String, dynamic> json) =>
      _$VerifyOtpDTOFromJson(json);

  Map<String, dynamic> toJson() => _$VerifyOtpDTOToJson(this);
}

/// Reset Password DTO
@JsonSerializable()
class ResetPasswordDTO {
  final String email;
  final String otp;
  final String password;
  final String userType;

  ResetPasswordDTO({
    required this.email,
    required this.otp,
    required this.password,
    required this.userType,
  });

  factory ResetPasswordDTO.fromJson(Map<String, dynamic> json) =>
      _$ResetPasswordDTOFromJson(json);

  Map<String, dynamic> toJson() => _$ResetPasswordDTOToJson(this);
}
