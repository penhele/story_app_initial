import 'package:flutter/material.dart';
import '../api/api_service.dart';
import '../model/register_request.dart';
import '../model/register_response.dart';
import '../db/auth_repository.dart';
import '../model/login_request.dart';
import '../model/login_response.dart';
import '../service/auth_service.dart';
import '../model/story.dart';

class AuthProvider extends ChangeNotifier {
  final AuthRepository authRepository;
  final AuthService authService;
  final ApiService apiService;

  AuthProvider(this.authRepository, this.authService, this.apiService);

  bool isLoadingLogin = false;
  bool isLoadingLogout = false;
  bool isLoadingRegister = false;
  bool isLoggedIn = false;
  bool isLoadingFetch = false;

  String? _token;
  List<Story> _stories = [];

  String? get token => _token;
  List<Story> get stories => _stories;

  Future<bool> login(LoginRequest loginData) async {
    isLoadingLogin = true;
    notifyListeners();

    try {
      LoginResponse response = await authService.login(loginData);
      _token = response.loginResult.token;
      await authRepository.login(_token!);
    } catch (e) {
      _token = null;
    }

    isLoggedIn = await authRepository.isLoggedIn();

    isLoadingLogin = false;
    notifyListeners();

    return isLoggedIn;
  }

  Future<bool> logout() async {
    isLoadingLogout = true;
    notifyListeners();

    _token = null;
    await authRepository.logout();
    notifyListeners();

    isLoggedIn = await authRepository.isLoggedIn();

    isLoadingLogout = false;
    notifyListeners();

    return !isLoggedIn;
  }

  /// **Logout pengguna**
  // Future<bool> logout() async {
  //   isLoadingLogout = true;
  //   notifyListeners();

  //   final logoutSuccess = await authRepository.logout();
  //   if (logoutSuccess) {
  //     _token = null;
  //     isLoggedIn = false;
  //   }

  //   isLoadingLogout = false;
  //   notifyListeners();
  //   return !isLoggedIn;
  // }

  Future<bool> register(RegisterRequest registerData) async {
    isLoadingRegister = true;
    notifyListeners();

    try {
      RegisterResponse response = await authService.register(registerData);
      return !response.error;
    } catch (e) {
      return false;
    } finally {
      isLoadingRegister = false;
      notifyListeners();
    }
  }

  Future<void> loadToken() async {
    _token = await authRepository.getToken();
    notifyListeners();
  }

  Future<void> fetchStories() async {
    if (_token == null) return;

    isLoadingFetch = true;
    notifyListeners();

    try {
      final response = await apiService.getStories(_token!);
      _stories = response.stories;
    } catch (e) {
      print("Error fetching stories: $e");
    }

    isLoadingFetch = false;
    notifyListeners();
  }
}
