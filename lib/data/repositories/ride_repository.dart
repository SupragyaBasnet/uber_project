import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/ride_model.dart';
import '../../core/constants.dart';

class RideRepository {
  /// Fetch all rides
  Future<List<Ride>> getRides() async {
    try {
      final response = await http.get(
        Uri.parse(ApiConstants.getRidesEndpoint),
        headers: {'Content-Type': 'application/json'},
      );

      if (response.statusCode == 200) {
        List<dynamic> data = jsonDecode(response.body);
        return data.map((ride) => Ride.fromJson(ride)).toList();
      } else {
        throw Exception('Failed to load rides: ${response.body}');
      }
    } catch (e) {
      throw Exception('Error fetching rides: $e');
    }
  }

  /// Book a new ride
  Future<Ride> bookRide(Map<String, dynamic> rideData) async {
    try {
      final response = await http.post(
        Uri.parse(ApiConstants.bookRideEndpoint),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode(rideData),
      );

      if (response.statusCode == 201) {
        return Ride.fromJson(jsonDecode(response.body));
      } else {
        throw Exception('Failed to book ride: ${response.body}');
      }
    } catch (e) {
      throw Exception('Error booking ride: $e');
    }
  }

  /// ✅ **Fixed Method: Cancel Ride**
  Future<bool> cancelRide(String rideId) async {
    try {
      final response = await http.delete(
        Uri.parse("${ApiConstants.getRidesEndpoint}/cancel/$rideId"), // ✅ Use correct API constant
        headers: {'Content-Type': 'application/json'},
      );

      if (response.statusCode == 200) {
        return true;
      } else {
        throw Exception('Failed to cancel ride: ${response.body}');
      }
    } catch (e) {
      throw Exception('Error cancelling ride: $e');
    }
  }
  Future<Map<String, double>> getDriverLocation(String rideId) async {
    try {
      final response = await http.get(
        Uri.parse("${ApiConstants.getRidesEndpoint}/$rideId/location"),
        headers: {'Content-Type': 'application/json'},
      );

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        return {
          'lat': (data['driverLatitude'] as num).toDouble(),
          'lng': (data['driverLongitude'] as num).toDouble(),
        };
      } else {
        throw Exception('Failed to fetch driver location: ${response.body}');
      }
    } catch (e) {
      throw Exception('Error fetching driver location: $e');
    }
  }
  Future<Ride> getRideById(String rideId) async {
    try {
      final response = await http.get(
        Uri.parse("${ApiConstants.getRidesEndpoint}/$rideId"),
        headers: {'Content-Type': 'application/json'},
      );

      if (response.statusCode == 200) {
        return Ride.fromJson(jsonDecode(response.body));
      } else {
        throw Exception('Failed to fetch ride details: ${response.body}');
      }
    } catch (e) {
      throw Exception('Error fetching ride details: $e');
    }
  }
}
