import 'package:flutter/material.dart';
import 'bussnesspage_registration.dart';

class PageRegistrationForm extends StatefulWidget {
  const PageRegistrationForm({Key? key}) : super(key: key);

  @override
  _PageRegistrationFormState createState() => _PageRegistrationFormState();
}

class _PageRegistrationFormState extends State<PageRegistrationForm> {
  final _formKey = GlobalKey<FormState>();

  // Controllers for text fields
  final TextEditingController _brandNameController = TextEditingController();
  final TextEditingController _organizationNameController = TextEditingController();
  final TextEditingController _addressController = TextEditingController();
  final TextEditingController _areaController = TextEditingController();
  final TextEditingController _cityController = TextEditingController();
  final TextEditingController _pincodeController = TextEditingController();
  final TextEditingController _gstNumberController = TextEditingController();
  final TextEditingController _personNameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();

  // Focus nodes
  final FocusNode _brandNameFocusNode = FocusNode();
  final FocusNode _organizationNameFocusNode = FocusNode();
  final FocusNode _addressFocusNode = FocusNode();
  final FocusNode _areaFocusNode = FocusNode();
  final FocusNode _cityFocusNode = FocusNode();
  final FocusNode _pincodeFocusNode = FocusNode();
  final FocusNode _gstNumberFocusNode = FocusNode();
  final FocusNode _personNameFocusNode = FocusNode();
  final FocusNode _emailFocusNode = FocusNode();

  @override
  void dispose() {
    // Dispose controllers and focus nodes
    _brandNameController.dispose();
    _organizationNameController.dispose();
    _addressController.dispose();
    _areaController.dispose();
    _cityController.dispose();
    _pincodeController.dispose();
    _gstNumberController.dispose();
    _personNameController.dispose();
    _emailController.dispose();

    _brandNameFocusNode.dispose();
    _organizationNameFocusNode.dispose();
    _addressFocusNode.dispose();
    _areaFocusNode.dispose();
    _cityFocusNode.dispose();
    _pincodeFocusNode.dispose();
    _gstNumberFocusNode.dispose();
    _personNameFocusNode.dispose();
    _emailFocusNode.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
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
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                const Text(
                  'Sositee permits legal service provisions to sell products/services on platform. Individuals or company can list their brand on Sositee',
                  style: TextStyle(color: Colors.pinkAccent),
                ),
                const SizedBox(height: 16),
                _buildTextField('Brand Name', _brandNameController, _brandNameFocusNode, _organizationNameFocusNode),
                _buildTextField('Organization Name', _organizationNameController, _organizationNameFocusNode, _addressFocusNode),
                _buildTextField('Address', _addressController, _addressFocusNode, _areaFocusNode),
                _buildTextField('Area', _areaController, _areaFocusNode, _cityFocusNode),
                _buildTextField('City', _cityController, _cityFocusNode, _pincodeFocusNode),
                _buildTextField('Pincode', _pincodeController, _pincodeFocusNode, _gstNumberFocusNode),
                _buildTextField('GST Number', _gstNumberController, _gstNumberFocusNode, _personNameFocusNode),
                _buildTextField('Person Name', _personNameController, _personNameFocusNode, _emailFocusNode),
                _buildTextField('Email Id', _emailController, _emailFocusNode, null),
                const SizedBox(height: 24),
                ElevatedButton(
                  onPressed: () {
                    if (_formKey.currentState!.validate()) {
                      // Pass the text field values to the next screen
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => BusinessPageRegistration(
                            brandName: _brandNameController.text,
                            organizationName: _organizationNameController.text,
                            address: _addressController.text,
                            area: _areaController.text,
                            city: _cityController.text,
                            pincode: _pincodeController.text,
                            gstNumber: _gstNumberController.text,
                            personName: _personNameController.text,
                            email: _emailController.text,
                          ),
                        ),
                      );
                    }
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.purple,
                    padding: const EdgeInsets.symmetric(vertical: 16),
                  ),
                  child: const Text('Continue'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildTextField(String label, TextEditingController controller, FocusNode focusNode, FocusNode? nextFocusNode) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16.0),
      child: TextFormField(
        controller: controller,
        focusNode: focusNode,
        decoration: InputDecoration(
          labelText: label,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8),
          ),
          floatingLabelBehavior: FloatingLabelBehavior.always,
        ),
        textInputAction: nextFocusNode != null ? TextInputAction.next : TextInputAction.done,
        onFieldSubmitted: (value) {
          if (nextFocusNode != null) {
            FocusScope.of(context).requestFocus(nextFocusNode);
          } else {
            FocusScope.of(context).unfocus();
          }
        },
        validator: (value) {
          if (value == null || value.isEmpty) {
            return 'Please enter $label';
          }
          return null;
        },
      ),
    );
  }
}
