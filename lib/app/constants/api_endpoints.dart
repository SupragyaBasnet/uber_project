class ApiEndpoints {
  ApiEndpoints._();

  static const Duration connectionTimeout = Duration(seconds: 1000);
  static const Duration receiveTimeout = Duration(seconds: 1000);

  // // For Android Emulator
  static const String baseUrl = "http://10.0.2.2:4000/";

  // For iPhone
  // static const String baseUrl = "http://localhost:6278/api/v1/";

  // ============= Auth Routes =============
  static const String login = "auth/sign-in";
  static const String register = "auth/sign-up";
  static const String deleteUser = "auth/delete/";
  static const String getAllUsers = "auth/getAllUsers/";

  // ============= Maps Routes =============
  static const String getSuggestions = "maps/get-suggestions";

  static const String imageUrl = "http://localhost:6278/public/uploads/";
  // static const String imageUrl = "http://10.0.2.2:6278/public/uploads/";

  static const String uploadImage = "auth/uploadImage";

  static const String token =
      "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJfaWQiOiI2N2IyZmJhY2RmZTdjODMwMDgyODIxMmYiLCJwaG9uZW51bWJlciI6IjEyMzQ1Njc4OTkiLCJpYXQiOjE3NDEyMzgxODQsImV4cCI6MTc0MTMyNDU4NH0.i7HprHiwW3zyzsHHqXfc6Ma-UxNRHp5LoyRR54EoMFE";
}
