import 'package:get_it/get_it.dart';

// Hive Helpers
import '../../features/auth/user/data/hive/user_hive_helper.dart';
import '../../features/auth/user/data/hive/captain_hive_helper.dart';

// Repositories
import '../../features/auth/user/domain/repository/user_repository.dart';
import '../../features/auth/user/domain/repository/captain_repository.dart';

// Use Cases
import '../../features/auth/user/domain/use_case/LoginCaptainUseCase.dart';
import '../../features/auth/user/domain/use_case/LoginUserUseCase.dart';
import '../../features/auth/user/domain/use_case/RegisterCaptainUseCase.dart';
import '../../features/auth/user/domain/use_case/RegisterUserUseCase.dart';


// Blocs
import '../../features/auth/user/presenatation/view_model/captain_login.bloc.dart';
import '../../features/auth/user/presenatation/view_model/user_login_bloc.dart';
import '../../features/auth/user/presenatation/view_model/user_signup_bloc.dart';

import '../../features/auth/user/presenatation/view_model/captain_signup_bloc.dart';

// Cubits
import '../../features/onboarding/presenatation/view_model/onboarding_cubit.dart';
import '../../features/splash/presenatation/view_model/splash_cubit.dart';
import '../../features/auth/forgot_password/presenatation/view_model/forgot_password_cubit.dart';
import '../../features/auth/forgot_password/presenatation/view_model/otp_verification_cubit.dart';
import '../../features/auth/forgot_password/presenatation/view_model/set_password_cubit.dart';

final GetIt serviceLocator = GetIt.instance;

Future<void> initDependencies() async {
  await _initHiveHelpers();
  await _initRepositories();
  await _initUseCases();
  await _initBlocs();
  await _initCubits();
}

// Initialize Hive Helpers
Future<void> _initHiveHelpers() async {
  serviceLocator.registerLazySingleton<UserHiveHelper>(() => UserHiveHelper());
  serviceLocator.registerLazySingleton<CaptainHiveHelper>(() => CaptainHiveHelper());
}

// Initialize Repositories
Future<void> _initRepositories() async {
  serviceLocator.registerLazySingleton<UserRepository>(
        () => UserRepository(serviceLocator<UserHiveHelper>()),
  );
  serviceLocator.registerLazySingleton<CaptainRepository>(
        () => CaptainRepository(serviceLocator<CaptainHiveHelper>()),
  );
}

// Initialize Use Cases
Future<void> _initUseCases() async {
  serviceLocator.registerLazySingleton<LoginUserUseCase>(
        () => LoginUserUseCase(serviceLocator<UserRepository>()),
  );
  serviceLocator.registerLazySingleton<RegisterUserUseCase>(
        () => RegisterUserUseCase(serviceLocator<UserRepository>()),
  );
  serviceLocator.registerLazySingleton<LoginCaptainUseCase>(
        () => LoginCaptainUseCase(serviceLocator<CaptainRepository>()),
  );
  serviceLocator.registerLazySingleton<RegisterCaptainUseCase>(
        () => RegisterCaptainUseCase(serviceLocator<CaptainRepository>()),
  );
}

// Initialize Blocs
Future<void> _initBlocs() async {
  serviceLocator.registerFactory<UserLoginBloc>(
        () => UserLoginBloc(serviceLocator<LoginUserUseCase>()),
  );
  serviceLocator.registerFactory<UserSignupBloc>(
        () => UserSignupBloc(serviceLocator<RegisterUserUseCase>()),
  );
  serviceLocator.registerFactory<CaptainLoginBloc>(
        () => CaptainLoginBloc(serviceLocator<LoginCaptainUseCase>()),
  );
  serviceLocator.registerFactory<CaptainSignupBloc>(
        () => CaptainSignupBloc(serviceLocator<RegisterCaptainUseCase>()),
  );
}

// Initialize Cubits
Future<void> _initCubits() async {
  serviceLocator.registerFactory<SplashCubit>(() => SplashCubit());
  serviceLocator.registerFactory<OnboardingCubit>(() => OnboardingCubit());
  serviceLocator.registerFactory<ForgotPasswordCubit>(() => ForgotPasswordCubit());
  serviceLocator.registerFactory<OtpVerificationCubit>(() => OtpVerificationCubit());
  serviceLocator.registerFactory<SetPasswordCubit>(() => SetPasswordCubit());
}
