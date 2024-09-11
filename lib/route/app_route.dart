import 'package:flutter/material.dart';
import '../authentication_screens/otp_screen/otp_screen.dart';
import '../authentication_screens/verification_screen/verification_screen.dart';

import '../authentication_screens/register_screen/register_screen.dart';
import '../bottom_nav_bar/bottom_nav/bottom_nav.dart';

import '../bottom_nav_bar/profile_screen/Settings_screens/settings_screens.dart';
import '../common/network_connectivity_manager/network_screen/network_screen.dart';

Route<dynamic>? onGenerateRoute(RouteSettings settings) {
  switch (settings.name) {
    case '/':
      return MaterialPageRoute(builder: (_) => ConnectivityScreen());
    case '/login':
      return MaterialPageRoute(builder: (_) => VerificationScreen());
    case '/register':
      return MaterialPageRoute(builder: (_) => RegisterScreen());
    case '/bottomNavBar':
      return MaterialPageRoute(builder: (_) => const AdaptiveNavBar());
    case '/settings':
      return MaterialPageRoute(builder: (_) => PrivacySettingsScreen());
    default:
      return MaterialPageRoute(
          builder: (_) => const Scaffold(
                body: Center(child: Text('Page Not Found')),
              ));
  }
}
