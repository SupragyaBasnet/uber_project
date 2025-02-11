import 'package:freezed_annotation/freezed_annotation.dart';

part 'captain_dto.freezed.dart';
part 'captain_dto.g.dart';

@freezed
class CaptainDTO with _$CaptainDTO {
  factory CaptainDTO({
    required String id,
    required String firstName,
    required String lastName,
    required String email,
    required String phoneNumber,
    required String vehicleType,
    required String vehiclePlate,
    required String vehicleName,
    required String vehicleCapacity,
  }) = _CaptainDTO;

  factory CaptainDTO.fromJson(Map<String, dynamic> json) => _$CaptainDTOFromJson(json);
}
