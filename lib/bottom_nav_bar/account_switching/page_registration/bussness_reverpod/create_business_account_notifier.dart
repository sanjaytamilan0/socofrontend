import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart'as http;
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../profile_screen/profile_screen.dart';
import '../../../../common/api_list/api_list.dart';

// State to hold form values and loading/error states
class RegistrationState {
  final bool isLoading;
  final String? error;
  final bool isSuccess;

  RegistrationState({
    this.isLoading = false,
    this.error,
    this.isSuccess = false,
  });

  RegistrationState copyWith({
    bool? isLoading,
    String? error,
    bool? isSuccess,
  }) {
    return RegistrationState(
      isLoading: isLoading ?? this.isLoading,
      error: error ?? this.error,
      isSuccess: isSuccess ?? this.isSuccess,
    );
  }
}

// Provider for registration state
final registrationProvider = StateNotifierProvider<RegistrationNotifier, RegistrationState>((ref) {
  return RegistrationNotifier();
});

class RegistrationNotifier extends StateNotifier<RegistrationState> {
  RegistrationNotifier() : super(RegistrationState());

  Future<void> registerBusiness(Map<String, dynamic> data,BuildContext context) async {
    state = state.copyWith(isLoading: true);

    try {

      await Future.delayed(const Duration(seconds: 2));

      final response = await http.post(
        Uri.parse(Api.createBusinessAccount),
        body: jsonEncode(data),
        headers: {"Content-Type": "application/json"},
      );
      print(response.statusCode);
      if (response.statusCode == 201) {
        state = state.copyWith(isLoading: false, isSuccess: true);
        Navigator.push(context, MaterialPageRoute(builder: (context)=>ProfileScreen()));
      } else {
        state = state.copyWith(isLoading: false, error: 'Registration failed');
      }

      state = state.copyWith(isLoading: false, isSuccess: true); // Simulated success
    } catch (e) {
      print(e.toString());
      state = state.copyWith(isLoading: false, error: e.toString());

    }
  }
}
