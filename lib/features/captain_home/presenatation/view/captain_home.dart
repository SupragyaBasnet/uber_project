import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../domain/use_case/get_captain_profile_usease.dart';
import '../view_model/captain_home_bloc.dart';
import 'FinishRide.dart';
import 'RideInProgress.dart';
import 'RidePopUp.dart';
import 'captain_settings.dart';
import 'live_tracking.dart';

class CaptainHome extends StatelessWidget {
  final String captainId; // ✅ Ensure Captain ID is provided

  CaptainHome({required this.captainId});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => CaptainHomeBloc(
        getCaptainProfileUseCase: context.read<GetCaptainProfileUseCase>(),
      )..add(LoadCaptainProfile(captainId)), // ✅ Correctly passing captainId

      child: BlocBuilder<CaptainHomeBloc, CaptainHomeState>(
        builder: (context, state) {
          if (state is CaptainLoading) {
            return const Center(child: CircularProgressIndicator());
          }

          if (state is CaptainError) {
            return Center(child: Text("Error: ${state.message}"));
          }

          return Scaffold(
            body: Stack(
              children: [
                Positioned.fill(child: LiveTracking()),

                if (state is RideRequestReceived) // ✅ Now defined in state
                  RidePopUp(
                    ride: state.ride,
                    onAccept: () {
                      context.read<CaptainHomeBloc>().add(AcceptRide(state.ride));
                    },
                    onIgnore: () {
                      context.read<CaptainHomeBloc>().add(CloseSettings());
                    },
                  ),

                if (state is RideAccepted)
                  RideInProgress(
                    ride: state.ride,
                    onComplete: () {
                      context.read<CaptainHomeBloc>().add(CompleteRide());
                    },
                  ),

                if (state is RideFinished)
                  FinishRide(
                    onDismiss: () {
                      context.read<CaptainHomeBloc>().add(CloseSettings());
                    },
                  ),

                if (state is SettingsOpened)
                  CaptainSettings(
                    onClose: () {
                      context.read<CaptainHomeBloc>().add(CloseSettings());
                    },
                  ),

                Positioned(
                  top: 40,
                  right: 20,
                  child: IconButton(
                    icon: const Icon(Icons.settings, size: 30, color: Colors.white),
                    onPressed: () => context.read<CaptainHomeBloc>().add(OpenSettings()),
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
