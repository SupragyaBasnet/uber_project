class HiveTableConstant {
  HiveTableConstant._(); // Private constructor to prevent instantiation

  // Hive Box Names
  static const String userBox = "userBox";
  static const String captainBox = "captainBox";
  static const String rideBox = "rideBox";
  static const String settingsBox = "settingsBox";

  // User Table Fields
  static const String userId = "userId";
  static const String userName = "userName";
  static const String userEmail = "userEmail";
  static const String userPhone = "userPhone";
  static const String userProfileImage = "userProfileImage";
  static const String userToken = "userToken";
  static const String userRideHistory = "userRideHistory";

  // Captain Table Fields
  static const String captainId = "captainId";
  static const String captainName = "captainName";
  static const String captainEmail = "captainEmail";
  static const String captainPhone = "captainPhone";
  static const String captainProfileImage = "captainProfileImage";
  static const String captainToken = "captainToken";
  static const String captainVehicleType = "captainVehicleType";
  static const String captainRideHistory = "captainRideHistory";

  // Ride Table Fields
  static const String rideId = "rideId";
  static const String ridePickup = "ridePickup";
  static const String rideDestination = "rideDestination";
  static const String rideFare = "rideFare";
  static const String rideDistance = "rideDistance";
  static const String rideDuration = "rideDuration";
  static const String rideStatus = "rideStatus";
  static const String rideStartTime = "rideStartTime";
  static const String rideEndTime = "rideEndTime";

  // Settings Table Fields
  static const String themeMode = "themeMode"; // Light/Dark Mode
  static const String language = "language"; // Preferred Language
  static const String notificationsEnabled = "notificationsEnabled"; // Boolean for Push Notifications
}
