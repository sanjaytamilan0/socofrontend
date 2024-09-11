import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import 'reverpod/add_new_product_notifier.dart';

import 'add_attribute.dart';

class AddProductSEOFiltersPage extends ConsumerStatefulWidget {
  const AddProductSEOFiltersPage({
    super.key,
    this.productImage,
    required this.productName,
    required this.productCode,
    required this.productDescription,
    required this.unitPrice,
    required this.salesPrice,
    this.category,
  });

  final String productName;
  final String productCode;
  final String productDescription;
  final String unitPrice;
  final String salesPrice;
  final String? category;
  final String? productImage;

  @override
  _AddProductSEOFiltersPageState createState() => _AddProductSEOFiltersPageState();
}

class _AddProductSEOFiltersPageState extends ConsumerState<AddProductSEOFiltersPage> {
  final _formKey = GlobalKey<FormState>();

  final _parentCategoryFocusNode = FocusNode();
  final _categoryNameFocusNode = FocusNode();
  final _seoUrlFocusNode = FocusNode();
  final _seoTitleFocusNode = FocusNode();
  final _seoDescriptionFocusNode = FocusNode();
  final _metaTagsFocusNode = FocusNode();
  final _selectAttributeFocusNode = FocusNode();
  final _addAttributeFocusNode = FocusNode();
  final _filterAttributeFocusNode = FocusNode();
  final _taxTypeFocusNode = FocusNode();
  final _gstTypeFocusNode = FocusNode();
  final _maxQtyFocusNode = FocusNode();
  final _weightFocusNode = FocusNode();
  final _availabilityDateFocusNode = FocusNode();

  String? selectedTaxType;
  String? selectedGSTType;
  String? selectedMAXQty;
  DateTime? selectedDate;

  @override
  void dispose() {
    _parentCategoryFocusNode.dispose();
    _categoryNameFocusNode.dispose();
    _seoUrlFocusNode.dispose();
    _seoTitleFocusNode.dispose();
    _seoDescriptionFocusNode.dispose();
    _metaTagsFocusNode.dispose();
    _selectAttributeFocusNode.dispose();
    _addAttributeFocusNode.dispose();
    _filterAttributeFocusNode.dispose();
    _taxTypeFocusNode.dispose();
    _gstTypeFocusNode.dispose();
    _maxQtyFocusNode.dispose();
    _weightFocusNode.dispose();
    _availabilityDateFocusNode.dispose();
    super.dispose();
  }

  void _handleFieldSubmit(FocusNode nextFocusNode) {
    FocusScope.of(context).requestFocus(nextFocusNode);
  }

  @override
  Widget build(BuildContext context) {
    final addProduct = ref.watch(addProductProvider);
    final addProductNotifier = ref.read(addProductProvider);
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => Navigator.of(context).pop(),
        ),
        title: const Text('Add Product'),
        backgroundColor: Colors.pink,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text('SEO & Filters', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                const SizedBox(height: 16),
                _buildTextField('Parent category', _parentCategoryFocusNode, _categoryNameFocusNode, true),
                _buildTextField('Category name', _categoryNameFocusNode, _seoUrlFocusNode),
                _buildTextField('SEO URL', _seoUrlFocusNode, _seoTitleFocusNode, true),
                _buildTextField('SEO Title', _seoTitleFocusNode, _seoDescriptionFocusNode, true),
                _buildTextField('SEO Description', _seoDescriptionFocusNode, _metaTagsFocusNode, true),
                _buildTextField('Meta Tags', _metaTagsFocusNode, _selectAttributeFocusNode, true),
                _buildTextField('Select attribute', _selectAttributeFocusNode, _addAttributeFocusNode),
                _buildTextField('Add attribute', _addAttributeFocusNode, _filterAttributeFocusNode),
                _buildTextField('Filter attribute', _filterAttributeFocusNode, _taxTypeFocusNode),
                _buildDropdown('Select Tax type', ['Option 1', 'Option 2', 'Option 3'], (value) {
                  setState(() {
                    selectedTaxType = value;
                  });
                }, _taxTypeFocusNode),
                _buildDropdown('Select GST type', ['Option A', 'Option B', 'Option C'], (value) {
                  setState(() {
                    selectedGSTType = value;
                  });
                }, _gstTypeFocusNode),
                _buildDropdown('Select MAX quantity', ['1', '5', '10', '20'], (value) {
                  setState(() {
                    selectedMAXQty = value;
                  });
                }, _maxQtyFocusNode),
                _buildDatePicker(),
                _buildTextField('Weight', _maxQtyFocusNode, _availabilityDateFocusNode),
                const SizedBox(height: 16),
                const Text('Related Product', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
                const SizedBox(height: 8),
                _buildRelatedProductChips(),
                const SizedBox(height: 16),
                _buildContinueButton(),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildTextField(String label, FocusNode focusNode, FocusNode nextFocusNode, [bool isRequired = false]) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16),
      child: TextFormField(
        focusNode: focusNode,
        decoration: InputDecoration(
          labelText: label,
          border: const OutlineInputBorder(),
          suffixIcon: isRequired ? const Icon(Icons.star, color: Colors.pink, size: 10) : null,
        ),
        onFieldSubmitted: (_) => _handleFieldSubmit(nextFocusNode),
        validator: isRequired ? (value) {
          if (value == null || value.isEmpty) {
            return 'This field is required';
          }
          return null;
        } : null,
      ),
    );
  }

  Widget _buildDropdown(String label, List<String> items, ValueChanged<String?>? onChanged, FocusNode focusNode) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16),
      child: DropdownButtonFormField<String>(
        focusNode: focusNode,
        decoration: InputDecoration(
          labelText: label,
          border: const OutlineInputBorder(),
        ),
        items: items.map((String value) {
          return DropdownMenuItem<String>(
            value: value,
            child: Text(value),
          );
        }).toList(),
        onChanged: onChanged,
        validator: (value) {
          if (value == null) {
            return 'Please select an option';
          }
          return null;
        },
      ),
    );
  }

  Widget _buildDatePicker() {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16),
      child: TextFormField(
        focusNode: _availabilityDateFocusNode,
        decoration: const InputDecoration(
          labelText: 'Availability Date',
          border: OutlineInputBorder(),
          suffixIcon: Icon(Icons.calendar_today),
        ),
        readOnly: true,
        onTap: () async {
          final DateTime? picked = await showDatePicker(
            context: context,
            initialDate: selectedDate ?? DateTime.now(),
            firstDate: DateTime(2000),
            lastDate: DateTime(2101),
          );
          if (picked != null && picked != selectedDate) {
            setState(() {
              selectedDate = picked;
            });
          }
        },
        controller: TextEditingController(
          text: selectedDate != null ? DateFormat('yyyy-MM-dd').format(selectedDate!) : '',
        ),
        validator: (value) {
          if (selectedDate == null) {
            return 'Please select a date';
          }
          return null;
        },
      ),
    );
  }

  Widget _buildRelatedProductChips() {
    return Wrap(
      spacing: 8.0,
      children: [
        Chip(
          label: const Text('Phone SIM'),
          onDeleted: () {},
          deleteIcon: const Icon(Icons.close, size: 18),
        ),
        Chip(
          label: const Text('Phone SIM'),
          onDeleted: () {},
          deleteIcon: const Icon(Icons.close, size: 18),
        ),
        Chip(
          label: const Text('Phone ID'),
          onDeleted: () {},
          deleteIcon: const Icon(Icons.close, size: 18),
        ),
      ],
    );
  }

  Widget _buildContinueButton() {
    return SizedBox(
      width: double.infinity,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.purple,
          padding: const EdgeInsets.symmetric(vertical: 16),
        ),
        onPressed: () {
          if (_formKey.currentState?.validate() ?? false) {
            // Form is valid, proceed to the next screen
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => AddAttributePage(
                 productImage:widget.productImage,
                  productName: widget.productName,
                  productCode: widget.productCode,
                  productDescription: widget.productDescription,
                  unitPrice: widget.unitPrice,
                  salesPrice: widget.salesPrice,
                  category: widget.category,
                  selectedTaxType: selectedTaxType,
                  selectedGSTType: selectedGSTType,
                  selectedMAXQty: selectedMAXQty,
                  selectedDate: selectedDate,
                ),
              ),
            );
          }
        },
        child: const Text(
          'Continue',
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.w600,
            fontSize: 15,
          ),
        ),
      ),
    );
  }
}
