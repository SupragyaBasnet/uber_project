class RideFare {
  final double auto;
  final double car;
  final double moto;

  RideFare({
    required this.auto,
    required this.car,
    required this.moto,
  });

  factory RideFare.fromJson(Map<String, dynamic> json) {
    return RideFare(
      auto: json['auto']?.toDouble() ?? 0.0,
      car: json['car']?.toDouble() ?? 0.0,
      moto: json['moto']?.toDouble() ?? 0.0,
    );
  }
}
