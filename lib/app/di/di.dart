import 'package:get_it/get_it.dart';
import 'package:dio/dio.dart';
import 'package:hive/hive.dart';
import 'package:path_provider/path_provider.dart';

// Core
import 'package:uber_mobile_app_project/core/network/api_service.dart';

// Repositories

import '../../core/network/hive_service.dart';
import '../../features/auth/captain/domain/repository/captain_repository.dart';
import '../../features/auth/captain/domain/repository/captain_repository_impl.dart';
import '../../features/auth/captain/presenatation/view_model/captain_login.bloc.dart';

import '../../features/auth/user/domain/repository/user_repository.dart';

// Authentication Blocs

import '../../features/auth/captain/presenatation/view_model/captain_signup_bloc.dart';
import '../../features/auth/user/domain/repository/user_repository_impl.dart';
import '../../features/auth/user/presenatation/view_model/user_login_bloc.dart';
import '../../features/auth/user/presenatation/view_model/user_signup_bloc.dart';
import '../../features/auth/forgot_password/presenatation/view_model/forgot_password_bloc.dart';

// Other Cubits
import '../../features/captain_home/presenatation/view_model/splash_cubit.dart';
// import '../../features/onboarding/presenatation/view_model/onboarding_cubit.dart';

// API Endpoints
import '../constants/api_endpoints.dart';

// ✅ GetIt instance
final GetIt serviceLocator = GetIt.instance;

Future<void> setupDI() async {
    // ✅ Initialize Dio for API Calls
    Dio dio = Dio(BaseOptions(
      baseUrl: ApiEndpoints.baseUrl,
      connectTimeout: const Duration(seconds: 10),
      receiveTimeout: const Duration(seconds: 10),
      contentType: "application/json",
    ));

    // ✅ Add logging interceptor (for debugging API requests)
    dio.interceptors.add(LogInterceptor(responseBody: true, requestBody: true));

    // ✅ Initialize Hive for Local Storage
    final appDocumentDir = await getApplicationDocumentsDirectory();
    Hive.init(appDocumentDir.path);

    // ✅ Open Hive Boxes
    final userBox = await Hive.openBox('userBox');
    final captainBox = await Hive.openBox('captainBox');

    // ✅ Register Hive Service (Dependency required for ApiService)
    serviceLocator.registerLazySingleton<HiveService>(() => HiveService());

    // ✅ Register API Service (🔥 FIX: Pass both `dio` & `HiveService`)
    serviceLocator.registerLazySingleton<ApiService>(
          () => ApiService(dio, serviceLocator<HiveService>()),
    );
    // ✅ Register User Repository
    serviceLocator.registerLazySingleton<UserRepository>(
          () =>
          UserRepositoryImpl(
            apiService: serviceLocator<ApiService>(),
            userBox: userBox,
          ),
    );

    // ✅ Register Captain Repository
    serviceLocator.registerLazySingleton<CaptainRepository>(
          () =>
          CaptainRepositoryImpl(
            apiService: serviceLocator<ApiService>(),
            captainBox: captainBox,
          ),
    );

    // ✅ Register Blocs for User Authentication
    // ✅ Register UserLoginBloc
    serviceLocator.registerFactory<UserLoginBloc>(
          () => UserLoginBloc(
        userRepository: serviceLocator<UserRepository>(),
        apiService: serviceLocator<ApiService>(),
      ),
    );

    serviceLocator.registerFactory<UserSignupBloc>(
          () =>
          UserSignupBloc(
            userRepository: serviceLocator<UserRepository>(),
            apiService: serviceLocator<
                ApiService>(), // ✅ Inject ApiService if required
          ),
    );

    // ✅ Register Blocs for Captain Authentication
    serviceLocator.registerFactory<CaptainLoginBloc>(
          () =>
          CaptainLoginBloc(
            captainRepository: serviceLocator<CaptainRepository>(),
            apiService: serviceLocator<
                ApiService>(), // ✅ Inject ApiService if required
          ),
    );

    serviceLocator.registerFactory<CaptainSignupBloc>(
          () =>
          CaptainSignupBloc(
            captainRepository: serviceLocator<CaptainRepository>(),
            apiService: serviceLocator<
                ApiService>(), // ✅ Inject ApiService if required
          ),
    );

    // ✅ Register Forgot Password Bloc
    serviceLocator.registerFactory<ForgotPasswordBloc>(
          () =>
          ForgotPasswordBloc(
            userRepository: serviceLocator<UserRepository>(),
            apiService: serviceLocator<
                ApiService>(), // ✅ Inject ApiService if required
          ),
    );

    // ✅ Register Cubits for Onboarding & Splash
//     serviceLocator.registerFactory<OnboardingCubit>(
      //     () => OnboardingCubit(),
//     );

    serviceLocator.registerFactory<SplashCubit>(
          () => SplashCubit(),
    );

    // ✅ Uncomment when Home Blocs are ready
    // serviceLocator.registerFactory<UserHomeBloc>(
    //   () => UserHomeBloc(serviceLocator<UserRepository>()),
    // );

    // serviceLocator.registerFactory<CaptainHomeBloc>(
    //   () => CaptainHomeBloc(serviceLocator<CaptainRepository>()),
    // );
  }
