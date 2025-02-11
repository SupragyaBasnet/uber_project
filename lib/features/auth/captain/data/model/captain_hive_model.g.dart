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
      firstName: fields[1] as String,
      lastName: fields[2] as String,
      email: fields[3] as String,
      phoneNumber: fields[4] as String,
      vehicleType: fields[5] as String,
      vehiclePlate: fields[6] as String,
      vehicleName: fields[7] as String,
      vehicleCapacity: fields[8] as String,
    );
  }

  @override
  void write(BinaryWriter writer, CaptainHiveModel obj) {
    writer
      ..writeByte(9)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.firstName)
      ..writeByte(2)
      ..write(obj.lastName)
      ..writeByte(3)
      ..write(obj.email)
      ..writeByte(4)
      ..write(obj.phoneNumber)
      ..writeByte(5)
      ..write(obj.vehicleType)
      ..writeByte(6)
      ..write(obj.vehiclePlate)
      ..writeByte(7)
      ..write(obj.vehicleName)
      ..writeByte(8)
      ..write(obj.vehicleCapacity);
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
