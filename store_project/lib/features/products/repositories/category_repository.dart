import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:store_project/core/constants/api_constants.dart';
import 'package:store_project/features/products/models/category_model.dart';
import 'package:store_project/features/products/repositories/auth_repository.dart';

class CategoryRepository {
  final AuthRepository _authRepository = AuthRepository();

  /// Obtener todas las categorias
  Future<List<Category>> getCategories() async {
    final token = await _authRepository.getToken();

    final response = await http.get(
      Uri.parse(ApiConstants.categories),
      headers: {
        'Authorization': 'Bearer $token',
        'Content-Type': 'application/json',
      },
    );

    if (response.statusCode == 200) {
      final Map<String, dynamic> body = json.decode(response.body);
      final List<dynamic> data = body['data'];

      return data.map((item) => Category.fromJson(item)).toList();
    } else {
      throw Exception("Error al cargar las categorias");
    }
  }

  /// Obtener categoría por Id
  Future<Category> getCategory(int id) async {
    final token = await _authRepository.getToken();

    final response = await http.get(
      Uri.parse('${ApiConstants.categories}/$id'),
      headers: {
        'Authorization': 'Bearer $token',
        'Content-Type': 'application/json',
      },
    );

    if (response.statusCode == 200) {
      final Map<String, dynamic> body = json.decode(response.body);
      return Category.fromJson(body['data']);
    } else {
      throw Exception('Error al cargar la categoría');
    }
  }

  /// Crear categoría
  Future<Category> createCategory(Category category) async {
    final token = await _authRepository.getToken();

    final response = await http.post(
      Uri.parse(ApiConstants.categories),
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $token',
      },
      body: json.encode({'data': category.toJson()}),
    );

    if (response.statusCode == 201 || response.statusCode == 200) {
      final Map<String, dynamic> body = json.decode(response.body);
      return Category.fromJson(body['data']);
    } else {
      throw Exception('Error al crear la categoría');
    }
  }

  /// Actualizar categoría
  Future<Category> updateCategory(int id, Category category) async {
    final response = await http.put(
      Uri.parse('${ApiConstants.categories}/$id'),
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer ${ApiConstants.bearerToken}',
      },
      body: json.encode({'data': category.toJson()}),
    );

    if (response.statusCode == 200) {
      final Map<String, dynamic> body = json.decode(response.body);
      return Category.fromJson(body['data']);
    } else {
      throw Exception('Error al actualizar la categoría');
    }
  }

  /// Eliminar categoría
  Future<void> deleteCategory(int id) async {
    final response = await http.delete(
      Uri.parse('${ApiConstants.categories}/$id'),
      headers: {'Authorization': 'Bearer ${ApiConstants.bearerToken}'},
    );

    if (response.statusCode != 200) {
      throw Exception('Error al eliminar categoría');
    }
  }
}
