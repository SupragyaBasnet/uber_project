import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:uber_mobile_app_project/data/models/ride_model.dart';

import 'package:uber_mobile_app_project/data/repositories/ride_repository.dart';
import 'package:uber_mobile_app_project/domain/usecase/book_ride_usecase.dart';

// Mock Repository
class MockRideRepository extends Mock implements RideRepository {}

void main() {
  late MockRideRepository mockRideRepository;
  late BookRideUseCase bookRideUseCase;

  setUp(() {
    mockRideRepository = MockRideRepository();
    bookRideUseCase = BookRideUseCase(mockRideRepository);
  });

  test('Should book a ride successfully', () async {
    when(() => mockRideRepository.bookRide(any())).thenAnswer(
          (_) async => Ride(
        id: '2',
        driverName: 'Jane Doe',
        pickupLocation: 'X',
        dropoffLocation: 'Y',
        fare: 15.0,
        status: 'confirmed',
        date: DateTime.now(),
        driverLatitude: 27.7172,
        driverLongitude: 85.3240,
      ),
    );

    final result = await bookRideUseCase.execute({
      "pickupLocation": "X",
      "dropoffLocation": "Y",
      "fare": 15.0,
      "status": "pending",
    });

    expect(result, isA<Ride>());
    verify(() => mockRideRepository.bookRide(any())).called(1);
  });
}
