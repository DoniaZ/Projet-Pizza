// lib/providers/user_provider.dart
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:pizzas/Models/user.dart';

class UserProvider with ChangeNotifier {
  User? _user;
  String? _accessToken;
  String? _refreshToken;

  User? get user => _user;
  String? get accessToken => _accessToken;

  Future<void> signUp(String email, String password) async {
    final url = Uri.parse('https://pizzas.shrp.dev/users');
    final response = await http.post(
      url,
      headers: {'Content-Type': 'application/json'},
            body: jsonEncode(User(email: email, password: password).toJson()),

    );

    if (response.statusCode == 201) {
    } else {
      throw Exception('Failed to sign up');
    }
  }

  Future<void> signIn(String email, String password) async {
    final url = Uri.parse('https://pizzas.shrp.dev/auth/login');
    final response = await http.post(
      url,
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({
        'email': email,
        'password': password,
      }),
    );

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      _accessToken = data['access_token'];
      _refreshToken = data['refresh_token'];
      notifyListeners();
    } else {
      throw Exception('Failed to sign in');
    }
  }

  Future<void> signOut() async {
    _accessToken = null;
    _refreshToken = null;
    _user = null;
    notifyListeners();
  }

  Future<void> refreshAccessToken() async {
    final url = Uri.parse('https://pizzas.shrp.dev/auth/refresh');
    final response = await http.post(
      url,
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $_refreshToken',
      },
    );

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      _accessToken = data['access_token'];
      notifyListeners();
    } else {
      throw Exception('Failed to refresh access token');
    }
  }
}
