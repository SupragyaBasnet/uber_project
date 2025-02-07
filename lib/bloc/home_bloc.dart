import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import '../../data/repositories/ride_repository.dart';
import '../../data/models/ride_model.dart';

/// **Events**
abstract class HomeEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

class FetchRidesEvent extends HomeEvent {}

/// **States**
abstract class HomeState extends Equatable {
  @override
  List<Object?> get props => [];
}

class HomeInitial extends HomeState {}

class HomeLoading extends HomeState {}

class HomeLoaded extends HomeState {
  final List<Ride> rides;
  HomeLoaded({required this.rides});
}

class HomeError extends HomeState {
  final String message;
  HomeError({required this.message});
}

/// **BLoC Implementation**
class HomeBloc extends Bloc<HomeEvent, HomeState> {
  final RideRepository rideRepository;

  HomeBloc(this.rideRepository) : super(HomeInitial()) {
    on<FetchRidesEvent>((event, emit) async {
      emit(HomeLoading());
      try {
        final rides = await rideRepository.getRides();
        emit(HomeLoaded(rides: rides));
      } catch (e) {
        emit(HomeError(message: e.toString()));
      }
    });
  }
}
