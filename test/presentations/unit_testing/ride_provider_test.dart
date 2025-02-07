import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:uber_mobile_app_project/data/models/ride_model.dart';
import 'package:uber_mobile_app_project/domain/usecase/book_ride_usecase.dart';
import 'package:uber_mobile_app_project/domain/usecase/get_rides_usecase.dart';
import 'package:uber_mobile_app_project/presentation/provider/ride_provider.dart';


// Mock Dependencies
class MockBookRideUseCase extends Mock implements BookRideUseCase {}

class MockGetRidesUseCase extends Mock implements GetRidesUseCase {}

void main() {
  late MockBookRideUseCase mockBookRideUseCase;
  late MockGetRidesUseCase mockGetRidesUseCase;
  late RideProvider rideProvider;

  setUp(() {
    mockBookRideUseCase = MockBookRideUseCase();
    mockGetRidesUseCase = MockGetRidesUseCase();
    rideProvider = RideProvider(
      bookRideUseCase: mockBookRideUseCase,
      getRidesUseCase: mockGetRidesUseCase,
    );
  });

  test('Should update ride list after fetching rides', () async {
    when(() => mockGetRidesUseCase.execute()).thenAnswer(
          (_) async => [
        Ride(
          id: '1',
          driverName: 'Alice Doe',
          pickupLocation: 'C',
          dropoffLocation: 'D',
          fare: 12.0,
          status: 'completed',
          date: DateTime.now(),
          driverLatitude: 27.7172,
          driverLongitude: 85.3240,
        )
      ],
    );

    await rideProvider.fetchRides();
    expect(rideProvider.rides.length, 1);
    expect(rideProvider.rides.first.driverName, 'Alice Doe');
  });
}
