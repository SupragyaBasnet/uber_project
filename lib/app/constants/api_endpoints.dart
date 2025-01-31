import 'dart:io';

class ApiEndpoints {
  // ✅ Fix: Use 10.0.2.2 for Android Emulator, localhost for iOS
  static final String baseUrl = Platform.isAndroid ? "http://10.0.2.2:4000" : "http://localhost:3000";

      // : "http://localhost:3000"; // ✅ Use localhost for iOS/Web

  // 🔹 Authentication
  static String userLogin = "$baseUrl/users/login";
  static String userRegister = "$baseUrl/users/register";
  static String captainLogin = "$baseUrl/captains/login";
  static String captainRegister = "$baseUrl/captains/register";

  // 🔹 User Profile
  static String userProfile = "$baseUrl/users/profile";
  static String captainProfile = "$baseUrl/captains/profile";

  // 🔹 Image Upload
  static String uploadUserImage = "$baseUrl/users/upload-image";
  static String uploadCaptainImage = "$baseUrl/captains/upload-image";

  // 🔹 Logout
  static String userLogout = "$baseUrl/users/logout";
  static String captainLogout = "$baseUrl/captains/logout";

  // 🔹 Forgot Password
  static String sendOtp = "$baseUrl/api/forgot-password/send-otp";
  static String verifyOtp = "$baseUrl/api/forgot-password/verify-otp";
  static String resetPassword = "$baseUrl/api/forgot-password/reset-password";

  // 🔹 Ride Requests (If applicable)
  static String rideRequest = "$baseUrl/rides/request";
  static String rideHistory = "$baseUrl/rides/history";
  static String activeRides = "$baseUrl/rides/active";
  
  // 🔹 Maps API (If applicable)
  static String getNearbyCaptains = "$baseUrl/maps/nearby-captains";
}
