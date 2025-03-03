// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'captain_home_hive_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class CaptainHomeHiveModelAdapter extends TypeAdapter<CaptainHomeHiveModel> {
  @override
  final int typeId = 0;

  @override
  CaptainHomeHiveModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return CaptainHomeHiveModel(
      id: fields[0] as String,
      firstName: fields[1] as String,
      lastName: fields[2] as String,
      phoneNumber: fields[3] as String,
      email: fields[4] as String,
      profilePicture: fields[5] as String,
      licensePicture: fields[6] as String,
      theme: fields[7] as String,
      totalEarnings: fields[8] as double,
      rideCount: fields[9] as int,
      totalDistance: fields[10] as double,
      vehicleName: fields[11] as String,
      vehiclePlate: fields[12] as String,
      vehicleType: fields[13] as String,
      vehicleCapacity: fields[14] as int,
    );
  }

  @override
  void write(BinaryWriter writer, CaptainHomeHiveModel obj) {
    writer
      ..writeByte(15)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.firstName)
      ..writeByte(2)
      ..write(obj.lastName)
      ..writeByte(3)
      ..write(obj.phoneNumber)
      ..writeByte(4)
      ..write(obj.email)
      ..writeByte(5)
      ..write(obj.profilePicture)
      ..writeByte(6)
      ..write(obj.licensePicture)
      ..writeByte(7)
      ..write(obj.theme)
      ..writeByte(8)
      ..write(obj.totalEarnings)
      ..writeByte(9)
      ..write(obj.rideCount)
      ..writeByte(10)
      ..write(obj.totalDistance)
      ..writeByte(11)
      ..write(obj.vehicleName)
      ..writeByte(12)
      ..write(obj.vehiclePlate)
      ..writeByte(13)
      ..write(obj.vehicleType)
      ..writeByte(14)
      ..write(obj.vehicleCapacity);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is CaptainHomeHiveModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
