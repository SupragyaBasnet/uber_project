part of 'captain_home_bloc.dart';

abstract class CaptainHomeEvent extends Equatable {
  const CaptainHomeEvent();

  @override
  List<Object?> get props => [];
}

class LoadCaptainProfile extends CaptainHomeEvent {
  final String captainId;

  const LoadCaptainProfile(this.captainId);

  @override
  List<Object?> get props => [captainId];
}

class AcceptRide extends CaptainHomeEvent {
  final Ride ride;
  const AcceptRide(this.ride);

  @override
  List<Object?> get props => [ride];
}

class CompleteRide extends CaptainHomeEvent {}

class OpenSettings extends CaptainHomeEvent {}

class CloseSettings extends CaptainHomeEvent {}

class ReceiveRideRequest extends CaptainHomeEvent {
  final Ride ride;
  const ReceiveRideRequest(this.ride);

  @override
  List<Object?> get props => [ride];
}
