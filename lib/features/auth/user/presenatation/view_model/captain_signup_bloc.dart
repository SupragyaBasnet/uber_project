import 'package:flutter_bloc/flutter_bloc.dart';

import '../../domain/use_case/RegisterCaptainUseCase.dart';
import 'captain_signup_event.dart';
import 'captain_signup_state.dart';

class CaptainSignupBloc extends Bloc<CaptainSignupEvent, CaptainSignupState> {
  final RegisterCaptainUseCase registerCaptainUseCase;

  CaptainSignupBloc(this.registerCaptainUseCase) : super(CaptainSignupInitial());

  @override
  Stream<CaptainSignupState> mapEventToState(CaptainSignupEvent event) async* {
    if (event is CaptainSignupSubmit) {
      yield CaptainSignupLoading();

      try {
        await registerCaptainUseCase(
          CaptainRegisterParams(
            phoneNumber: event.phoneNumber,
            password: event.password,
          ),
        );
        yield CaptainSignupSuccess();
      } catch (e) {
        yield CaptainSignupError("Failed to create an account. Please try again.");
      }
    }
  }
}
