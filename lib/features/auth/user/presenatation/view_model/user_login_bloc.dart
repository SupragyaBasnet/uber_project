import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:dartz/dartz.dart';
import '../../../../../core/error/failure.dart';
import '../../domain/use_case/user_login_usecase.dart';
import '../../domain/entity/user_entity.dart';
import 'user_login_event.dart';
import 'user_login_state.dart';

class UserLoginBloc extends Bloc<UserLoginEvent, UserLoginState> {
  final UserLoginUseCase loginUseCase;

  UserLoginBloc({required this.loginUseCase}) : super(UserLoginInitial()) {
    on<UserLoginRequested>(_onLoginRequested);
  }

  Future<void> _onLoginRequested(
      UserLoginRequested event, Emitter<UserLoginState> emit) async {
    emit(UserLoginLoading());

    final Either<Failure, UserEntity> result = await loginUseCase(event.credentials);

    result.fold(
          (failure) => emit(UserLoginFailure(failure.message)),
          (user) => emit(UserLoginSuccess(user.toMap())), // Convert Entity to Map
    );
  }
}
