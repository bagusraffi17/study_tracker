import 'package:flutter/foundation.dart';
import 'package:shared_preferences/shared_preferences.dart';

/// AuthProvider manages authentication state using SharedPreferences
class AuthProvider extends ChangeNotifier {
  bool _isAuthenticated = false;
  String? _currentUserEmail;

  bool get isAuthenticated => _isAuthenticated;
  String? get currentUserEmail => _currentUserEmail;

  static const String _keyIsAuthenticated = 'is_authenticated';
  static const String _keyUserEmail = 'user_email';

  AuthProvider() {
    _loadAuthState();
  }

  Future<void> _loadAuthState() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      _isAuthenticated = prefs.getBool(_keyIsAuthenticated) ?? false;
      _currentUserEmail = prefs.getString(_keyUserEmail);
      notifyListeners();
    } catch (e) {
      debugPrint('Error loading auth state: $e');
    }
  }

  Future<bool> login(String email, String password) async {
    if (email.isEmpty || password.length < 6) {
      return false;
    }

    try {
      await Future.delayed(const Duration(milliseconds: 500));

      final prefs = await SharedPreferences.getInstance();
      await prefs.setBool(_keyIsAuthenticated, true);
      await prefs.setString(_keyUserEmail, email);

      _isAuthenticated = true;
      _currentUserEmail = email;
      notifyListeners();

      return true;
    } catch (e) {
      debugPrint('Error during login: $e');
      return false;
    }
  }

  Future<void> logout() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      await prefs.remove(_keyIsAuthenticated);
      await prefs.remove(_keyUserEmail);

      _isAuthenticated = false;
      _currentUserEmail = null;
      notifyListeners();
    } catch (e) {
      debugPrint('Error during logout: $e');
    }
  }

  Future<bool> checkAuthStatus() async {
    await _loadAuthState();
    return _isAuthenticated;
  }
}
