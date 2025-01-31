// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'captain_hive_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class CaptainHiveModelAdapter extends TypeAdapter<CaptainHiveModel> {
  @override
  final int typeId = 1;

  @override
  CaptainHiveModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return CaptainHiveModel(
      id: fields[0] as String,
      email: fields[1] as String,
      phonenumber: fields[2] as String,
      firstname: fields[3] as String,
      lastname: fields[4] as String,
      password: fields[5] as String,
      token: fields[6] as String,
      vehicle: fields[7] as VehicleModel,
    );
  }

  @override
  void write(BinaryWriter writer, CaptainHiveModel obj) {
    writer
      ..writeByte(8)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.email)
      ..writeByte(2)
      ..write(obj.phonenumber)
      ..writeByte(3)
      ..write(obj.firstname)
      ..writeByte(4)
      ..write(obj.lastname)
      ..writeByte(5)
      ..write(obj.password)
      ..writeByte(6)
      ..write(obj.token)
      ..writeByte(7)
      ..write(obj.vehicle);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is CaptainHiveModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
