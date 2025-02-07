// lib/presentation/providers/user_provider.dart
import 'package:flutter/material.dart';
import '../../data/models/user_model.dart';
import '../../data/repositories/user_repository.dart';

class UserProvider with ChangeNotifier {
  final UserRepository userRepository;

  User? _user;
  bool _isLoading = false;
  String? _errorMessage;
  bool _notificationsEnabled = true;
  bool _isDarkMode = false;

  UserProvider({required this.userRepository});

  User? get user => _user;
  bool get isLoading => _isLoading;
  String? get errorMessage => _errorMessage;
  bool get notificationsEnabled => _notificationsEnabled;
  bool get isDarkMode => _isDarkMode;

  /// Fetch user profile
  Future<void> fetchUserProfile(String userId) async {
    _isLoading = true;
    _errorMessage = null;
    notifyListeners();

    try {
      _user = await userRepository.getUserProfile(userId);
    } catch (e) {
      _errorMessage = "Failed to fetch profile: $e";
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  /// Update user profile
  Future<bool> updateUserProfile({required String name}) async {
    if (_user == null) return false;

    _isLoading = true;
    notifyListeners();

    try {
      final updatedUser = await userRepository.updateUserProfile(_user!.id, name);
      if (updatedUser != null) {
        _user = updatedUser;
        notifyListeners();
        return true;
      } else {
        return false;
      }
    } catch (e) {
      _errorMessage = "Error updating profile: $e";
      return false;
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  /// ✅ **Enable or disable notifications**
  void updateNotificationSettings(bool isEnabled) {
    _notificationsEnabled = isEnabled;
    notifyListeners();
  }

  /// ✅ **Enable or disable dark mode**
  void updateTheme(bool isDark) {
    _isDarkMode = isDark;
    notifyListeners();
  }
}
