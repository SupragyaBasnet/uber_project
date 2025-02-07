import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:uber_mobile_app_project/data/repositories/user_repository.dart';
import 'package:uber_mobile_app_project/data/models/user_model.dart';

// Mock Repository
class MockUserRepository extends Mock implements UserRepository {}

void main() {
  late MockUserRepository mockUserRepository;

  setUp(() {
    mockUserRepository = MockUserRepository();
  });

  final mockUser = User(
    id: '1',
    name: 'John Doe',
    email: 'john@example.com',
    phone: '1234567890',
    token: 'mockToken123',
  );

  test('1️⃣ Should successfully login and return a User', () async {
    when(() => mockUserRepository.login('john@example.com', 'password'))
        .thenAnswer((_) async => mockUser);

    final result = await mockUserRepository.login('john@example.com', 'password');

    expect(result, isA<User>());
    expect(result?.name, 'John Doe');
    verify(() => mockUserRepository.login(any(), any())).called(1);
  });

  test('2️⃣ Should return null for incorrect login details', () async {
    when(() => mockUserRepository.login('wrong@example.com', 'wrongpassword'))
        .thenAnswer((_) async => null);

    final result = await mockUserRepository.login('wrong@example.com', 'wrongpassword');

    expect(result, isNull);
    verify(() => mockUserRepository.login(any(), any())).called(1);
  });
}
