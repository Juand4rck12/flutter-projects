class Category {
  final int id;
  final String name;
  final String slug;
  final List<String> images;
  final int productId;

  Category({
    required this.id,
    required this.name,
    required this.slug,
    required this.images,
    required this.productId,
  });

  factory Category.fromJson(Map<String, dynamic> json) {
    return Category(
      id: json['id'],
      name: json['name'],
      slug: json['slug'],
      images: List<String>.from(json['images'] ?? []),
      productId: json['products'] != null ? json['products']['id'] : 0,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'slug': slug,
      'images': images,
      'productId': productId,
    };
  }
}
