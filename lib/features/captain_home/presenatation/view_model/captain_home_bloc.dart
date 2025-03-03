import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import '../../domain/entity/ride_entity.dart';
import '../../domain/use_case/get_captain_profile_usease.dart';

import '../../domain/entity/captain_home_entity.dart';


part 'captain_home_event.dart';
part 'captain_home_state.dart';

class CaptainHomeBloc extends Bloc<CaptainHomeEvent, CaptainHomeState> {
  final GetCaptainProfileUseCase getCaptainProfileUseCase;

  CaptainHomeBloc({required this.getCaptainProfileUseCase}) : super(CaptainHomeInitial()) {
    on<LoadCaptainProfile>(_onLoadCaptainProfile);
    on<AcceptRide>(_onAcceptRide);
    on<CompleteRide>(_onCompleteRide);
    on<OpenSettings>(_onOpenSettings);
    on<CloseSettings>(_onCloseSettings);
    on<ReceiveRideRequest>(_onReceiveRideRequest);
  }

  Future<void> _onLoadCaptainProfile(LoadCaptainProfile event, Emitter<CaptainHomeState> emit) async {
    emit(CaptainLoading());
    final result = await getCaptainProfileUseCase(event.captainId);
    result.fold(
          (failure) => emit(CaptainError(failure.message)),
          (captain) => emit(CaptainLoaded(captain)),
    );
  }

  void _onAcceptRide(AcceptRide event, Emitter<CaptainHomeState> emit) {
    emit(RideAccepted(event.ride));
  }

  void _onCompleteRide(CompleteRide event, Emitter<CaptainHomeState> emit) {
    emit(RideFinished());
  }

  void _onOpenSettings(OpenSettings event, Emitter<CaptainHomeState> emit) {
    emit(SettingsOpened());
  }

  void _onCloseSettings(CloseSettings event, Emitter<CaptainHomeState> emit) {
    emit(CaptainHomeInitial());
  }

  void _onReceiveRideRequest(ReceiveRideRequest event, Emitter<CaptainHomeState> emit) {
    emit(RideRequestReceived(event.ride));
  }
}
