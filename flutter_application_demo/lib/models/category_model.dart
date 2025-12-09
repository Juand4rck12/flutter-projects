class CategoryModel {
  final int? categoryId;
  final String name;
  final String description;

  CategoryModel({
    this.categoryId,
    required this.name,
    required this.description,
  });

  factory CategoryModel.fromJson(Map<String, dynamic> json) {
    return CategoryModel(
      categoryId: json["id"], // Los valores en JSON son los que vendrian de la API
      name: json["name"],
      description: json["description"],
    );
  }

  Map<String, dynamic> toJson({bool isUpdate = false}) {
    if (isUpdate) {
      return {
        'category_id': categoryId,
        'name': name,
        'description': description,
      };
    } else {
      return {'name': name, 'description': description};
    }
  }
}
