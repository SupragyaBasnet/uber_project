// forgot_password_api_model.dart
import 'package:json_annotation/json_annotation.dart';

part 'forgot_password_api_model.g.dart';

@JsonSerializable()
class ForgotPasswordApiModel {
  final String email;
  final String userType;
  final String? otp;
  final String? newPassword;
  final String? confirmPassword;

  ForgotPasswordApiModel({
    required this.email,
    required this.userType,
    this.otp,
    this.newPassword,
    this.confirmPassword,
  });

  factory ForgotPasswordApiModel.fromJson(Map<String, dynamic> json) => _$ForgotPasswordApiModelFromJson(json);

  Map<String, dynamic> toJson() => _$ForgotPasswordApiModelToJson(this);
}
