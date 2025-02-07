// lib/data/models/ride_model.dart
class Ride {
  final String id;
  final String driverName;
  final String pickupLocation;
  final String dropoffLocation;
  final double fare;
  final String status;
  final DateTime date; // Added ride date
  final double driverLatitude; // Added driver's location
  final double driverLongitude;

  Ride({
    required this.id,
    required this.driverName,
    required this.pickupLocation,
    required this.dropoffLocation,
    required this.fare,
    required this.status,
    required this.date,
    required this.driverLatitude,
    required this.driverLongitude,
  });

  factory Ride.fromJson(Map<String, dynamic> json) {
    return Ride(
      id: json['_id'] ?? '',
      driverName: json['driverName'] ?? 'Unknown',
      pickupLocation: json['pickupLocation'] ?? 'Unknown',
      dropoffLocation: json['dropoffLocation'] ?? 'Unknown',
      fare: (json['fare'] as num?)?.toDouble() ?? 0.0,
      status: json['status'] ?? 'pending',
      date: json['date'] != null ? DateTime.parse(json['date']) : DateTime.now(),
      driverLatitude: (json['driverLatitude'] as num?)?.toDouble() ?? 0.0,
      driverLongitude: (json['driverLongitude'] as num?)?.toDouble() ?? 0.0,
    );
  }
}
