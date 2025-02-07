import 'package:flutter_test/flutter_test.dart';
import 'package:bloc_test/bloc_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:uber_mobile_app_project/bloc/auth_bloc.dart';
import 'package:uber_mobile_app_project/data/repositories/auth_repository.dart';


class MockAuthRepository extends Mock implements AuthRepository {}

void main() {
  late MockAuthRepository mockAuthRepository;
  late AuthBloc authBloc;

  setUp(() {
    mockAuthRepository = MockAuthRepository();
    authBloc = AuthBloc(mockAuthRepository);
  });

  blocTest<AuthBloc, AuthState>(
    '✅ emits [AuthLoading, AuthSuccess] when user logs in',
    build: () {
      when(() => mockAuthRepository.login(any(), any())).thenAnswer((_) async => 'mockToken123');
      return authBloc;
    },
    act: (bloc) => bloc.add(LoginEvent(email: 'john@example.com', password: 'password123')),
    expect: () => [AuthLoading(), AuthSuccess(token: 'mockToken123')],
  );

  blocTest<AuthBloc, AuthState>(
    '✅ emits [AuthLoading, AuthLoggedOut] when user logs out',
    build: () {
      when(() => mockAuthRepository.logout()).thenAnswer((_) async => true);
      return authBloc;
    },
    act: (bloc) => bloc.add(LogoutEvent()),
    expect: () => [AuthLoading(), AuthLoggedOut()],
  );
}
