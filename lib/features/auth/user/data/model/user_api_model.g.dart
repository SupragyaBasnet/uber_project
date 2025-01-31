// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_api_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class UserApiModelAdapter extends TypeAdapter<UserApiModel> {
  @override
  final int typeId = 0;

  @override
  UserApiModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return UserApiModel(
      id: fields[0] as String,
      email: fields[1] as String,
      phonenumber: fields[2] as String,
      fullname: fields[3] as String,
      token: fields[4] as String,
    );
  }

  @override
  void write(BinaryWriter writer, UserApiModel obj) {
    writer
      ..writeByte(5)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.email)
      ..writeByte(2)
      ..write(obj.phonenumber)
      ..writeByte(3)
      ..write(obj.fullname)
      ..writeByte(4)
      ..write(obj.token);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is UserApiModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UserApiModel _$UserApiModelFromJson(Map<String, dynamic> json) => UserApiModel(
      id: json['id'] as String,
      email: json['email'] as String,
      phonenumber: json['phonenumber'] as String,
      fullname: json['fullname'] as String,
      token: json['token'] as String,
    );

Map<String, dynamic> _$UserApiModelToJson(UserApiModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'email': instance.email,
      'phonenumber': instance.phonenumber,
      'fullname': instance.fullname,
      'token': instance.token,
    };
