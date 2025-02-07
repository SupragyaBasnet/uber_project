import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import '../../data/repositories/ride_repository.dart';

/// **Events**
abstract class TrackingEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

class TrackRideEvent extends TrackingEvent {
  final String rideId;
  TrackRideEvent(this.rideId);
}

/// **States**
abstract class TrackingState extends Equatable {
  @override
  List<Object?> get props => [];
}

class TrackingInitial extends TrackingState {}

class TrackingLoading extends TrackingState {}

class TrackingLoaded extends TrackingState {
  final double latitude;
  final double longitude;
  TrackingLoaded({required this.latitude, required this.longitude});
}

class TrackingError extends TrackingState {
  final String message;
  TrackingError({required this.message});
}

/// **BLoC Implementation**
class TrackingBloc extends Bloc<TrackingEvent, TrackingState> {
  final RideRepository rideRepository;

  TrackingBloc(this.rideRepository) : super(TrackingInitial()) {
    on<TrackRideEvent>((event, emit) async {
      emit(TrackingLoading());
      try {
        final location = await rideRepository.getDriverLocation(event.rideId);

        // ✅ Ensure values are non-null by providing default values
        final double latitude = (location['lat'] as num?)?.toDouble() ?? 0.0;
        final double longitude = (location['lng'] as num?)?.toDouble() ?? 0.0;

        emit(TrackingLoaded(latitude: latitude, longitude: longitude));
      } catch (e) {
        emit(TrackingError(message: e.toString()));
      }
    });
  }
}
