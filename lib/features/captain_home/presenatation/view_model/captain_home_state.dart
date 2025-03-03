part of 'captain_home_bloc.dart';

abstract class CaptainHomeState extends Equatable {
  const CaptainHomeState();

  @override
  List<Object?> get props => [];
}

class CaptainHomeInitial extends CaptainHomeState {}

class CaptainLoading extends CaptainHomeState {}

class CaptainLoaded extends CaptainHomeState {
  final CaptainHomeEntity captain;
  const CaptainLoaded(this.captain);

  @override
  List<Object?> get props => [captain];
}

class CaptainError extends CaptainHomeState {
  final String message;
  const CaptainError(this.message);

  @override
  List<Object?> get props => [message];
}

class RideRequestReceived extends CaptainHomeState { // ✅ Added RideRequestReceived state
  final Ride ride;
  const RideRequestReceived(this.ride);

  @override
  List<Object?> get props => [ride];
}

class RideAccepted extends CaptainHomeState {
  final Ride ride;
  const RideAccepted(this.ride);

  @override
  List<Object?> get props => [ride];
}

class RideFinished extends CaptainHomeState {}

class SettingsOpened extends CaptainHomeState {}
