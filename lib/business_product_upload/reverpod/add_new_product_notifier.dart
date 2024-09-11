import 'dart:io';
import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:image_picker/image_picker.dart';
import 'package:permission_handler/permission_handler.dart';

enum AddProductImageState { loading, success, error, idle }

class AddProductNotifier extends StateNotifier<AddProductImageState> {
  AddProductNotifier() : super(AddProductImageState.idle);

  final ImagePicker _picker = ImagePicker();
  File? _pickedImageFile;

  File? get pickedImageFile => _pickedImageFile;

  Future<void> loadImage() async {
    state = AddProductImageState.loading;

    if (kIsWeb) {
      // Web-specific code
      try {
        final pickedFile = await _picker.pickImage(source: ImageSource.gallery);
        if (pickedFile != null) {
          _pickedImageFile = File(pickedFile.path);
          state = AddProductImageState.success;
        } else {
          state = AddProductImageState.error;
        }
      } catch (e) {
        print('Error on Web: $e');
        state = AddProductImageState.error;
      }
    } else {
      // Request permissions
      final cameraPermission = await Permission.camera.request();
      final storagePermission = await Permission.storage.request();

      // Check if permissions are granted
      if (!cameraPermission.isGranted || !storagePermission.isGranted) {
        state = AddProductImageState.error;
        return;
      }

      try {
        // Pick image from gallery or camera based on your logic
        final pickedFile = await _picker.pickImage(source: ImageSource.camera);
        if (pickedFile != null) {
          print('Picked file path: ${pickedFile.path}');
          _pickedImageFile = File(pickedFile.path);
          state = AddProductImageState.success;
        } else {
          state = AddProductImageState.error;
        }
      } catch (e) {
        print('Error picking image on Android: $e');
        state = AddProductImageState.error;
      }
    }
  }


}

final addProductProvider = StateNotifierProvider<AddProductNotifier, AddProductImageState>((ref) {
  return AddProductNotifier();
});
