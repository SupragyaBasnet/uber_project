class Ride {
  final String id;
  final String pickupLocation;
  final String dropoffLocation;
  final double fare;
  final double distance;
  final int duration;

  Ride({
    required this.id,
    required this.pickupLocation,
    required this.dropoffLocation,
    required this.fare,
    required this.distance,
    required this.duration,
  });

  /// ✅ Convert from JSON
  factory Ride.fromJson(Map<String, dynamic> json) {
    return Ride(
      id: json['id'],
      pickupLocation: json['pickupLocation'],
      dropoffLocation: json['dropoffLocation'],
      fare: (json['fare'] ?? 0.0).toDouble(),
      distance: (json['distance'] ?? 0.0).toDouble(),
      duration: json['duration'] ?? 0,
    );
  }

  /// ✅ Convert to JSON
  Map<String, dynamic> toJson() {
    return {
      "id": id,
      "pickupLocation": pickupLocation,
      "dropoffLocation": dropoffLocation,
      "fare": fare,
      "distance": distance,
      "duration": duration,
    };
  }
}
