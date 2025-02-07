import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import '../../data/repositories/ride_repository.dart';
import '../../data/models/ride_model.dart';

/// **Events**
abstract class HistoryEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

class FetchHistoryEvent extends HistoryEvent {}

/// **States**
abstract class HistoryState extends Equatable {
  @override
  List<Object?> get props => [];
}

class HistoryInitial extends HistoryState {}

class HistoryLoading extends HistoryState {}

class HistoryLoaded extends HistoryState {
  final List<Ride> rides;
  HistoryLoaded({required this.rides});
}

class HistoryError extends HistoryState {
  final String message;
  HistoryError({required this.message});
}

/// **BLoC Implementation**
class HistoryBloc extends Bloc<HistoryEvent, HistoryState> {
  final RideRepository rideRepository;

  HistoryBloc(this.rideRepository) : super(HistoryInitial()) {
    on<FetchHistoryEvent>((event, emit) async {
      emit(HistoryLoading());
      try {
        final rides = await rideRepository.getRides();
        emit(HistoryLoaded(rides: rides));
      } catch (e) {
        emit(HistoryError(message: e.toString()));
      }
    });
  }
}
