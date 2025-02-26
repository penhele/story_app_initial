import 'package:tes_auth/model/login_request.dart';
import 'package:tes_auth/model/login_response.dart';
import 'package:tes_auth/model/register_request.dart';
import 'package:tes_auth/model/register_response.dart';
import 'package:tes_auth/service/auth_service.dart';

import '../db/auth_repository.dart';
import 'package:flutter/material.dart';

class AuthProvider extends ChangeNotifier {
  final AuthRepository authRepository;
  final AuthService authService;

  AuthProvider(this.authRepository, this.authService);

  bool isLoadingLogin = false;
  bool isLoadingLogout = false;
  bool isLoadingRegister = false;
  bool isLoggedIn = false;
  bool _isRegistered = false;

  LoginResponse? loginResponse;
  RegisterResponse? _registerResponse;

  bool get isRegistered => _isRegistered;
  RegisterResponse? get registerResponse => _registerResponse;

  String _message = "";
  String get message => _message;

  Future<bool> login(LoginRequest loginData) async {
    isLoadingLogin = true;
    notifyListeners();

    try {
      loginResponse = await authService.loginUser(loginData);
      if (loginResponse != null) {
        final userToken = loginResponse!.loginResult.token;

        await authRepository.saveToken(userToken);
        await authRepository.login();
      }

      _message = loginResponse!.message;
      notifyListeners();

      isLoadingLogin = false;
      notifyListeners();
    } catch (e) {
      _message = "Error: $e";

      isLoadingLogin = false;
      notifyListeners();
    }

    isLoggedIn = await authRepository.isLoggedIn();

    return isLoggedIn;
  }

  Future<bool> logout() async {
    isLoadingLogout = true;
    notifyListeners();

    final logout = await authRepository.logout();
    if (logout) {
      await authRepository.deleteToken();
    }
    isLoggedIn = await authRepository.isLoggedIn();

    isLoadingLogout = false;
    notifyListeners();

    return !isLoggedIn;
  }

  Future<bool> userRegister(RegisterRequest registerData) async {
    _message = "";
    isLoadingRegister = true;
    notifyListeners();

    try {
      _registerResponse = await authService.registerUser(registerData);

      _isRegistered = (_registerResponse!.error == false) ? true : false;

      _message = registerResponse?.message ?? "Success";
      isLoadingRegister = false;
      notifyListeners();
    } catch (e) {
      _isRegistered = false;
      _message = "Error: $e";
      isLoadingRegister = false;
      notifyListeners();
    }

    return isRegistered;
  }
}
