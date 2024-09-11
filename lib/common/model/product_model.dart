class Product {
  final String id;
  final String? productImage;
  final String productName;
  final String productCode;
  final String productDescription;
  final double unitPrice;
  final double salesPrice;
  final String category;
  final String selectedTaxType;
  final String selectedGSTType;
  final int selectedMAXQty;
  final DateTime selectedDate;
  final List<String> attributes;
  final String owner;
  final DateTime createdAt;
  final DateTime updatedAt;

  Product({
    required this.id,
    this.productImage,
    required this.productName,
    required this.productCode,
    required this.productDescription,
    required this.unitPrice,
    required this.salesPrice,
    required this.category,
    required this.selectedTaxType,
    required this.selectedGSTType,
    required this.selectedMAXQty,
    required this.selectedDate,
    required this.attributes,
    required this.owner,
    required this.createdAt,
    required this.updatedAt,

  });

  factory Product.fromJson(Map<String, dynamic> json) {
    return Product(
      id: json['_id'] ?? '',
      productImage: json["productImage"] ?? '',
      productName: json['productName'] ?? '',
      productCode: json['productCode'] ?? '',
      productDescription: json['productDescription'] ?? '',
      unitPrice: double.tryParse(json['unitPrice'].toString()) ?? 0.0,
      salesPrice: double.tryParse(json['salesPrice'].toString()) ?? 0.0,
      category: json['category'] ?? '',
      selectedTaxType: json['selectedTaxType'] ?? '',
      selectedGSTType: json['selectedGSTType'] ?? '',
      selectedMAXQty: int.tryParse(json['selectedMAXQty'].toString()) ?? 0,
      selectedDate: DateTime.parse(json['selectedDate']), // Parse date
      attributes: List<String>.from(json['attributes'] ?? []),
      owner: json['owner'] ?? '',
      createdAt: DateTime.parse(json['createdAt']),
      updatedAt: DateTime.parse(json['updatedAt']),
    );
  }
}
