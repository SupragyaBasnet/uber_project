import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:uber_mobile_app_project/data/models/ride_model.dart';
import 'package:uber_mobile_app_project/data/repositories/ride_repository.dart';


/// **Events**
abstract class BookingEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

class BookRideEvent extends BookingEvent {
  final Map<String, dynamic> rideData;
  BookRideEvent(this.rideData);
}

/// **States**
abstract class BookingState extends Equatable {
  @override
  List<Object?> get props => [];
}

class BookingInitial extends BookingState {}

class BookingLoading extends BookingState {}

class BookingSuccess extends BookingState {
  final Ride bookedRide; // ✅ Add `bookedRide` instead of `ride`
  BookingSuccess({required this.bookedRide});
}

class BookingError extends BookingState {
  final String message;
  BookingError({required this.message});
}

/// **BLoC Implementation**
class BookingBloc extends Bloc<BookingEvent, BookingState> {
  final RideRepository rideRepository;

  BookingBloc(this.rideRepository) : super(BookingInitial()) {
    on<BookRideEvent>((event, emit) async {
      emit(BookingLoading());
      try {
        final bookedRide = await rideRepository.bookRide(event.rideData);
        emit(BookingSuccess(bookedRide: bookedRide)); // ✅ Use `bookedRide`
      } catch (e) {
        emit(BookingError(message: e.toString()));
      }
    });
  }
}
