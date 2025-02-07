import 'package:flutter_test/flutter_test.dart';
import 'package:bloc_test/bloc_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:uber_mobile_app_project/bloc/user_bloc.dart';

import 'package:uber_mobile_app_project/data/repositories/user_repository.dart';
import 'package:uber_mobile_app_project/data/models/user_model.dart';

class MockUserRepository extends Mock implements UserRepository {}

void main() {
  late MockUserRepository mockUserRepository;
  late UserBloc userBloc;

  final mockUser = User(
    id: '1',
    name: 'John Doe',
    email: 'john@example.com',
    phone: '1234567890',
    token: 'mockToken123',
  );

  setUp(() {
    mockUserRepository = MockUserRepository();
    userBloc = UserBloc(mockUserRepository);
  });

  blocTest<UserBloc, UserState>(
    '✅ emits [UserLoading, UserAuthenticated] when user logs in',
    build: () {
      when(() => mockUserRepository.login(any(), any())).thenAnswer((_) async => mockUser);
      return userBloc;
    },
    act: (bloc) => bloc.add(LoginUserEvent(email: 'john@example.com', password: 'password123')),
    expect: () => [UserLoading(), UserAuthenticated(user: mockUser)],
  );
}
