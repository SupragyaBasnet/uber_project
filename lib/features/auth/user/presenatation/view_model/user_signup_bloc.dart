import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:dartz/dartz.dart';
import '../../../../../core/error/failure.dart';
import '../../domain/use_case/user_signup_usecase.dart';
import '../../domain/entity/user_entity.dart';
import 'user_signup_event.dart';
import 'user_signup_state.dart';

class UserSignupBloc extends Bloc<UserSignupEvent, UserSignupState> {
  final UserSignupUseCase signupUseCase;

  UserSignupBloc({required this.signupUseCase}) : super(UserSignupInitial()) {
    on<UserSignupRequested>(_onSignupRequested);
  }

  Future<void> _onSignupRequested(
      UserSignupRequested event, Emitter<UserSignupState> emit) async {
    emit(UserSignupLoading());

    final Either<Failure, UserEntity> result = await signupUseCase(event.userData);

    result.fold(
          (failure) => emit(UserSignupFailure(failure.message)),
          (user) => emit(UserSignupSuccess(user.toMap())), // Convert Entity to Map
    );
  }
}
