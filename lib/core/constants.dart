class ApiConstants {
  static const String baseUrl = "http://10.0.2.2:5001/api"; // Use 10.0.2.2 for Android emulator
  
  // Authentication
  static const String loginEndpoint = "$baseUrl/auth/login";
  static const String registerEndpoint = "$baseUrl/auth/register";
  static const String userProfileEndpoint = "$baseUrl/users/profile";

  // Rides
  static const String getRidesEndpoint = "$baseUrl/rides";
  static const String bookRideEndpoint = "$baseUrl/rides/book";
  static const String rideDetailsEndpoint = "$baseUrl/rides/details";

  // Payments
  static const String paymentEndpoint = "$baseUrl/payments";
}
