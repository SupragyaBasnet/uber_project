import 'package:flutter_test/flutter_test.dart';
import 'package:bloc_test/bloc_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:uber_mobile_app_project/bloc/profile_bloc.dart';

import 'package:uber_mobile_app_project/data/repositories/user_repository.dart';
import 'package:uber_mobile_app_project/data/models/user_model.dart';

class MockUserRepository extends Mock implements UserRepository {}

void main() {
  late MockUserRepository mockUserRepository;
  late ProfileBloc profileBloc;

  final mockUser = User(
    id: '1',
    name: 'John Doe',
    email: 'john@example.com',
    phone: '1234567890',
    token: 'mockToken123',
  );

  setUp(() {
    mockUserRepository = MockUserRepository();
    profileBloc = ProfileBloc(mockUserRepository);
  });

  blocTest<ProfileBloc, ProfileState>(
    '✅ emits [ProfileLoading, ProfileLoaded] when user profile is fetched',
    build: () {
      when(() => mockUserRepository.getUserProfile(any())).thenAnswer((_) async => mockUser);
      return profileBloc;
    },
    act: (bloc) => bloc.add(FetchProfileEvent('1')),
    expect: () => [ProfileLoading(), ProfileLoaded(user: mockUser)],
  );
}
