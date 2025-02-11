import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:dartz/dartz.dart';
import '../../../../../core/error/failure.dart';
import '../../domain/entity/captain_entity.dart';
import '../../domain/use_case/captain_login_usecase.dart';
import 'captain_login_event.dart';
import 'captain_login_state.dart';

class CaptainLoginBloc extends Bloc<CaptainLoginEvent, CaptainLoginState> {
  final CaptainLoginUseCase loginUseCase;

  CaptainLoginBloc({required this.loginUseCase}) : super(CaptainLoginInitial()) {
    on<CaptainLoginRequested>(_onLoginRequested);
  }

  Future<void> _onLoginRequested(
      CaptainLoginRequested event, Emitter<CaptainLoginState> emit) async {
    emit(CaptainLoginLoading());

    final Either<Failure, CaptainEntity> result = await loginUseCase(event.credentials);

    result.fold(
          (failure) => emit(CaptainLoginFailure(failure.message)),
          (captain) => emit(CaptainLoginSuccess(captain)), // ✅ Now using CaptainEntity
    );
  }
}
