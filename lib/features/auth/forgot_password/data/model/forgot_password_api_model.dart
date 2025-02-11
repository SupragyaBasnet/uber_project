import 'package:json_annotation/json_annotation.dart';

part 'forgot_password_api_model.g.dart';

/// Model for sending Forgot Password API request
@JsonSerializable()
class ForgotPasswordApiModel {
  final String email;
  final String userType;
  final String? otp;
  final String? newPassword;

  ForgotPasswordApiModel({
    required this.email,
    required this.userType,
    this.otp,
    this.newPassword,
  });

  /// Convert JSON to `ForgotPasswordApiModel`
  factory ForgotPasswordApiModel.fromJson(Map<String, dynamic> json) =>
      _$ForgotPasswordApiModelFromJson(json);

  /// Convert `ForgotPasswordApiModel` to JSON
  Map<String, dynamic> toJson() => _$ForgotPasswordApiModelToJson(this);
}
