import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter_application_demo/models/product_model.dart';

class ProductService {
  final String baseUrl = "http://localhost:8080/api/v1/products";

  // GET
  Future<List<ProductModel>> getProducts() async {
    final response = await http.get(Uri.parse(baseUrl));

    if (response.statusCode == 200) {
      final Map<String, dynamic> body = jsonDecode(response.body);

      List<dynamic> data = body['data'];

      return data.map((dynamic item) => ProductModel.fromJson(item)).toList();
    } else {
      throw Exception("Fallo al cargar productos");
    }
  }

  // POST
  Future<void> createProduct(ProductModel product) async {
    final response = await http.post(
      Uri.parse("$baseUrl/add"),
      headers: {"Content-Type": "application/json"},
      body: jsonEncode(product.toJson()),
    );

    if (response.statusCode != 201 && response.statusCode != 200) {
      throw Exception(response.body);
    }
  }

  // PUT
  Future<void> updateProduct(ProductModel product) async {
    final response = await http.put(
      Uri.parse("$baseUrl/edit/${product.productId}"),
      headers: {"Content-Type": "application/json"},
      body: jsonEncode(product.toJson(isUpdate: true)),
    );

    if (response.statusCode != 200) throw Exception(response.body);
  }

  // DELETE
  Future<void> deleteProduct(int id) async {
    final response = await http.delete(Uri.parse("$baseUrl/delete/$id"));
    if (response.statusCode != 200) throw Exception(response.body);
  }
}
