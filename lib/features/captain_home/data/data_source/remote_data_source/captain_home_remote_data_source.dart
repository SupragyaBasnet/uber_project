import 'package:dio/dio.dart';
import '../../../../auth/captain/data/dto/captain_dto.dart';


class CaptainHomeRemoteDataSource {
  final Dio dio;

  CaptainHomeRemoteDataSource({required this.dio});

  // ✅ Fetch Captain Details
  Future<CaptainDTO> fetchCaptainDetails(String captainId) async {
    final response = await dio.get('/captains/$captainId');

    if (response.statusCode == 200) {
      return CaptainDTO.fromJson(response.data);
    } else {
      throw Exception("Failed to fetch captain details");
    }
  }

  // ✅ Update Captain Availability
  Future<void> updateAvailability(String captainId, bool isAvailable) async {
    await dio.patch('/captains/$captainId/availability', data: {'isAvailable': isAvailable});
  }

  // ✅ Update Captain Location
  Future<void> updateLocation(String captainId, double latitude, double longitude) async {
    await dio.patch('/captains/$captainId/location', data: {
      'latitude': latitude,
      'longitude': longitude,
    });
  }
}
