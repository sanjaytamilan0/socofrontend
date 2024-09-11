import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:image_picker/image_picker.dart';
import 'package:permission_handler/permission_handler.dart';

class ImagePickerState {
  final dynamic image;
  final bool isLoading;
  final String? error;

  ImagePickerState({
    this.image,
    this.isLoading = false,
    this.error,
  });

  ImagePickerState copyWith({
    dynamic image,
    bool? isLoading,
    String? error,
  }) {
    return ImagePickerState(
      image: image ?? this.image,
      isLoading: isLoading ?? this.isLoading,
      error: error ?? this.error,
    );
  }
}

class ImagePickerNotifier extends StateNotifier<ImagePickerState> {
  final ImagePicker _picker = ImagePicker();

  ImagePickerNotifier() : super(ImagePickerState());

  Future<bool> _requestPermission() async {
    if (kIsWeb) {
      return true;
    }

    try {
      final status = await Permission.photos.request();

      if (status.isGranted) {
        return true;
      } else if (status.isDenied || status.isPermanentlyDenied) {
        print('Permission denied. Please enable permission to access photos.');
        await openAppSettings();
        return false;
      } else if (status.isRestricted) {
        print('Permission restricted. Unable to request permission.');
        return false;
      }
      return false;
    } catch (e) {
      print('Error while requesting permission: $e');
      return false;
    }
  }

  Future<void> pickImage(ImageSource source) async {
    if (kIsWeb || await _requestPermission()) {
      state = state.copyWith(isLoading: true);

      try {
        if (kIsWeb) {
            final pickedFile = await _picker.pickImage(source: ImageSource.gallery);
            if (pickedFile != null) {
              state = state.copyWith(image: pickedFile, isLoading: false);
            } else {
              state = state.copyWith(error: 'No image selected', isLoading: false);
            }
        } else {
          // For mobile/desktop
          final pickedFile = await _picker.pickImage(source: source);
          if (pickedFile != null) {
            state = state.copyWith(image: pickedFile.path, isLoading: false);
          } else {
            state = state.copyWith(error: 'No image selected', isLoading: false);
          }
        }
      } catch (e) {
        state = state.copyWith(error: 'Error picking image: ${e.toString()}', isLoading: false);
      }
    } else {
      state = state.copyWith(error: 'Permission denied', isLoading: false);
    }
  }
}

final brandLogoImagePickerProvider =
StateNotifierProvider<ImagePickerNotifier, ImagePickerState>((ref) {
  return ImagePickerNotifier();
});

final coverImagePickerProvider =
StateNotifierProvider<ImagePickerNotifier, ImagePickerState>((ref) {
  return ImagePickerNotifier();
});
