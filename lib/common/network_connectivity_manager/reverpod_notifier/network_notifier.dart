import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

// ConnectivityService class to manage connectivity status
class ConnectivityService {
  final Connectivity _connectivity = Connectivity();

  Stream<ConnectivityResult> get connectivityStream =>
      _connectivity.onConnectivityChanged.map((results) => results.first); // Fix 1

  Future<ConnectivityResult> checkConnectivity() async {
    final results = await _connectivity.checkConnectivity();
    return results.first;
  }
}

// Provider to expose the ConnectivityService
final connectivityServiceProvider = Provider<ConnectivityService>((ref) {
  return ConnectivityService();
});

// ConnectivityNotifier to manage and update connectivity status
class ConnectivityNotifier extends StateNotifier<ConnectivityResult> {
  final ConnectivityService connectivityService;

  ConnectivityNotifier(this.connectivityService) : super(ConnectivityResult.none) {
    _init();
  }

  void _init() async {
    // Check initial connectivity status
    state = await connectivityService.checkConnectivity();

    // Listen to connectivity changes and update state
    connectivityService.connectivityStream.listen((result) {
      state = result;
    });
  }
}

// Provider to expose ConnectivityNotifier
final connectivityNotifierProvider =
StateNotifierProvider<ConnectivityNotifier, ConnectivityResult>((ref) {
  return ConnectivityNotifier(ref.read(connectivityServiceProvider));
});