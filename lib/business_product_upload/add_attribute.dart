import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../bottom_nav_bar/profile_screen/profile_screen.dart';
import 'reverpod/create_product_api_notifier.dart';

class AddAttributePage extends ConsumerStatefulWidget {
  const AddAttributePage({
    super.key,
    required this.productName,
    required this.productCode,
    required this.productDescription,
    required this.unitPrice,
    required this.salesPrice,
    this.category,
    this.selectedTaxType,
    this.selectedGSTType,
    this.selectedMAXQty,
    this.selectedDate,
    this.productImage
  });

  final String productName;
  final String productCode;
  final String productDescription;
  final String unitPrice;
  final String salesPrice;
  final String? category;
  final String? selectedTaxType;
  final String? selectedGSTType;
  final String? selectedMAXQty;
  final DateTime? selectedDate;
  final String? productImage;

  @override
  _AddAttributePageState createState() => _AddAttributePageState();
}

class _AddAttributePageState extends ConsumerState<AddAttributePage> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _attributeController = TextEditingController();
  final List<String> _selectedCategories = ['Mens Cloth', 'Casuals', 'Apparel'];
  final List<String> _attributes = []; // List to store attributes

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Add Attribute', style: TextStyle(color: Colors.white)),
        backgroundColor: Colors.pink,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () => Navigator.of(context).pop(),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.info_outline),
            onPressed: () {
              // Show info dialog
            },
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildCategoryChips(),
              const SizedBox(height: 16),
              _buildAttributeTextField(),
              const SizedBox(height: 16),
              _buildAttributeList(),
              const SizedBox(height: 16),
              const Spacer(),
              _buildSubmitButton(ref),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildCategoryChips() {
    return Wrap(
      spacing: 8.0,
      runSpacing: 8.0,
      children: _selectedCategories.map((category) {
        return Chip(
          label: Text(category),
          onDeleted: () {
            setState(() {
              _selectedCategories.remove(category);
            });
          },
          deleteIcon: const Icon(Icons.close, size: 18),
          backgroundColor: Colors.pink[100],
          labelStyle: TextStyle(color: Colors.pink[800]),
        );
      }).toList(),
    );
  }

  Widget _buildAttributeTextField() {
    return TextFormField(
      controller: _attributeController,
      decoration: InputDecoration(
        suffixIcon: IconButton(
          onPressed: () {
            setState(() {
              _attributes.add(_attributeController.text);
              _attributeController.clear();
            });
          },
          icon: const Icon(Icons.add),
        ),
        hintText: 'Enter attribute name',
        border: const OutlineInputBorder(),
        filled: true,
        fillColor: Colors.grey[200],
      ),
      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'Please enter an attribute name';
        }
        return null;
      },
    );
  }

  Widget _buildAttributeList() {
    return Wrap(
      spacing: 8.0,
      runSpacing: 8.0,
      children: _attributes.map((attribute) {
        return Chip(
          label: Text(attribute),
          onDeleted: () {
            setState(() {
              _attributes.remove(attribute);
            });
          },
          deleteIcon: const Icon(Icons.remove_circle_outline, size: 18),
          backgroundColor: Colors.blueGrey[100],
          labelStyle: TextStyle(color: Colors.blueGrey[800]),
        );
      }).toList(),
    );
  }

  Widget _buildSubmitButton(WidgetRef ref) {
     final createProductNotifier = ref.watch(createProductProvider);
    return SizedBox(
      width: double.infinity,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.purple,
          padding: const EdgeInsets.symmetric(vertical: 16),
        ),
        onPressed: () {
          if (_formKey.currentState?.validate() ?? false) {
            ref.read(createProductProvider.notifier).createProduct(
              widget.productImage,
              widget.productName,
               widget.productCode,
            widget.productDescription,
             widget.unitPrice,
              widget.salesPrice,
             widget.category,
             widget.selectedTaxType,
              widget.selectedGSTType,
             widget.selectedMAXQty,
            widget.selectedDate?.toIso8601String() ,
              _attributes,
             ).then((_) {
              final state = ref.read(createProductProvider);
              if (state.error.isNotEmpty) {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text('Error: ${state.error}'),
                    backgroundColor: Colors.red,
                  ),
                );
              } else if (state.isSuccess) {
                Navigator.push(context, MaterialPageRoute(builder: (context)=> ProfileScreen()));
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text('Product created successfully!'),
                    backgroundColor: Colors.green,
                  ),
                );

              }
            });
          }
        },
        child: createProductNotifier.isLoading
          ? const CircularProgressIndicator()
          : const Text('Submit', style: TextStyle(color: Colors.white)),
      ),
    );
  }

  @override
  void dispose() {
    _attributeController.dispose();
    super.dispose();
  }
}
