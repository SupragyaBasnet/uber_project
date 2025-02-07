import 'package:flutter_test/flutter_test.dart';
import 'package:bloc_test/bloc_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:uber_mobile_app_project/bloc/home_bloc.dart';
import 'package:uber_mobile_app_project/data/repositories/ride_repository.dart';

import 'package:uber_mobile_app_project/data/models/ride_model.dart';

class MockRideRepository extends Mock implements RideRepository {}

void main() {
  late MockRideRepository mockRideRepository;
  late HomeBloc homeBloc;

  final mockRide = Ride(
    id: '1',
    driverName: 'John Doe',
    pickupLocation: 'Point A',
    dropoffLocation: 'Point B',
    fare: 15.0,
    status: 'confirmed',
    date: DateTime.now(),
    driverLatitude: 27.7172,
    driverLongitude: 85.3240,
  );

  setUp(() {
    mockRideRepository = MockRideRepository();
    homeBloc = HomeBloc(mockRideRepository);
  });

  blocTest<HomeBloc, HomeState>(
    '✅ emits [HomeLoading, HomeLoaded] when rides are fetched',
    build: () {
      when(() => mockRideRepository.getRides()).thenAnswer((_) async => [mockRide]);
      return homeBloc;
    },
    act: (bloc) => bloc.add(FetchRidesEvent()),
    expect: () => [HomeLoading(), HomeLoaded(rides: [mockRide])],
  );
}
