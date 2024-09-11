import 'dart:convert';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:http/http.dart' as http;
import '../../../common/api_list/api_list.dart';

class SendOtpState {
  final bool isLoading;
  final String? error;
  final bool isOtpSent;

  SendOtpState({required this.isLoading, this.error, required this.isOtpSent});
}

class SendOtpNotifier extends StateNotifier<SendOtpState> {
  SendOtpNotifier() : super(SendOtpState(isLoading: false, error: null, isOtpSent: false));

  Future<void> sendOtp(String email) async {
    state = SendOtpState(isLoading: true, error: null, isOtpSent: false);
    try {
      final response = await http.post(
        Uri.parse(Api.sendOtp),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({'email': email}),
      );

      if (response.statusCode == 200) {
        state = SendOtpState(isLoading: false, error: null, isOtpSent: true);
        // OTP sent successfully, you can update the UI or navigate as necessary
      } else {
        throw Exception('Failed to send OTP: ${response.body}');
      }
    } catch (e) {
      state = SendOtpState(isLoading: false, error: e.toString(), isOtpSent: false);
    }
  }
}

final sendOtpProvider = StateNotifierProvider<SendOtpNotifier, SendOtpState>((ref) {
  return SendOtpNotifier();
});
