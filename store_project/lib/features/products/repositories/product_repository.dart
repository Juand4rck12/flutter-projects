import 'dart:convert';

import 'package:store_project/core/constants/api_constants.dart';
import 'package:store_project/features/products/models/product_model.dart';
import 'package:http/http.dart' as http;

class ProductRepository {
  /// Obtener todos los productos
  Future<List<Product>> getProducts() async {
    final response = await http.get(Uri.parse(ApiConstants.products));

    if (response.statusCode == 200) {
      final List<dynamic> data = json.decode(response.body);
      return data.map((json) => Product.fromJson(json)).toList();
    } else {
      throw Exception("Error al cargar productos");
    }
  }

  /// Obtener producto por Id
  Future<Product> getProduct(int id) async {
    final response = await http.get(Uri.parse("${ApiConstants.products}/$id"));

    if (response.statusCode == 200) {
      // final List<dynamic> data = json.decode(response.body);
      return Product.fromJson(json.decode(response.body));
    } else {
      throw Exception("Error al cargar productos");
    }
  }

  /// Crear producto
  Future<Product> creteProduct(Product product) async {
    final response = await http.post(
      Uri.parse(ApiConstants.products),
      headers: {"Content-Type": "application/json"},
      body: json.encode(product.toJson()),
    );

    if (response.statusCode == 201) {
      return Product.fromJson(json.decode(response.body));
    } else {
      throw Exception("Error al crear el producto");
    }
  }

  /// Actualizar producto
  Future<Product> updateProduct(int id, Product product) async {
    final response = await http.put(
      Uri.parse("${ApiConstants.products}/$id"),
      headers: {"Content-Type": "application/json"},
      body: json.encode(product.toJson()),
    );

    if (response.statusCode == 200) {
      return Product.fromJson(json.decode(response.body));
    } else {
      throw Exception("Error al actualizar el producto");
    }
  }

  /// Eliminar producto
  Future<void> deleteProduct(int id) async {
    final response = await http.delete(
      Uri.parse("${ApiConstants.products}/$id"),
    );

    if (response.statusCode != 200) throw Exception("Error al eliminar producto");
  }
}
