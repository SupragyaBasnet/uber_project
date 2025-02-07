import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import 'package:uber_mobile_app_project/data/models/ride_model.dart';
import 'package:uber_mobile_app_project/data/repositories/ride_repository.dart';

// Mock Repository
class MockRideRepository extends Mock implements RideRepository {}

void main() {
  late MockRideRepository mockRideRepository;

  setUp(() {
    mockRideRepository = MockRideRepository();
  });

  test('Should fetch rides from the repository', () async {
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
        ),
      ],
    );

    final result = await mockRideRepository.getRides();
    expect(result, isA<List<Ride>>());
    verify(() => mockRideRepository.getRides()).called(1);
  });
}
