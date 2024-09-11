import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../common/api_list/api_list.dart';

class RegisterState {
  final bool isLoading;
  final String? error;

  RegisterState({required this.isLoading, this.error});
}

class RegisterNotifier extends StateNotifier<RegisterState> {
  RegisterNotifier() : super(RegisterState(isLoading: false, error: null));

  String? username;
  String? email;
  String? password;

  Future<bool> register() async {
    state = RegisterState(isLoading: true, error: null);
    try {
      final success = await registerApi(username!, email!, password!); // Call your API here
      state = RegisterState(isLoading: false, error: null);
      return success;
    } catch (e) {
      state = RegisterState(isLoading: false, error: e.toString());
      return false;
    }
  }
}

final registerProvider = StateNotifierProvider<RegisterNotifier, RegisterState>((ref) {
  return RegisterNotifier();
});

Future<bool> registerApi(String username, String email, String password) async {
  final response = await http.post(
    Uri.parse(Api.createUser),
    headers: {'Content-Type': 'application/json'},
    body: jsonEncode({
      'name': username,
      'email': email,
      'password': password,
    }),
  );

  print('Status Code: ${response.statusCode}');
  print('Response Body: ${response.body}'); // Print the response body for debugging

  if (response.statusCode == 201) {
    return true;
  } else {
    // Include more detailed error information
    throw Exception('Failed to register user: ${response.body}');
  }
}

