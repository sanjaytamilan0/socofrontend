import 'package:flutter_riverpod/flutter_riverpod.dart';

class ProductUploadState {
  final bool isLoading;
  final String? error;
  final bool listToggleButton;

  ProductUploadState({this.isLoading = false, this.error, required this.listToggleButton});

  // Add a copyWith method to easily update individual fields while keeping others the same
  ProductUploadState copyWith({
    bool? isLoading,
    String? error,
    bool? listToggleButton,
  }) {
    return ProductUploadState(
      isLoading: isLoading ?? this.isLoading,
      error: error ?? this.error,
      listToggleButton: listToggleButton ?? this.listToggleButton,
    );
  }
}

class ProductUploadNotifier extends StateNotifier<ProductUploadState> {
  ProductUploadNotifier() : super(ProductUploadState(listToggleButton: false));

  // Toggle the state of listToggleButton
  void toggleListButton() {
    state = state.copyWith(listToggleButton: !state.listToggleButton);
  }
}

final productUploadProvider = StateNotifierProvider<ProductUploadNotifier, ProductUploadState>((ref) {
  return ProductUploadNotifier();
});
