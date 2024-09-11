import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:shared_preferences/shared_preferences.dart'; // Import for SharedPreferences
import '../../../authentication_screens/register_screen/register_screen.dart';
import '../reverpod_notifier/network_notifier.dart';

import '../../../bottom_nav_bar/bottom_nav/bottom_nav.dart';

class ConnectivityScreen extends ConsumerWidget {
  const ConnectivityScreen({super.key});

  Future<String?> _getJwtToken() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString('jwtToken'); // Replace 'jwtToken' with your actual key
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final connectivityResult = ref.watch(connectivityNotifierProvider);

    return FutureBuilder<String?>(
      future: _getJwtToken(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Scaffold(
            body: Center(child: CircularProgressIndicator()), // Show a loading spinner while waiting for the token
          );
        } else if (snapshot.hasError) {
          return const Scaffold(
            body: Center(child: Text('Error retrieving token')),
          );
        } else {
          final jwtToken = snapshot.data;

          return Scaffold(
            body: Center(
              child: connectivityResult == ConnectivityResult.none
                  ? const Text('No internet connection', style: TextStyle(color: Colors.red))
                  : (jwtToken == null || jwtToken.isEmpty)
                  ? RegisterScreen() // Show RegisterScreen if JWT token is empty
                  : const AdaptiveNavBar(), // Replace with your actual screen or widget
            ),
          );
        }
      },
    );
  }
}
