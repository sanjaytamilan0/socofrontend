import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';
import '../../../../common/api_list/api_list.dart';
import '../../../../common/model/user_account_model.dart';

final accountProvider = StateNotifierProvider<AccountNotifier, AccountState>(
      (ref) => AccountNotifier(),
);

enum AccountStateStatus { loading, success, error }

class AccountState {
  final AccountStateStatus status;
  final List<UserAccount>? userAccounts; // Changed from single UserAccount to list
  final String? errorMessage;

  AccountState({
    required this.status,
    this.userAccounts, // Updated to list
    this.errorMessage,
  });
}


class AccountNotifier extends StateNotifier<AccountState> {
  AccountNotifier() : super(AccountState(status: AccountStateStatus.loading));

  Future<void> fetchAccount() async {
    state = AccountState(status: AccountStateStatus.loading);
    SharedPreferences pref = await SharedPreferences.getInstance();
    final userId = pref.getString("userId");
    final body = jsonEncode({"userId": userId});
    print(userId);

    try {
      final response = await http.post(
        Uri.parse(Api.getAccount),
        body: body,
        headers: {"Content-Type": "application/json"},
      );
      print(response.statusCode);

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        print(data);

        // Since we're receiving a single account object, we map it as a single `UserAccount`
        final UserAccount userAccount = UserAccount.fromJson(data);
        state = AccountState(
          status: AccountStateStatus.success,
          userAccounts: [userAccount],  // Store it in a list since you expect a list
        );
      } else {
        state = AccountState(
          status: AccountStateStatus.error,
          errorMessage: 'Failed to load account data',
        );
      }
    } catch (e) {
      state = AccountState(
        status: AccountStateStatus.error,
        errorMessage: e.toString(),
      );
    }
  }

}

