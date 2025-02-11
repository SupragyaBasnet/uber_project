// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'forgot_password_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ForgotPasswordDTO _$ForgotPasswordDTOFromJson(Map<String, dynamic> json) =>
    ForgotPasswordDTO(
      email: json['email'] as String,
      userType: json['userType'] as String,
    );

Map<String, dynamic> _$ForgotPasswordDTOToJson(ForgotPasswordDTO instance) =>
    <String, dynamic>{
      'email': instance.email,
      'userType': instance.userType,
    };

VerifyOtpDTO _$VerifyOtpDTOFromJson(Map<String, dynamic> json) => VerifyOtpDTO(
      email: json['email'] as String,
      otp: json['otp'] as String,
    );

Map<String, dynamic> _$VerifyOtpDTOToJson(VerifyOtpDTO instance) =>
    <String, dynamic>{
      'email': instance.email,
      'otp': instance.otp,
    };

ResetPasswordDTO _$ResetPasswordDTOFromJson(Map<String, dynamic> json) =>
    ResetPasswordDTO(
      email: json['email'] as String,
      otp: json['otp'] as String,
      password: json['password'] as String,
      userType: json['userType'] as String,
    );

Map<String, dynamic> _$ResetPasswordDTOToJson(ResetPasswordDTO instance) =>
    <String, dynamic>{
      'email': instance.email,
      'otp': instance.otp,
      'password': instance.password,
      'userType': instance.userType,
    };
