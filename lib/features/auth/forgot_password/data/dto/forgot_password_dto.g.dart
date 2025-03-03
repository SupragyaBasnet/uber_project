// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'forgot_password_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ForgotPasswordDTO _$ForgotPasswordDTOFromJson(Map<String, dynamic> json) =>
    ForgotPasswordDTO(
      email: json['email'] as String,
      userType: json['userType'] as String,
      otp: json['otp'] as String?,
      newPassword: json['newPassword'] as String?,
      confirmPassword: json['confirmPassword'] as String?,
    );

Map<String, dynamic> _$ForgotPasswordDTOToJson(ForgotPasswordDTO instance) =>
    <String, dynamic>{
      'email': instance.email,
      'userType': instance.userType,
      'otp': instance.otp,
      'newPassword': instance.newPassword,
      'confirmPassword': instance.confirmPassword,
    };
