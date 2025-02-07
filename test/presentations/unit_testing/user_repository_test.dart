import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:uber_mobile_app_project/data/models/user_model.dart';

import 'dart:convert';

import 'package:uber_mobile_app_project/data/repositories/user_repository.dart';

// Mock Repository
class MockUserRepository extends Mock implements UserRepository {}

void main() {
  late MockUserRepository mockUserRepository;
  late UserRepository userRepository;

  setUp(() {
    mockUserRepository = MockUserRepository();
    userRepository = UserRepository();
  });

  final mockUser = User(
    id: '1',
    name: 'John Doe',
    email: 'john@example.com',
    phone: '1234567890',
    token: 'mockToken123',
  );

  test('1️⃣ Should log in user and return user object', () async {
    when(() => mockUserRepository.login('john@example.com', 'password'))
        .thenAnswer((_) async => mockUser);

    final result = await mockUserRepository.login('john@example.com', 'password');

    expect(result, isA<User>());
    expect(result?.name, 'John Doe');
    verify(() => mockUserRepository.login(any(), any())).called(1);
  });

  test('2️⃣ Should return null for invalid login credentials', () async {
    when(() => mockUserRepository.login('wrong@example.com', 'wrongpassword'))
        .thenAnswer((_) async => null);

    final result = await mockUserRepository.login('wrong@example.com', 'wrongpassword');

    expect(result, isNull);
    verify(() => mockUserRepository.login(any(), any())).called(1);
  });

  test('3️⃣ Should register a user successfully', () async {
    when(() => mockUserRepository.register(any())).thenAnswer((_) async => mockUser);

    final result = await mockUserRepository.register({
      "name": "John Doe",
      "email": "john@example.com",
      "password": "password123",
      "phone": "1234567890"
    });

    expect(result, isA<User>());
    expect(result.email, 'john@example.com');
    verify(() => mockUserRepository.register(any())).called(1);
  });

  test('4️⃣ Should return user profile by ID', () async {
    when(() => mockUserRepository.getUserProfile('1'))
        .thenAnswer((_) async => mockUser);

    final result = await mockUserRepository.getUserProfile('1');

    expect(result, isA<User>());
    expect(result?.name, 'John Doe');
    verify(() => mockUserRepository.getUserProfile(any())).called(1);
  });

  test('5️⃣ Should return null when user profile not found', () async {
    when(() => mockUserRepository.getUserProfile('999'))
        .thenAnswer((_) async => null);

    final result = await mockUserRepository.getUserProfile('999');

    expect(result, isNull);
    verify(() => mockUserRepository.getUserProfile(any())).called(1);
  });
}
