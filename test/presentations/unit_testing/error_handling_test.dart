import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:uber_mobile_app_project/data/repositories/user_repository.dart';

// Mock Repository
class MockUserRepository extends Mock implements UserRepository {}

void main() {
  late MockUserRepository mockUserRepository;

  setUp(() {
    mockUserRepository = MockUserRepository();
  });

  test(' Should throw an error when fetching user profile fails', () async {
    when(() => mockUserRepository.getUserProfile(any()))
        .thenThrow(Exception("Profile fetch error"));

    expect(() => mockUserRepository.getUserProfile('1'), throwsException);
  });

  test('🔟 Should throw an error when registering a user fails', () async {
    when(() => mockUserRepository.register(any()))
        .thenThrow(Exception("Registration error"));

    expect(() => mockUserRepository.register({
      "name": "New User",
      "email": "new@example.com",
      "password": "password123"
    }), throwsException);
  });
}
