import 'dart:convert';
import 'package:http/http.dart' as http;

class ApiService {
  final String baseUrl = "http://localhost:5001/api"; // Change to deployed URL if needed

  Future<dynamic> loginUser(String email, String password) async {
    final response = await http.post(
      Uri.parse("$baseUrl/users/login"),
      headers: {"Content-Type": "application/json"},
      body: jsonEncode({"email": email, "password": password}),
    );
    if (response.statusCode == 200) {
      return jsonDecode(response.body);
    } else {
      throw Exception("Failed to login: ${response.body}");
    }
  }

  Future<List<dynamic>> getRides() async {
    final response = await http.get(Uri.parse("$baseUrl/rides"));
    if (response.statusCode == 200) {
      return jsonDecode(response.body);
    } else {
      throw Exception("Failed to fetch rides");
    }
  }

  Future<dynamic> bookRide(String rideId, String userId) async {
    final response = await http.post(
      Uri.parse("$baseUrl/rides/book"),
      headers: {"Content-Type": "application/json"},
      body: jsonEncode({"rideId": rideId, "userId": userId}),
    );
    if (response.statusCode == 200) {
      return jsonDecode(response.body);
    } else {
      throw Exception("Failed to book ride");
    }
  }
}
