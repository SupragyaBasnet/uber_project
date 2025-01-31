import 'package:hive/hive.dart';

import 'forgot_password_api_model.dart';

part 'forgot_password_hive_model.g.dart';

@HiveType(typeId: 3) // Unique Hive Type ID
class ForgotPasswordHiveModel extends HiveObject {
  @HiveField(0)
  final String email;

  @HiveField(1)
  final String userType;

  @HiveField(2)
  final String otp;

  @HiveField(3)
  final String? newPassword;

  ForgotPasswordHiveModel({
    required this.email,
    required this.userType,
    required this.otp,
    this.newPassword,
  });

  /// Convert `ForgotPasswordApiModel` to `ForgotPasswordHiveModel`
  factory ForgotPasswordHiveModel.fromApiModel(ForgotPasswordApiModel apiModel) {
    return ForgotPasswordHiveModel(
      email: apiModel.email,
      userType: apiModel.userType,
      otp: apiModel.otp ?? '',
      newPassword: apiModel.newPassword,
    );
  }
}
