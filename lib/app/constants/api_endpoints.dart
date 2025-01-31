class ApiEndpoints {
  static const String baseUrl = "http://localhost:3000"; // Replace with actual backend URL

  // 🔹 Authentication
  static const String userLogin = "$baseUrl/users/login";
  static const String userRegister = "$baseUrl/users/register";
  static const String captainLogin = "$baseUrl/captains/login";
  static const String captainRegister = "$baseUrl/captains/register";

  // 🔹 User Profile
  static const String userProfile = "$baseUrl/users/profile";
  static const String captainProfile = "$baseUrl/captains/profile";

  // 🔹 Image Upload (✅ Newly Added)
  static const String uploadUserImage = "$baseUrl/users/upload-image";
  static const String uploadCaptainImage = "$baseUrl/captains/upload-image";

  // 🔹 Logout
  static const String userLogout = "$baseUrl/users/logout";
  static const String captainLogout = "$baseUrl/captains/logout";

  // 🔹 Forgot Password
  static const String sendOtp = "$baseUrl/api/forgot-password/send-otp";
  static const String verifyOtp = "$baseUrl/api/forgot-password/verify-otp";
  static const String resetPassword = "$baseUrl/api/forgot-password/reset-password";

  // 🔹 Ride Requests (If you are implementing ride feature)
  static const String rideRequest = "$baseUrl/rides/request";
  static const String rideHistory = "$baseUrl/rides/history";
  static const String activeRides = "$baseUrl/rides/active";
  
  // 🔹 Maps API (If applicable)
  static const String getNearbyCaptains = "$baseUrl/maps/nearby-captains";

  // 🔹 Other Endpoints (Add as needed)
}
