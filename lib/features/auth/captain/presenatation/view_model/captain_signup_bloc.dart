import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:dartz/dartz.dart';
import '../../../../../core/error/failure.dart';
import '../../domain/use_case/captain_signup_usecase.dart';
import '../../domain/entity/captain_entity.dart';
import 'captain_signup_event.dart';
import 'captain_signup_state.dart';

class CaptainSignupBloc extends Bloc<CaptainSignupEvent, CaptainSignupState> {
  final CaptainSignupUseCase signupUseCase;

  CaptainSignupBloc({required this.signupUseCase}) : super(CaptainSignupInitial()) {
    on<CaptainSignupRequested>(_onSignupRequested);
  }

  Future<void> _onSignupRequested(
      CaptainSignupRequested event, Emitter<CaptainSignupState> emit) async {
    emit(CaptainSignupLoading());

    final Either<Failure, CaptainEntity> result = await signupUseCase(event.captainData);

    result.fold(
          (failure) => emit(CaptainSignupFailure(failure.message)),
          (captain) => emit(CaptainSignupSuccess(captain)), // ✅ Now using CaptainEntity
    );
  }
}
