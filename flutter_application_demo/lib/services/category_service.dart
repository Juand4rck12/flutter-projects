import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter_application_demo/models/category_model.dart';

class CategoryService {
  final String baseUrl = "http://localhost:8080/api/v1/categories";

  // GET
  Future<List<CategoryModel>> getCategories() async {
    final response = await http.get(Uri.parse(baseUrl));

    if (response.statusCode == 200) {
      final Map<String, dynamic> body = jsonDecode(response.body);

      List<dynamic> data = body['data'];

      return data.map((dynamic item) => CategoryModel.fromJson(item)).toList();
    } else {
      throw Exception("Fallo al cargar categorias");
    }
  }

  // POST
  Future<void> createCategory(CategoryModel category) async {
    final response = await http.post(
      Uri.parse("$baseUrl/add"),
      headers: {"Content-Type": "application/json"},
      body: jsonEncode(category.toJson()),
    );

    if (response.statusCode != 201 && response.statusCode != 200) {
      throw Exception(response.body);
    }
  }

  // PUT
  Future<void> updateCategory(CategoryModel category) async {
    final response = await http.put(
      Uri.parse("$baseUrl/edit/${category.categoryId}"),
      headers: {"Content-Type": "application/json"},
      body: jsonEncode(category.toJson(isUpdate: true)),
    );

    if (response.statusCode != 200) throw Exception(response.body);
  }

  // DELETE
  Future<void> deleteCategory(int id) async {
    final response = await http.delete(Uri.parse("$baseUrl/delete/$id"));
    if (response.statusCode != 200) throw Exception(response.body);
  }
}
