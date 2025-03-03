// forgot_password_hive_model.dart
import 'package:hive/hive.dart';

part 'forgot_password_hive_model.g.dart';

@HiveType(typeId: 0)
class ForgotPasswordHiveModel extends HiveObject {
  @HiveField(0)
  late String email;

  @HiveField(1)
  late String userType;

  @HiveField(2)
  String? otp;

  @HiveField(3)
  String? newPassword;

  @HiveField(4)
  String? confirmPassword;

  ForgotPasswordHiveModel({
    required this.email,
    required this.userType,
    this.otp,
    this.newPassword,
    this.confirmPassword,
  });

  factory ForgotPasswordHiveModel.fromJson(Map<String, dynamic> json) {
    return ForgotPasswordHiveModel(
      email: json["email"],
      userType: json["userType"],
      otp: json["otp"],
      newPassword: json["newPassword"],
      confirmPassword: json["confirmPassword"],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "email": email,
      "userType": userType,
      "otp": otp,
      "newPassword": newPassword,
      "confirmPassword": confirmPassword,
    };
  }
}
