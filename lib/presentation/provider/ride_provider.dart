import 'package:flutter/material.dart';
import '../../data/models/ride_model.dart';
import '../../domain/usecase/book_ride_usecase.dart';
import '../../domain/usecase/get_rides_usecase.dart';

class RideProvider with ChangeNotifier {
  final BookRideUseCase bookRideUseCase;
  final GetRidesUseCase getRidesUseCase;

  List<Ride> _rides = [];
  bool _isLoading = false;
  String? _errorMessage;

  RideProvider({
    required this.bookRideUseCase,
    required this.getRidesUseCase,
  });

  List<Ride> get rides => _rides;
  bool get isLoading => _isLoading;
  String? get errorMessage => _errorMessage;

  /// Fetch all rides (used in home screen)
  Future<void> fetchRides() async {
    _isLoading = true;
    _errorMessage = null;
    notifyListeners();

    try {
      _rides = await getRidesUseCase.execute();
    } catch (e) {
      _errorMessage = e.toString();
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  /// Get ride history (used in history screen)
  Future<List<Ride>> getRideHistory() async {
    try {
      return await getRidesUseCase.execute();
    } catch (e) {
      throw Exception("Error fetching ride history: $e");
    }
  }

  /// ✅ **Get a specific ride by its ID (used in RideDetailsScreen)**
  Ride? getRideById(String rideId) {
    try {
      return _rides.firstWhere((ride) => ride.id == rideId);
    } catch (e) {
      return null; // ✅ Ensures function doesn't crash if ride is not found
    }
  }

  /// ✅ **Cancel a ride (used in RideDetailsScreen)**
  Future<void> cancelRide(String rideId) async {
    _isLoading = true;
    notifyListeners();

    try {
      // Simulating a cancel API call or local update
      _rides = _rides.map((ride) {
        if (ride.id == rideId) {
          return Ride(
            id: ride.id,
            driverName: ride.driverName,
            pickupLocation: ride.pickupLocation,
            dropoffLocation: ride.dropoffLocation,
            fare: ride.fare,
            status: 'cancelled', // ✅ Change ride status to cancelled
            date: ride.date,
            driverLatitude: ride.driverLatitude,
            driverLongitude: ride.driverLongitude,
          );
        }
        return ride;
      }).toList();

      notifyListeners();
    } catch (e) {
      _errorMessage = "Error cancelling ride: $e";
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  /// Book a ride
  Future<bool> bookRide(Map<String, dynamic> rideData) async {
    try {
      await bookRideUseCase.execute(rideData);
      return true; // ✅ Return true on success
    } catch (e) {
      _errorMessage = "Error booking ride: $e";
      return false; // ✅ Return false on failure
    }
  }
}
