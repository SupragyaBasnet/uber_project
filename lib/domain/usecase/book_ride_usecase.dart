// lib/domain/usecases/book_ride_usecase.dart
import '../../data/models/ride_model.dart';
import '../../data/repositories/ride_repository.dart';

class BookRideUseCase {
  final RideRepository rideRepository;

  BookRideUseCase(this.rideRepository);

  Future<Ride> execute(Map<String, dynamic> rideData) async {
    return await rideRepository.bookRide(rideData); // ✅ No more missing method error!
  }
}
