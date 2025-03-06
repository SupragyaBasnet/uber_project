import 'dart:convert';
import 'package:http/http.dart' as http;
import '../../domain/models/ride_fare.dart';

class RideService {
  final String baseUrl = "http://10.0.2.2:4000";
  final Map<String, String> _headers = {
    'Authorization':
        "Bearer eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJfaWQiOiI2N2IyZmJhY2RmZTdjODMwMDgyODIxMmYiLCJwaG9uZW51bWJlciI6IjEyMzQ1Njc4OTkiLCJpYXQiOjE3NDEyMzgxODQsImV4cCI6MTc0MTMyNDU4NH0.i7HprHiwW3zyzsHHqXfc6Ma-UxNRHp5LoyRR54EoMFE"
  };

  Future<RideFare> getRideFare(String pickup, String destination) async {
    final encodedPickup = Uri.encodeComponent(pickup);
    final encodedDestination = Uri.encodeComponent(destination);

    final url =
        '$baseUrl/rides/get-fare?pickup=$encodedPickup&destination=$encodedDestination';

    final response = await http.get(Uri.parse(url), headers: _headers);

    if (response.statusCode == 200) {
      return RideFare.fromJson(json.decode(response.body));
    } else {
      throw Exception('Failed to load ride fare: ${response.statusCode}');
    }
  }

  Future<Map<String, dynamic>> createRide({
    required String pickup,
    required String destination,
    required String vehicleType,
  }) async {
    final url = '$baseUrl/rides/create';

    final Map<String, dynamic> requestBody = {
      'pickup': pickup,
      'destination': destination,
      'vehicleType': vehicleType,
    };

    print('Creating ride with data: $requestBody');

    try {
      final response = await http.post(
        Uri.parse(url),
        headers: {
          ..._headers,
        },
        body: json.encode(requestBody),
      );

      print('Response status: ${response.statusCode}');
      print('Response body: ${response.body}');

      if (response.statusCode == 200 || response.statusCode == 201) {
        return json.decode(response.body);
      } else {
        // Try to parse error message from response body
        Map<String, dynamic>? errorResponse;
        try {
          errorResponse = json.decode(response.body);
        } catch (e) {
          // If can't parse JSON, use raw body
        }

        final errorMessage =
            errorResponse != null && errorResponse.containsKey('message')
                ? errorResponse['message']
                : 'Server returned ${response.statusCode}';

        throw Exception('Failed to create ride: $errorMessage');
      }
    } catch (e) {
      print('Error creating ride: $e');
      throw Exception('Failed to create ride: $e');
    }
  }
}
