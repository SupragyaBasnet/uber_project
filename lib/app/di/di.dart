import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../core/network/api_service.dart';
import '../../core/network/hive_service.dart';

// ✅ Onboarding & Splash Dependencies
import '../../features/auth/captain/presenatation/view_model/captain_login.bloc.dart';
import '../../features/captain_home/presenatation/view_model/splash_cubit.dart';
import '../../features/onboarding/presenatation/view_model/onboarding_cubit.dart';

// ✅ User Authentication Dependencies
import '../../features/auth/user/data/data_source/remote_datasource/user_remote_datasource.dart';
import '../../features/auth/user/data/repository/user_remote_repository.dart';
import '../../features/auth/user/domain/repository/user_repository.dart';
import '../../features/auth/user/domain/use_case/user_login_usecase.dart';
import '../../features/auth/user/domain/use_case/user_signup_usecase.dart';
import '../../features/auth/user/presenatation/view_model/user_login_bloc.dart';
import '../../features/auth/user/presenatation/view_model/user_signup_bloc.dart';

// ✅ Captain Authentication Dependencies
import '../../features/auth/captain/data/data_source/remote_datasource/captain_remote_datasource.dart';
import '../../features/auth/captain/data/repository/captain_remote_repository.dart';
import '../../features/auth/captain/domain/repository/captain_repository.dart';
import '../../features/auth/captain/domain/use_case/captain_login_usecase.dart';
import '../../features/auth/captain/domain/use_case/captain_signup_usecase.dart';
import '../../features/auth/captain/presenatation/view_model/captain_signup_bloc.dart';

// ✅ Dependency Injection Container
final GetIt getIt = GetIt.instance;

Future<void> initDependencies() async {
  await _initHiveService();
  await _initSharedPreferences(); // ✅ Ensures SharedPreferences is loaded first
  _initApiService();  // ✅ Now correctly passes both Dio and SharedPreferences
  _initUserAuthDependencies();
  _initCaptainAuthDependencies();
  _initSplashOnboardingDependencies();
}

// ✅ Hive Database Service
Future<void> _initHiveService() async {
  getIt.registerLazySingleton<HiveService>(() => HiveService());
}

// ✅ API Service (Dio)
void _initApiService() {
  getIt.registerLazySingleton<Dio>(() {
    Dio dio = Dio();
    dio.options.baseUrl = "http://10.0.2.2:3000/api/v1/";
    dio.options.connectTimeout = const Duration(seconds: 100);
    dio.options.receiveTimeout = const Duration(seconds: 100);
    dio.options.headers = {'Content-Type': 'application/json'};
    return dio;
  });

  getIt.registerLazySingleton<ApiService>(
        () => ApiService(getIt<Dio>(), getIt<SharedPreferences>()),
  );
}

// ✅ Shared Preferences
Future<void> _initSharedPreferences() async {
  final sharedPreferences = await SharedPreferences.getInstance();
  getIt.registerLazySingleton<SharedPreferences>(() => sharedPreferences);
}

// ✅ User Authentication Dependencies
void _initUserAuthDependencies() {
  getIt.registerLazySingleton<UserRemoteDataSource>(
        () => UserRemoteDataSourceImpl(getIt<Dio>()), // ✅ FIXED: Pass `Dio` instead of `ApiService`
  );

  getIt.registerLazySingleton<UserRepository>(
        () => UserRemoteRepository(remoteDataSource: getIt<UserRemoteDataSource>()),
  );

  getIt.registerLazySingleton<UserLoginUseCase>(
        () => UserLoginUseCase(repository: getIt<UserRepository>()),
  );

  getIt.registerLazySingleton<UserSignupUseCase>(
        () => UserSignupUseCase(repository: getIt<UserRepository>()),
  );

  getIt.registerFactory<UserLoginBloc>(
        () => UserLoginBloc(loginUseCase: getIt<UserLoginUseCase>()),
  );

  getIt.registerFactory<UserSignupBloc>(
        () => UserSignupBloc(signupUseCase: getIt<UserSignupUseCase>()),
  );
}

// ✅ Captain Authentication Dependencies
void _initCaptainAuthDependencies() {
  getIt.registerLazySingleton<CaptainRemoteDataSource>(
        () => CaptainRemoteDataSourceImpl(getIt<Dio>()), // ✅ FIXED: Pass `Dio`
  );

  getIt.registerLazySingleton<CaptainRepository>(
        () => CaptainRemoteRepository(remoteDataSource: getIt<CaptainRemoteDataSource>()), // ✅ FIXED
  );

  getIt.registerLazySingleton<CaptainLoginUseCase>(
        () => CaptainLoginUseCase(repository: getIt<CaptainRepository>()), // ✅ FIXED
  );

  getIt.registerLazySingleton<CaptainSignupUseCase>(
        () => CaptainSignupUseCase(repository: getIt<CaptainRepository>()), // ✅ FIXED
  );

  getIt.registerFactory<CaptainLoginBloc>(
        () => CaptainLoginBloc(loginUseCase: getIt<CaptainLoginUseCase>()),
  );

  getIt.registerFactory<CaptainSignupBloc>(
        () => CaptainSignupBloc(signupUseCase: getIt<CaptainSignupUseCase>()),
  );
}

// ✅ Onboarding & Splash Dependencies
void _initSplashOnboardingDependencies() {
  getIt.registerFactory<SplashCubit>(() => SplashCubit());
  getIt.registerFactory<OnboardingCubit>(() => OnboardingCubit());
}


// 🚀 Future Dependencies (Commented Out)
/*
void _initRideDependencies() {
  getIt.registerFactory<RideRemoteDataSource>(() => RideRemoteDataSource(getIt<ApiService>()));
  getIt.registerLazySingleton<RideRemoteRepository>(() => RideRemoteRepository(getIt<RideRemoteDataSource>()));

  getIt.registerLazySingleton<RequestRideUseCase>(() => RequestRideUseCase(rideRepository: getIt<RideRemoteRepository>()));
  getIt.registerLazySingleton<GetRidesUseCase>(() => GetRidesUseCase(rideRepository: getIt<RideRemoteRepository>()));
  getIt.registerLazySingleton<CancelRideUseCase>(() => CancelRideUseCase(rideRepository: getIt<RideRemoteRepository>()));

  getIt.registerFactory<RideBloc>(() => RideBloc(
    requestRideUseCase: getIt<RequestRideUseCase>(),
    getRidesUseCase: getIt<GetRidesUseCase>(),
    cancelRideUseCase: getIt<CancelRideUseCase>(),
  ));
}

void _initProfileDependencies() {
  getIt.registerFactory<ProfileRemoteDataSource>(() => ProfileRemoteDataSource(getIt<ApiService>()));
  getIt.registerLazySingleton<ProfileRemoteRepository>(() => ProfileRemoteRepository(getIt<ProfileRemoteDataSource>()));

  getIt.registerLazySingleton<GetProfileUseCase>(() => GetProfileUseCase(profileRepository: getIt<ProfileRemoteRepository>()));
  getIt.registerLazySingleton<UpdateProfileUseCase>(() => UpdateProfileUseCase(profileRepository: getIt<ProfileRemoteRepository>()));

  getIt.registerFactory<ProfileBloc>(() => ProfileBloc(
    getProfileUseCase: getIt<GetProfileUseCase>(),
    updateProfileUseCase: getIt<UpdateProfileUseCase>(),
  ));
}

void _initVehicleDependencies() {
  getIt.registerFactory<VehicleRemoteDataSource>(() => VehicleRemoteDataSource(getIt<ApiService>()));
  getIt.registerLazySingleton<VehicleRemoteRepository>(() => VehicleRemoteRepository(getIt<VehicleRemoteDataSource>()));

  getIt.registerLazySingleton<GetVehicleAvailabilityUseCase>(() => GetVehicleAvailabilityUseCase(vehicleRepository: getIt<VehicleRemoteRepository>()));
  getIt.registerLazySingleton<GetFareEstimateUseCase>(() => GetFareEstimateUseCase(vehicleRepository: getIt<VehicleRemoteRepository>()));

  getIt.registerFactory<VehicleBloc>(() => VehicleBloc(
    getVehicleAvailabilityUseCase: getIt<GetVehicleAvailabilityUseCase>(),
    getFareEstimateUseCase: getIt<GetFareEstimateUseCase>(),
  ));
}

void _initSocketDependencies() {
  getIt.registerFactory<SocketBloc>(() => SocketBloc());
}
*/
