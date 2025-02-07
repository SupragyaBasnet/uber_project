import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:uber_mobile_app_project/data/models/ride_model.dart';
import 'package:uber_mobile_app_project/data/repositories/ride_repository.dart';
import 'package:uber_mobile_app_project/domain/usecase/get_rides_usecase.dart';


// Mock Repository
class MockRideRepository extends Mock implements RideRepository {}

void main() {
  late MockRideRepository mockRideRepository;
  late GetRidesUseCase getRidesUseCase;

  setUp(() {
    mockRideRepository = MockRideRepository();
    getRidesUseCase = GetRidesUseCase(mockRideRepository);
  });

  test('Should return a list of rides', () async {
    when(() => mockRideRepository.getRides()).thenAnswer(
          (_) async => [
        Ride(
          id: '1',
          driverName: 'John Doe',
          pickupLocation: 'A',
          dropoffLocation: 'B',
          fare: 10.0,
          status: 'pending',
          date: DateTime.now(),
          driverLatitude: 27.7172,
          driverLongitude: 85.3240,
        )
      ],
    );

    final result = await getRidesUseCase.execute();
    expect(result, isA<List<Ride>>());
    verify(() => mockRideRepository.getRides()).called(1);
  });
}
