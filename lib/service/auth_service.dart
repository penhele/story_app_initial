import 'dart:convert';

import 'package:tes_auth/model/login_request.dart';
import 'package:tes_auth/model/login_response.dart';
import 'package:tes_auth/model/register_request.dart';
import 'package:tes_auth/model/register_response.dart';
import 'package:http/http.dart' as http;

class AuthService {
  static const String _baseUrl = 'https://story-api.dicoding.dev/v1';

  Future<RegisterResponse> registerUser(RegisterRequest registerData) async {
    final response = await http.post(
      Uri.parse('$_baseUrl/register'),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode(registerData.toJson()),
    );

    if (response.statusCode == 201) {
      return RegisterResponse.fromJson(jsonDecode(response.body));
    } else {
      throw Exception('Failed to register user: ${response.body}');
    }
  }

  Future<LoginResponse> loginUser(LoginRequest loginData) async {
    final response = await http.post(
      Uri.parse('$_baseUrl/login'),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode(loginData.toJson())
    );

    if (response.statusCode == 200) {
      return LoginResponse.fromJson(jsonDecode(response.body));
    } else {
      throw Exception('Failed to login user: ${response.body}');
    }
  }
}
