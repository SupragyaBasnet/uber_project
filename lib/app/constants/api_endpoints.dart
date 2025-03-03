// emulator -avd Pixel_7_Pro_API_30

class ApiEndpoints {
  ApiEndpoints._(); // Private constructor to prevent instantiation

  static const Duration connectionTimeout = Duration(seconds: 1000);
  static const Duration receiveTimeout = Duration(seconds: 1000);

  // Base URL
  static const String baseUrl = "http://10.0.2.2:3000/api/v1/";

  // ============= User Authentication Routes =============
  static const String loginUser = "${baseUrl}users/login";
  static const String registerUser = "${baseUrl}users/register";
  static const String forgotPasswordUserSendOtp = "${baseUrl}users/forgot-password/send-otp";
  static const String forgotPasswordUserVerifyOtp = "${baseUrl}users/forgot-password/verify-otp";
  static const String forgotPasswordUserReset = "${baseUrl}users/forgot-password/reset-password";

  // ============= Captain Authentication Routes =============
  static const String loginCaptain = "${baseUrl}captains/login";
  static const String registerCaptain = "${baseUrl}captains/register";
  static const String forgotPasswordCaptainSendOtp = "${baseUrl}captains/forgot-password/send-otp";
  static const String forgotPasswordCaptainVerifyOtp = "${baseUrl}captains/forgot-password/verify-otp";
  static const String forgotPasswordCaptainReset = "${baseUrl}captains/forgot-password/reset-password";

  // ============= Ride Routes =============
  static const String requestRide = "${baseUrl}rides/create"; // User Requests a Ride
  static const String getUserRides = "${baseUrl}rides/users/history"; // User's Ride History
  static const String getCaptainRides = "${baseUrl}rides/captains/history"; // Captain's Ride History
  static const String cancelRide = "${baseUrl}rides/cancel"; // Cancel Ride
  static const String confirmRide = "${baseUrl}rides/confirm"; // Captain Confirms Ride
  static const String startRide = "${baseUrl}rides/start-ride"; // Start Ride after OTP verification
  static const String endRide = "${baseUrl}rides/end-ride"; // End Ride

  // ============= Profile Routes =============
  static const String getUserProfile = "${baseUrl}users/profile";
  static const String updateUserProfile = "${baseUrl}users/update";

  static const String getCaptainProfile = "${baseUrl}captains/profile";
  static const String updateCaptainProfile = "${baseUrl}captains/update";

  // ============= Vehicle Routes =============
  static const String getVehicleAvailability = "${baseUrl}vehicles/availability";
  static const String getFareEstimate = "${baseUrl}rides/get-fare";

  // ============= Map & Location Routes =============
  static const String getMapSuggestions = "${baseUrl}maps/get-suggestions";

  // ============= Socket Routes (Emit Events) =============
  static const String socketJoin = "join"; // Join User/Captain to Socket
  static const String socketNewRide = "new-ride"; // User Requests a New Ride
  static const String socketRideConfirmed = "ride-confirmed"; // Captain Confirms Ride
  static const String socketRideStarted = "ride-started"; // Ride Started
  static const String socketRideEnded = "ride-ended"; // Ride Completed
  static const String socketUpdateLocationCaptain = "update-location-captain"; // Captain Location Updates
}
