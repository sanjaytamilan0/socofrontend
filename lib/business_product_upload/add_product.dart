import 'dart:io' as io;
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'reverpod/add_new_product_notifier.dart';
import '../common/colors.dart';
import 'add_product_details.dart';

class AddProductPage extends ConsumerStatefulWidget {
  @override
  _AddProductPageState createState() => _AddProductPageState();
}

class _AddProductPageState extends ConsumerState<AddProductPage> {
  final _formKey = GlobalKey<FormState>();
  String? selectedCategory;
  List<String> categories = ['Apparel', 'Mini-Cutlet', 'Cosmetics'];

  final TextEditingController _productNameController = TextEditingController();
  final TextEditingController _productCodeController = TextEditingController();
  final TextEditingController _productDescriptionController = TextEditingController();
  final TextEditingController _unitPriceController = TextEditingController();
  final TextEditingController _salesPriceController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final addProduct = ref.watch(addProductProvider);
    final addProductNotifier = ref.read(addProductProvider.notifier);

    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () => Navigator.of(context).pop(),
        ),
        title: const Text('Add Product', style: TextStyle(color: Colors.white)),
        backgroundColor: AppColors.textFieldColor,
        actions: [
          IconButton(
            icon: const Icon(Icons.shopping_cart, color: Colors.white),
            onPressed: () {},
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text('General:', style: TextStyle(
                fontWeight: FontWeight.w600,
                fontSize: 15,
                color: AppColors.textFieldColor,
              )),
              const SizedBox(height: 8),
              _buildMainImagePlaceholder(ref),
              const SizedBox(height: 8),
              _buildSmallImagePlaceholders(),
              const SizedBox(height: 16),
              _buildCategoryDropdown(),
              const SizedBox(height: 8),
              _buildCategoryChips(),
              const SizedBox(height: 16),
              _buildTextField('Product Name', controller: _productNameController, isRequired: true),
              const SizedBox(height: 8),
              _buildTextField('Product Code', controller: _productCodeController, isRequired: true),
              const SizedBox(height: 8),
              _buildTextField('Product Description', controller: _productDescriptionController, maxLines: 3),
              const SizedBox(height: 8),
              _buildTextField('Unit Price', controller: _unitPriceController),
              const SizedBox(height: 8),
              _buildTextField('Select Sales Price', controller: _salesPriceController, isRequired: true),
              const SizedBox(height: 16),
              _buildContinueButton(ref),
            ],
          ),
        ),
      ),
    );
  }


  Widget _buildMainImagePlaceholder(WidgetRef ref) {
    final addProductState = ref.watch(addProductProvider);
    final addProductNotifier = ref.read(addProductProvider.notifier);
    final pickedImageFile = addProductNotifier.pickedImageFile;

    return InkWell(
      onTap: () {
        addProductNotifier.loadImage();
      },
      child: Container(
        height: 150,
        decoration: BoxDecoration(
          border: Border.all(color: Colors.grey),
          borderRadius: BorderRadius.circular(8),
        ),
        child: Center(
          child: addProductState == AddProductImageState.loading
              ? const CircularProgressIndicator()
              : addProductState == AddProductImageState.error
              ? Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(Icons.error, color: Colors.red, size: 40),
              const Text('Failed to load image', style: TextStyle(color: Colors.red)),
              const SizedBox(height: 10),
              ElevatedButton(
                onPressed: () {
                  addProductNotifier.loadImage();
                },
                child: const Text('Retry'),
              ),
            ],
          )
              : addProductState == AddProductImageState.success && pickedImageFile != null
              ? kIsWeb
              ? Image.network(
            pickedImageFile.path, // Ensure you provide a URL or data appropriate for web.
            height: 150,
            width: 150,
            fit: BoxFit.cover,
          )
              : Image.file(
            io.File(pickedImageFile.path), // For mobile platforms
            height: 150,
            width: 150,
            fit: BoxFit.cover,
          )
              : const Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(Icons.add_photo_alternate, color: Colors.pink, size: 40),
              Text('+ Add Image', style: TextStyle(color: Colors.pink)),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildSmallImagePlaceholders() {
    return Row(
      children: List.generate(3, (index) {
        return Expanded(
          child: Container(
            height: 80,
            margin: EdgeInsets.only(right: index < 2 ? 8 : 0),
            decoration: BoxDecoration(
              border: Border.all(color: Colors.grey),
              borderRadius: BorderRadius.circular(8),
            ),
            child: const Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.add_photo_alternate, color: Colors.pink, size: 24),
                  Text('+ Add Image', style: TextStyle(color: Colors.pink, fontSize: 12)),
                ],
              ),
            ),
          ),
        );
      }),
    );
  }

  Widget _buildCategoryDropdown() {
    return DropdownButtonFormField<String>(
      decoration: const InputDecoration(
        labelText: 'Special Categories',
        border: OutlineInputBorder(),
      ),
      value: selectedCategory,
      onChanged: (String? newValue) {
        setState(() {
          selectedCategory = newValue;
        });
      },
      items: categories.map<DropdownMenuItem<String>>((String value) {
        return DropdownMenuItem<String>(
          value: value,
          child: Text(value),
        );
      }).toList(),
    );
  }

  Widget _buildCategoryChips() {
    return Wrap(
      spacing: 8.0,
      children: categories.map((category) {
        return Chip(
          label: Text(category),
          backgroundColor: Colors.pink[100],
          labelStyle: const TextStyle(color: Colors.pink),
        );
      }).toList(),
    );
  }

  Widget _buildTextField(String label, {bool isRequired = false, int maxLines = 1, required TextEditingController controller}) {
    return TextFormField(
      controller: controller,
      maxLines: maxLines,
      decoration: InputDecoration(
        labelText: label,
        border: const OutlineInputBorder(),
        suffixIcon: isRequired ? const Icon(Icons.star, color: Colors.pink, size: 10) : null,
      ),
      validator: isRequired ? (value) {
        if (value == null || value.isEmpty) {
          return 'This field is required';
        }
        return null;
      } : null,
    );
  }

  Widget _buildContinueButton(WidgetRef ref) {
    final addProductNotifier = ref.read(addProductProvider.notifier);
    return SizedBox(
      width: double.infinity,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.purple,
          padding: const EdgeInsets.symmetric(vertical: 16),
        ),
        onPressed: () {
          if (_formKey.currentState!.validate()) {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => AddProductSEOFiltersPage(
                 productImage : addProductNotifier.pickedImageFile?.path.toString(),
                  productName: _productNameController.text,
                  productCode: _productCodeController.text,
                  productDescription: _productDescriptionController.text,
                  unitPrice: _unitPriceController.text,
                  salesPrice: _salesPriceController.text,
                  category: selectedCategory,
                ),
              ),
            );
          }
        },
        child: const Text(
          'Continue',
          style: TextStyle(
            color: Colors.white,
            fontSize: 15,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
    );
  }
}
