// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'forgot_password_hive_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class ForgotPasswordHiveModelAdapter
    extends TypeAdapter<ForgotPasswordHiveModel> {
  @override
  final int typeId = 0;

  @override
  ForgotPasswordHiveModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return ForgotPasswordHiveModel(
      email: fields[0] as String,
      userType: fields[1] as String,
      otp: fields[2] as String?,
      newPassword: fields[3] as String?,
      confirmPassword: fields[4] as String?,
    );
  }

  @override
  void write(BinaryWriter writer, ForgotPasswordHiveModel obj) {
    writer
      ..writeByte(5)
      ..writeByte(0)
      ..write(obj.email)
      ..writeByte(1)
      ..write(obj.userType)
      ..writeByte(2)
      ..write(obj.otp)
      ..writeByte(3)
      ..write(obj.newPassword)
      ..writeByte(4)
      ..write(obj.confirmPassword);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is ForgotPasswordHiveModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
