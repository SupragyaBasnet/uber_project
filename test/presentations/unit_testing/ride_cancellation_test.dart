import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:uber_mobile_app_project/data/repositories/ride_repository.dart';

// Mock Repository
class MockRideRepository extends Mock implements RideRepository {}

void main() {
  late MockRideRepository mockRideRepository;

  setUp(() {
    mockRideRepository = MockRideRepository();
  });

  test('5️⃣ Should cancel a ride successfully', () async {
    when(() => mockRideRepository.cancelRide(any()))
        .thenAnswer((_) async => true);

    final result = await mockRideRepository.cancelRide('1');

    expect(result, true);
    verify(() => mockRideRepository.cancelRide(any())).called(1);
  });

  test('6️⃣ Should throw an error when ride cancellation fails', () async {
    when(() => mockRideRepository.cancelRide(any()))
        .thenThrow(Exception("Cancellation Error"));

    expect(() => mockRideRepository.cancelRide('1'), throwsException);
  });
}
