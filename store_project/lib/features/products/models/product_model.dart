class Product {
  final int id;
  final String documenId;
  final String title;
  final double price;
  final String description;
  final List<String> images;
  final int categoryId;

  Product({
    required this.id,
    required this.documenId,
    required this.title,
    required this.price,
    required this.description,
    required this.images,
    required this.categoryId,
  });

  factory Product.fromJson(Map<String, dynamic> json) {
    return Product(
      id: json['id'] ?? 0,
      documenId: json['documentId'] ?? '',
      title: json['title'] ?? '',
      price: (json['price'] as num?)?.toDouble() ?? 0.0,
      description: json['description'] ?? '',
      images: List<String>.from(json['images'] ?? []),
      categoryId: json['category'] != null ? json['category']['id'] ?? 0 : 0,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'title': title,
      'price': price,
      'description': description,
      'images': images,
      'category': categoryId,
    };
  }
}
