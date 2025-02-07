import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import '../../data/repositories/ride_repository.dart';
import '../../data/models/ride_model.dart';

/// **Events**
abstract class RideDetailsEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

class FetchRideDetailsEvent extends RideDetailsEvent {
  final String rideId;
  FetchRideDetailsEvent(this.rideId);
}

/// **States**
abstract class RideDetailsState extends Equatable {
  @override
  List<Object?> get props => [];
}

class RideDetailsInitial extends RideDetailsState {}

class RideDetailsLoading extends RideDetailsState {}

class RideDetailsLoaded extends RideDetailsState {
  final Ride ride;
  RideDetailsLoaded({required this.ride});
}

class RideDetailsError extends RideDetailsState {
  final String message;
  RideDetailsError({required this.message});
}

/// **BLoC Implementation**
class RideDetailsBloc extends Bloc<RideDetailsEvent, RideDetailsState> {
  final RideRepository rideRepository;

  RideDetailsBloc(this.rideRepository) : super(RideDetailsInitial()) {
    on<FetchRideDetailsEvent>((event, emit) async {
      emit(RideDetailsLoading());
      try {
        final ride = await rideRepository.getRideById(event.rideId);
        emit(RideDetailsLoaded(ride: ride));
      } catch (e) {
        emit(RideDetailsError(message: e.toString()));
      }
    });
  }
}
