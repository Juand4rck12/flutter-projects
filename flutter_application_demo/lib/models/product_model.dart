class ProductModel {
  final int? productId;
  final String name;
  final String? description;
  final double price;
  final int stockQuantity;
  final int? categoryId;
  final int? supplierId;
  final String? createdAt;
  // Campos adicionales para mostrar nombres en la UI
  final String? categoryName;
  final String? supplierName;

  ProductModel({
    this.productId,
    required this.name,
    this.description,
    required this.price,
    this.stockQuantity = 0,
    this.categoryId,
    this.supplierId,
    this.createdAt,
    this.categoryName,
    this.supplierName,
  });

  factory ProductModel.fromJson(Map<String, dynamic> json) {
    return ProductModel(
      productId: json["id"],
      name: json["name"],
      description: json["description"],
      price: (json["price"] as num).toDouble(),
      stockQuantity: json["stockQuantity"] ?? 0,
      categoryId: json["category"]["id"],
      supplierId: json["supplier"]["id"],
      createdAt: json["createdAt"],
      categoryName: json["category"]["name"],
      supplierName: json["supplier"]["name"],
    );
  }

  Map<String, dynamic> toJson({bool isUpdate = false}) {
    if (isUpdate) {
      return {
        'product': productId,
        'name': name,
        'description': description,
        'price': price,
        'stockQuantity': stockQuantity,
        'category': {'id': categoryId},
        'supplier': {'id': supplierId},
      };
    } else {
      return {
        'name': name,
        'description': description,
        'price': price,
        'stockQuantity': stockQuantity,
        'category': {'id': categoryId},
        'supplier': {'id': supplierId},
      };
    }
  }
}
