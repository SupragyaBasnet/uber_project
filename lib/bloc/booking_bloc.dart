import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import '../../data/repositories/ride_repository.dart';

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

class BookingSuccess extends BookingState {}

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
        await rideRepository.bookRide(event.rideData);
        emit(BookingSuccess());
      } catch (e) {
        emit(BookingError(message: e.toString()));
      }
    });
  }
}
