// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'forgot_password_api_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ForgotPasswordApiModel _$ForgotPasswordApiModelFromJson(
        Map<String, dynamic> json) =>
    ForgotPasswordApiModel(
      email: json['email'] as String,
      userType: json['userType'] as String,
      otp: json['otp'] as String?,
      newPassword: json['newPassword'] as String?,
    );

Map<String, dynamic> _$ForgotPasswordApiModelToJson(
        ForgotPasswordApiModel instance) =>
    <String, dynamic>{
      'email': instance.email,
      'userType': instance.userType,
      'otp': instance.otp,
      'newPassword': instance.newPassword,
    };
