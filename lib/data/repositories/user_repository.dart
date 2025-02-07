// lib/data/repositories/user_repository.dart
import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/user_model.dart';
import '../../core/constants.dart';

class UserRepository {
  /// Login User
  Future<User?> login(String email, String password) async {
    try {
      final response = await http.post(
        Uri.parse(ApiConstants.loginEndpoint),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({'email': email, 'password': password}),
      );

      if (response.statusCode == 200) {
        return User.fromJson(jsonDecode(response.body)); // ✅ Returns a User object
      } else {
        return null; // ✅ Return null on failure
      }
    } catch (e) {
      throw Exception('Login error: $e');
    }
  }

  /// Register User
  Future<User> register(Map<String, dynamic> userData) async {
    try {
      final response = await http.post(
        Uri.parse(ApiConstants.registerEndpoint),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode(userData),
      );

      if (response.statusCode == 201) {
        return User.fromJson(jsonDecode(response.body));
      } else {
        throw Exception('Failed to register: ${response.body}');
      }
    } catch (e) {
      throw Exception('Registration error: $e');
    }
  }

  /// Fetch User Profile
  Future<User?> getUserProfile(String userId) async {
    try {
      final response = await http.get(
        Uri.parse("${ApiConstants.userProfileEndpoint}/$userId"),
        headers: {'Content-Type': 'application/json'},
      );

      if (response.statusCode == 200) {
        return User.fromJson(jsonDecode(response.body));
      } else {
        return null;
      }
    } catch (e) {
      throw Exception('Error fetching user profile: $e');
    }
  }

  /// **✅ Fix: Update User Profile**
  Future<User?> updateUserProfile(String userId, String name) async {
    try {
      final response = await http.put(
        Uri.parse("${ApiConstants.userProfileEndpoint}/$userId"),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({"name": name}),
      );

      if (response.statusCode == 200) {
        return User.fromJson(jsonDecode(response.body)); // ✅ Returns updated User object
      } else {
        return null;
      }
    } catch (e) {
      throw Exception('Error updating user profile: $e');
    }
  }
  Future<bool> logout() async {
    try {
      final response = await http.post(
        Uri.parse("${ApiConstants.baseUrl}/auth/logout"),
        headers: {'Content-Type': 'application/json'},
      );

      if (response.statusCode == 200) {
        return true;
      } else {
        throw Exception('Logout failed: ${response.body}');
      }
    } catch (e) {
      throw Exception('Error during logout: $e');
    }
  }
}
