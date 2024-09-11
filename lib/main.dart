import 'dart:io' if (dart.library.html) 'dart:html';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'route/app_route.dart';
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  // if (!kIsWeb && (Platform.isAndroid || Platform.isIOS)) {
  //   FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);
  // }

  runApp(const ProviderScope(child: MyApp()));
}


Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  await Firebase.initializeApp();
  debugPrint("Handling a background message: ${message.messageId}");

  // Handle the background message (e.g., show notification)
  // You can also add specific actions here based on the message content
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  final FirebaseMessaging _firebaseMessaging = FirebaseMessaging.instance;

  @override
  void initState() {
    super.initState();
    // _requestPermissions();
    _getToken();
    _setupMessageListeners();
    _handleTokenRefresh();
  }

  // Request permissions for iOS, no need for Android
  // void _requestPermissions() async {
  //   if (!kIsWeb && Platform.isIOS) {
  //     NotificationSettings settings = await _firebaseMessaging.requestPermission(
  //       alert: true,
  //       badge: true,
  //       sound: true,
  //     );
  //
  //     if (settings.authorizationStatus == AuthorizationStatus.authorized) {
  //       debugPrint('User granted permission');
  //     } else if (settings.authorizationStatus == AuthorizationStatus.provisional) {
  //       debugPrint('User granted provisional permission');
  //     } else {
  //       debugPrint('User declined or has not accepted permission');
  //     }
  //   }
  // }

  // Get the FCM token and store it in SharedPreferences
  Future<void> _getToken() async {
    try {
      String? token = await _firebaseMessaging.getToken();
      if (token != null) {
        SharedPreferences prefs = await SharedPreferences.getInstance();
        await prefs.setString('fcm_token', token);
        debugPrint("FCM Token: $token");
      }
    } catch (e) {
      debugPrint("Error fetching FCM token: $e");
    }
  }

  // Handle FCM token refresh
  void _handleTokenRefresh() {
    _firebaseMessaging.onTokenRefresh.listen((newToken) async {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      await prefs.setString('fcm_token', newToken);
      debugPrint("FCM Token refreshed: $newToken");
    }).onError((err) {
      debugPrint("Error refreshing FCM token: $err");
    });
  }

  // Set up listeners for foreground message handling
  void _setupMessageListeners() {
    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      debugPrint('Received a message in the foreground!');
      debugPrint('Message data: ${message.data}');

      if (message.notification != null) {
        debugPrint('Message also contained a notification: ${message.notification}');
        // Optionally show notification or handle the message data here
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      onGenerateRoute: onGenerateRoute,
      initialRoute: '/',
    );
  }
}
