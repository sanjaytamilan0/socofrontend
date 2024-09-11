import 'dart:io'; // Use for picking files
import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:image_picker/image_picker.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'bussness_reverpod/create_business_account_notifier.dart';
import 'bussness_reverpod/business_create_image_notifier.dart';

class BusinessPageRegistration extends ConsumerStatefulWidget {
  const BusinessPageRegistration({
    Key? key,
    required this.brandName,
    required this.organizationName,
    required this.address,
    required this.area,
    required this.city,
    required this.pincode,
    required this.gstNumber,
    required this.personName,
    required this.email,
  }) : super(key: key);

  final String brandName;
  final String organizationName;
  final String address;
  final String area;
  final String city;
  final String pincode;
  final String gstNumber;
  final String personName;
  final String email;

  @override
  _BusinessPageRegistrationState createState() => _BusinessPageRegistrationState();
}

class _BusinessPageRegistrationState extends ConsumerState<BusinessPageRegistration> {
  bool _agreeToTerms = false;
  String? _selectedServiceType;
  String? _selectedCategory;
  String? _selectedSubCategory;

  @override
  Widget build(BuildContext context) {
    final registrationState = ref.watch(registrationProvider);
    final createBusinessNotifier = ref.read(registrationProvider.notifier);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Page Registration'),
        backgroundColor: Colors.pinkAccent,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => Navigator.of(context).pop(),
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            _buildDropdownField(
                'Type Of Service', ['Service 1', 'Service 2', 'Service 3'], (
                value) {
              setState(() {
                _selectedServiceType = value;
              });
            }),
            const SizedBox(height: 16),
            _buildDropdownField(
                'Category', ['Category 1', 'Category 2', 'Category 3'], (
                value) {
              setState(() {
                _selectedCategory = value;
              });
            }),
            const SizedBox(height: 16),
            _buildDropdownField('Select Sub categories',
                ['Subcategory 1', 'Subcategory 2', 'Subcategory 3'], (value) {
                  setState(() {
                    _selectedSubCategory = value;
                  });
                }),
            const SizedBox(height: 24),
            const Text('Upload your files', style: TextStyle(fontSize: 16)),
            const SizedBox(height: 16),
            Row(
              children: [
                Expanded(
                  child: _buildUploadBox(
                    context,
                    'Brand Logo',
                    '220*220',
                        () => ref.read(brandLogoImagePickerProvider.notifier).pickImage(ImageSource.gallery),
                    ref.watch(brandLogoImagePickerProvider.select((state) => state.image)),
                    ref.watch(brandLogoImagePickerProvider.select((state) => state.isLoading)),
                    ref.watch(brandLogoImagePickerProvider.select((state) => state.error)),
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: _buildUploadBox(
                    context,
                    'Cover Image',
                    '500*300',
                        () => ref.read(coverImagePickerProvider.notifier).pickImage(ImageSource.gallery),
                    ref.watch(coverImagePickerProvider.select((state) => state.image)),
                    ref.watch(coverImagePickerProvider.select((state) => state.isLoading)),
                    ref.watch(coverImagePickerProvider.select((state) => state.error)),
                  ),
                ),
              ],
            ),

            const SizedBox(height: 24),
            const Text(
              'The information provided in the SoCo Help Center is for general informational purposes only. Products, services, or related graphics contained in the Help Center for any purpose. Any reliance you place on such information is therefore strictly at your own risk.',
              style: TextStyle(fontSize: 12, color: Colors.grey),
            ),
            const SizedBox(height: 16),
            Row(
              children: [
                Checkbox(
                  value: _agreeToTerms,
                  onChanged: (value) {
                    setState(() {
                      _agreeToTerms = value!;
                    });
                  },
                  activeColor: Colors.pinkAccent,
                ),
                const Expanded(
                  child: Text('I agree to all terms and condition'),
                ),
              ],
            ),
            const SizedBox(height: 16),
            if (registrationState.isLoading)
              const Center(child: CircularProgressIndicator())
            else if (registrationState.error != null)
              Text(
                registrationState.error!,
                style: const TextStyle(color: Colors.red),
              ),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: _agreeToTerms ? () async {
                final SharedPreferences prefs = await SharedPreferences.getInstance();
                final String? userId = prefs.getString('userId');

                final data = {
                  "userId": userId,
                  'brandName': widget.brandName,
                  'organizationName': widget.organizationName,
                  'address': widget.address,
                  'area': widget.area,
                  'city': widget.city,
                  'pincode': widget.pincode,
                  'gstNumber': widget.gstNumber,
                  'contactPersonName': widget.personName,
                  'emailId': widget.email,
                  'typeOfService': _selectedServiceType,
                  'category': _selectedCategory,
                  'subCategories': _selectedSubCategory,
                  "brandLogo": "http://example.com/logo.png", // Placeholder
                  "coverImage": "http://example.com/cover.png", // Placeholder
                  "termsAgreed": true
                };

                createBusinessNotifier.registerBusiness(data, context);
              } : null,
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.purple,
                padding: const EdgeInsets.symmetric(vertical: 16),
              ),
              child: const Text('Register'),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildDropdownField(String label, List<String> options,
      ValueChanged<String?> onChanged) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
      decoration: BoxDecoration(
        border: Border.all(color: Colors.grey),
        borderRadius: BorderRadius.circular(4),
      ),
      child: DropdownButtonHideUnderline(
        child: DropdownButton<String>(
          hint: Text(label),
          isExpanded: true,
          value: _getSelectedValue(label),
          items: options.map((option) {
            return DropdownMenuItem<String>(
              value: option,
              child: Text(option),
            );
          }).toList(),
          onChanged: onChanged,
        ),
      ),
    );
  }

  String? _getSelectedValue(String label) {
    switch (label) {
      case 'Type Of Service':
        return _selectedServiceType;
      case 'Category':
        return _selectedCategory;
      case 'Select Sub categories':
        return _selectedSubCategory;
      default:
        return null;
    }
  }


}

Widget _buildUploadBox(
    BuildContext context,
    String title,
    String size,
    VoidCallback onPickImage,
    dynamic image, // Accepts both File and Uint8List
    bool isLoading,
    String? error,
    ) {
  return Container(
    height: 100,
    decoration: BoxDecoration(
      border: Border.all(color: Colors.pinkAccent),
      borderRadius: BorderRadius.circular(8),
    ),
    child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        if (isLoading)
          const CircularProgressIndicator()
        else if (image != null)
          if (image is File) // Check for File type
            Image.file(image, fit: BoxFit.cover)
          else if (image is Uint8List) // Check for Uint8List type
            Image.memory(image, fit: BoxFit.cover)
          else
            const Text('Unsupported image type')
        else
          GestureDetector(
            onTap: onPickImage,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Icon(Icons.file_upload, color: Colors.pinkAccent),
                Text(title, style: const TextStyle(color: Colors.pinkAccent)),
                Text(size, style: const TextStyle(color: Colors.grey, fontSize: 12)),
              ],
            ),
          ),
        if (error != null)
          Text(error, style: const TextStyle(color: Colors.red)),
      ],
    ),
  );
}


