import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'dart:convert'; // For encoding data
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

import '../../common/api_list/api_list.dart';
import '../../common/model/product_model.dart';

class CreateProductState {
  final bool isLoading;
  final bool isSuccess;
  final String error;
  final List<Product> products;
  final List category;

  CreateProductState({
    required this.isLoading,
    this.isSuccess = false,
    this.error = '',
    this.products = const [],
    this.category = const []
  });

  CreateProductState copyWith({
    bool? isLoading,
    bool? isSuccess,
    String? error,
    List<Product>? products,
    List? category
  }) {
    return CreateProductState(
      isLoading: isLoading ?? this.isLoading,
      isSuccess: isSuccess ?? this.isSuccess,
      error: error ?? this.error,
      products: products ?? this.products,
      category: category ?? this.category
    );
  }
}


class CreateProductNotifier extends StateNotifier<CreateProductState> {
  CreateProductNotifier() : super(CreateProductState(isLoading: false));


  Future<void> createProduct(
      productImage,
      productName,
      productCode,
      productDescription,
      unitPrice,
      salesPrice,
      category,
      selectedTaxType,
      selectedGSTType,
      selectedMAXQty,
      selectedDate,
      attributes
      ) async {
    state = state.copyWith(isLoading: true);
    SharedPreferences pref = await SharedPreferences.getInstance();
    final userId =  pref.getString('userId');
    try {
      final response = await http.post(
        Uri.parse(Api.createProduct),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({
          "productImage":productImage,
          "productName": productName,
          "productCode": productCode,
          "productDescription": productDescription,
          "unitPrice": unitPrice,
          "salesPrice": salesPrice,
          "category": category,
          "selectedTaxType": selectedTaxType,
          "selectedGSTType": selectedGSTType,
          "selectedMAXQty": selectedMAXQty,
          "selectedDate": selectedDate,
          "attributes": attributes,
          "owner": userId
        }),
      );
      print(response.statusCode);

      if (response.statusCode == 201) {
        state = state.copyWith(isLoading: false, isSuccess: true);
      } else {
        state = state.copyWith(
          isLoading: false,
          error: 'Failed to create product: ${response.reasonPhrase}',
        );
      }
    } catch (e) {
      state = state.copyWith(
        isLoading: false,
        error: 'An error occurred: $e',
      );
    }
  }

  Future<void> getProduct() async {
    state = state.copyWith(isLoading: true);
    SharedPreferences pref = await SharedPreferences.getInstance();
    final userId =  pref.getString('userId');

    try {
      final response = await http.post(
        Uri.parse(Api.getProduct),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({
          "userId": userId
        }),
      );

      print("++++++++  ${response.statusCode}");

      if (response.statusCode == 200) {
        // Assuming the response body has a structure like { "products": [...] }
        Map<String, dynamic> json = jsonDecode(response.body);

        // Access the list of products from the JSON response
        List<Map<String, dynamic>> data = List<Map<String, dynamic>>.from(json['products']);

        print("++++++++  ${data}");

        // Map the JSON response to a list of Product objects
        List<Product> products = data.map((productData) {
          return Product.fromJson(productData);
        }).toList();

        // Update the state with the fetched products
        state = state.copyWith(isLoading: false, products: products);
      } else {
        state = state.copyWith(
          isLoading: false,
          error: 'Failed to fetch products: ${response.reasonPhrase}',
        );
      }
    } catch (e) {
      print(e.toString());
      state = state.copyWith(
        isLoading: false,
        error: 'An error occurred: $e',
      );
    }
  }


}

final createProductProvider =
StateNotifierProvider<CreateProductNotifier, CreateProductState>((ref) {
  return CreateProductNotifier();
});
