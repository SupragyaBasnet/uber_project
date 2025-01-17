abstract class CaptainSignupEvent {}

class CaptainSignupSubmit extends CaptainSignupEvent {
  final String name;
  final String phoneNumber;
  final String password;
  final String vehicleColor;
  final String vehiclePlate;
  final String vehicleCapacity;
  final String selectedVehicle;

  CaptainSignupSubmit({
    required this.name,
    required this.phoneNumber,
    required this.password,
    required this.vehicleColor,
    required this.vehiclePlate,
    required this.vehicleCapacity,
    required this.selectedVehicle,
  });
}
