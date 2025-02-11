import 'package:hive/hive.dart';
import 'package:json_annotation/json_annotation.dart';

part 'user_api_model.g.dart';

@HiveType(typeId: 0)
@JsonSerializable()
class UserApiModel extends HiveObject {
  @HiveField(0)
  final String id;

  @HiveField(1)
  final String email;

  @HiveField(2)
  final String phonenumber;

  @HiveField(3)
  final String fullname;

  @HiveField(4)
  final String token;

  UserApiModel({
    required this.id,
    required this.email,
    required this.phonenumber,
    required this.fullname,
    required this.token,
  });

  /// Convert JSON to `UserApiModel`
  factory UserApiModel.fromJson(Map<String, dynamic> json) =>
      _$UserApiModelFromJson(json);

  /// Convert `UserApiModel` to JSON
  Map<String, dynamic> toJson() => _$UserApiModelToJson(this);
}
