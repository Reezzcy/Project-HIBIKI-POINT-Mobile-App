import 'package:flutter/material.dart';
import 'package:project_hibiki_point_mobile_app/data/database/remote/repository/auth_repository.dart';
import 'package:project_hibiki_point_mobile_app/services/auth_service.dart';

class AuthProvider extends ChangeNotifier {
  // Use global instances
  final AuthRepository _authRepository = authRepository;
  final AuthService _authService = authService;

  bool _isAuthenticated = false;
  bool _isLoading = false;
  String? _error;
  String? _token;
  String? _userId;
  String? _email;

  bool get isAuthenticated => _isAuthenticated;
  bool get isLoading => _isLoading;
  String? get error => _error;
  String? get token => _token;
  String? get userId => _userId;
  String? get email => _email;

  AuthProvider() {
    // Check authentication status when provider is created
    checkLoginStatus();
  }

  Future<void> checkLoginStatus() async {
    _isLoading = true;
    notifyListeners();

    try {
      _token = await _authService.getToken();
      _isAuthenticated = _token != null;

      if (_isAuthenticated) {
        _userId = await _authService.getUserId();
        _email = await _authService.getUserEmail();
        print("Auth restored: ID=$_userId, Email=$_email");
      }
    } catch (e) {
      _error = e.toString();
      print("Auth check error: $_error");
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  Future<bool> login(String email, String password) async {
    _isLoading = true;
    _error = null;
    notifyListeners();

    try {
      print("Attempting login for email: $email");
      final loginResponse = await _authRepository.loginWithEmailPassword(email, password);

      print("Login response received: ${loginResponse.generateToken}");
      _token = loginResponse.generateToken;
      _userId = loginResponse.userId;
      _email = loginResponse.email;
      _isAuthenticated = true;

      // Save to SharedPreferences
      await _authService.saveToken(_token!);
      await _authService.saveUserInfo(
        userId: _userId!,
        email: _email!,
      );

      _isLoading = false;
      notifyListeners();
      return true;
    } catch (e) {
      _error = e.toString();
      print("Login error: $_error");
      _isLoading = false;
      notifyListeners();
      return false;
    }
  }

  Future<bool> loginWithGoogle() async {
    _isLoading = true;
    _error = null;
    notifyListeners();

    try {
      print("Attempting Google login");
      final loginResponse = await _authRepository.loginWithGoogle();

      print("Google login response received");
      _token = loginResponse.token;
      _userId = loginResponse.user.userId.toString();
      _email = loginResponse.user.name;
      _isAuthenticated = true;

      // Save to SharedPreferences
      await _authService.saveToken(_token!);
      await _authService.saveUserInfo(
        userId: _userId!,
        email: _email!,
        username: loginResponse.user.name,
      );

      _isLoading = false;
      notifyListeners();
      return true;
    } catch (e) {
      _error = e.toString();
      print("Google login error: $_error");
      _isLoading = false;
      notifyListeners();
      return false;
    }
  }

  Future<void> logout() async {
    _isLoading = true;
    notifyListeners();

    try {
      await _authService.clearAuth();
      _token = null;
      _userId = null;
      _email = null;
      _isAuthenticated = false;
    } catch (e) {
      _error = e.toString();
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }
}