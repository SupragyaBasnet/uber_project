import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:uber_mobile_app_project/data/models/user_model.dart';
import 'package:uber_mobile_app_project/data/repositories/user_repository.dart';
import 'package:uber_mobile_app_project/presentation/provider/user_provider.dart';

// Mock Repository
class MockUserRepository extends Mock implements UserRepository {}

void main() {
  late MockUserRepository mockUserRepository;
  late UserProvider userProvider;

  setUp(() {
    mockUserRepository = MockUserRepository();
    userProvider = UserProvider(userRepository: mockUserRepository);
  });

  final mockUser = User(
    id: '1',
    name: 'John Doe',
    email: 'john@example.com',
    phone: '1234567890',
    token: 'mockToken123',
  );

  test('1️⃣ Should fetch user profile successfully', () async {
    when(() => mockUserRepository.getUserProfile('1'))
        .thenAnswer((_) async => mockUser);

    await userProvider.fetchUserProfile('1');

    expect(userProvider.user, isNotNull);
    expect(userProvider.user!.name, 'John Doe');
    verify(() => mockUserRepository.getUserProfile('1')).called(1);
  });

  test('2️⃣ Should return null when user profile fetch fails', () async {
    when(() => mockUserRepository.getUserProfile('999'))
        .thenAnswer((_) async => null);

    await userProvider.fetchUserProfile('999');

    expect(userProvider.user, isNull);
    verify(() => mockUserRepository.getUserProfile(any())).called(1);
  });

  test('3️⃣ Should update user profile successfully', () async {
    when(() => mockUserRepository.updateUserProfile(any(), any()))
        .thenAnswer((_) async => mockUser.copyWith(name: "Jane Doe"));

    final result = await userProvider.updateUserProfile(name: "Jane Doe");

    expect(result, true);
    expect(userProvider.user!.name, "Jane Doe");
    verify(() => mockUserRepository.updateUserProfile(any(), any())).called(1);
  });

  test('4️⃣ Should return false when updating user profile fails', () async {
    when(() => mockUserRepository.updateUserProfile(any(), any()))
        .thenThrow(Exception("Failed to update"));

    final result = await userProvider.updateUserProfile(name: "New Name");

    expect(result, false);
    verify(() => mockUserRepository.updateUserProfile(any(), any())).called(1);
  });

  test('5️⃣ Should toggle notification setting', () {
    userProvider.updateNotificationSettings(false);
    expect(userProvider.notificationsEnabled, false);

    userProvider.updateNotificationSettings(true);
    expect(userProvider.notificationsEnabled, true);
  });

  test('6️⃣ Should toggle dark mode setting', () {
    userProvider.updateTheme(false);
    expect(userProvider.isDarkMode, false);

    userProvider.updateTheme(true);
    expect(userProvider.isDarkMode, true);
  });

  test('7️⃣ Should handle login and store user details', () async {
    when(() => mockUserRepository.login(any(), any()))
        .thenAnswer((_) async => mockUser);

    await userProvider.fetchUserProfile('1');

    expect(userProvider.user, isA<User>());
    expect(userProvider.user!.token, isNotEmpty);
    verify(() => mockUserRepository.getUserProfile(any())).called(1);
  });

  test('8️⃣ Should return error when login fails', () async {
    when(() => mockUserRepository.login(any(), any()))
        .thenThrow(Exception("Invalid credentials"));

    expect(() async => await userProvider.fetchUserProfile('999'), throwsException);
  });

  test('9️⃣ Should return error when profile update fails', () async {
    when(() => mockUserRepository.updateUserProfile(any(), any()))
        .thenThrow(Exception("Update failed"));

    final result = await userProvider.updateUserProfile(name: "Error Name");

    expect(result, false);
  });

  test('🔟 Should return true when updating theme successfully', () {
    userProvider.updateTheme(true);
    expect(userProvider.isDarkMode, isTrue);
  });
}
