import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import '../../../common/api_list/api_list.dart';

class LoginState {
  final bool isLoading;
  final String? error;

  LoginState({required this.isLoading, this.error});
}

class LoginNotifier extends StateNotifier<LoginState> {
  LoginNotifier() : super(LoginState(isLoading: false, error: null));

  Future<void> login(String email, String password) async {
    state = LoginState(isLoading: true, error: null);
    try {
      final prefs = await SharedPreferences.getInstance();
      final response = await http.post(
        Uri.parse(kIsWeb ? Api.login : Api.loginMobile),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({
          "email": email,
          "password": password,
        }),

      );
      print(response.statusCode);

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        print(data);
        final jwtToken = data['token'];
        final userId = data['_id'];
        print(jwtToken);
        print(userId);
        await prefs.setString('jwtToken', jwtToken);
        await prefs.setString('userId', userId);

        print(prefs);
        state = LoginState(isLoading: false, error: null);
        // Navigate to the home screen
      } else {
        throw Exception('Failed to login: ${response.body}');
      }
    } catch (e) {
      state = LoginState(isLoading: false, error: e.toString());
      print(e.toString());
    }
  }

  Future<void> logout() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove('jwtToken');

    // Navigate back to the login screen
  }
}

final loginProvider = StateNotifierProvider<LoginNotifier, LoginState>((ref) {
  return LoginNotifier();
});
