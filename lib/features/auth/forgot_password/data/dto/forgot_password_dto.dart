
import 'package:json_annotation/json_annotation.dart';

part 'forgot_password_dto.g.dart';

@JsonSerializable()
class ForgotPasswordDTO {
  final String email;
  final String userType;
  final String? otp;
  final String? newPassword;
  final String? confirmPassword;

  ForgotPasswordDTO({
    required this.email,
    required this.userType,
    this.otp,
    this.newPassword,
    this.confirmPassword,
  });

  factory ForgotPasswordDTO.fromJson(Map<String, dynamic> json) => _$ForgotPasswordDTOFromJson(json);

  Map<String, dynamic> toJson() => _$ForgotPasswordDTOToJson(this);
}
