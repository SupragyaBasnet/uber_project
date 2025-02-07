import 'package:flutter_test/flutter_test.dart';
import 'package:bloc_test/bloc_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:uber_mobile_app_project/bloc/tracking_bloc.dart';

import 'package:uber_mobile_app_project/data/repositories/ride_repository.dart';

class MockRideRepository extends Mock implements RideRepository {}

void main() {
  late MockRideRepository mockRideRepository;
  late TrackingBloc trackingBloc;

  setUp(() {
    mockRideRepository = MockRideRepository();
    trackingBloc = TrackingBloc(mockRideRepository);
  });

  blocTest<TrackingBloc, TrackingState>(
    '✅ emits [TrackingLoading, TrackingLoaded] when driver location is fetched',
    build: () {
      when(() => mockRideRepository.getDriverLocation(any()))
          .thenAnswer((_) async => {'lat': 27.7172, 'lng': 85.3240});
      return trackingBloc;
    },
    act: (bloc) => bloc.add(TrackRideEvent('1')),
    expect: () => [TrackingLoading(), TrackingLoaded(latitude: 27.7172, longitude: 85.3240)],
  );
}
