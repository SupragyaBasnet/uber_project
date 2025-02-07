import 'package:flutter_test/flutter_test.dart';
import 'package:bloc_test/bloc_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:uber_mobile_app_project/bloc/ride_details_bloc.dart';

import 'package:uber_mobile_app_project/data/models/ride_model.dart';
import 'package:uber_mobile_app_project/data/repositories/ride_repository.dart';

class MockRideRepository extends Mock implements RideRepository {}

void main() {
  late MockRideRepository mockRideRepository;
  late RideDetailsBloc rideDetailsBloc;

  final mockRide = Ride(
    id: '1',
    driverName: 'John Doe',
    pickupLocation: 'A',
    dropoffLocation: 'B',
    fare: 20.0,
    status: 'confirmed',
    date: DateTime.now(),
    driverLatitude: 27.7172,
    driverLongitude: 85.3240,
  );

  setUp(() {
    mockRideRepository = MockRideRepository();
    rideDetailsBloc = RideDetailsBloc(mockRideRepository);
  });

  blocTest<RideDetailsBloc, RideDetailsState>(
    '✅ emits [RideDetailsLoading, RideDetailsLoaded] when ride details are fetched',
    build: () {
      when(() => mockRideRepository.getRideById(any())).thenAnswer((_) async => mockRide);
      return rideDetailsBloc;
    },
    act: (bloc) => bloc.add(FetchRideDetailsEvent('1')),
    expect: () => [RideDetailsLoading(), RideDetailsLoaded(ride: mockRide)],
  );
}
