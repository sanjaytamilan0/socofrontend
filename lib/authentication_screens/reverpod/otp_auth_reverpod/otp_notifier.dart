import 'dart:convert';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:http/http.dart' as http;
import '../../../common/api_list/api_list.dart';

class OtpState {
  final bool isLoading;
  final String? error;
  final bool verify;

  OtpState({required this.isLoading, this.error,required this.verify});
}

class OtpNotifier extends StateNotifier<OtpState> {
  OtpNotifier() : super(OtpState(isLoading: false, error: null , verify: false));

  Future<void> verifyOtp(String email,String otp) async {
    state = OtpState(isLoading: true, error: null, verify: false);
    try {
      print('++++++++++++');
      final response = await http.post(
        Uri.parse(Api.verifyOtp),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({"email":email,'otp': otp}),
      );
     print(response.statusCode);
      if (response.statusCode == 200) {
        state = OtpState(isLoading: false, error: null,verify: true);

      } else {
        throw Exception('Failed to verify OTP: ${response.body}');
      }
    } catch (e) {
      state = OtpState(isLoading: false, error: e.toString(),verify: false);
    }
  }
}

final otpProvider = StateNotifierProvider<OtpNotifier, OtpState>((ref) {
  return OtpNotifier();
});
