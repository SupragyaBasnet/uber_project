import 'package:flutter_test/flutter_test.dart';
import 'package:bloc_test/bloc_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:uber_mobile_app_project/bloc/history_bloc.dart';

import 'package:uber_mobile_app_project/data/repositories/ride_repository.dart';
import 'package:uber_mobile_app_project/data/models/ride_model.dart';

class MockRideRepository extends Mock implements RideRepository {}

void main() {
  late MockRideRepository mockRideRepository;
  late HistoryBloc historyBloc;

  final mockRide = Ride(
    id: '1',
    driverName: 'John Doe',
    pickupLocation: 'Point A',
    dropoffLocation: 'Point B',
    fare: 15.0,
    status: 'completed',
    date: DateTime.now(),
    driverLatitude: 27.7172,
    driverLongitude: 85.3240,
  );

  setUp(() {
    mockRideRepository = MockRideRepository();
    historyBloc = HistoryBloc(mockRideRepository);
  });

  blocTest<HistoryBloc, HistoryState>(
    '✅ emits [HistoryLoading, HistoryLoaded] when ride history is fetched',
    build: () {
      when(() => mockRideRepository.getRides()).thenAnswer((_) async => [mockRide]);
      return historyBloc;
    },
    act: (bloc) => bloc.add(FetchHistoryEvent()),
    expect: () => [HistoryLoading(), HistoryLoaded(rides: [mockRide])],
  );
}
