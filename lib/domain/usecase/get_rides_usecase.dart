// lib/domain/usecases/get_rides_usecase.dart
import '../../data/models/ride_model.dart';
import '../../data/repositories/ride_repository.dart';

class GetRidesUseCase {
  final RideRepository rideRepository;

  GetRidesUseCase(this.rideRepository);

  Future<List<Ride>> execute() async { // ✅ Removed userId argument
    return await rideRepository.getRides();
  }
}
