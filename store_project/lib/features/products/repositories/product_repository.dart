import 'dart:convert';

import 'package:store_project/core/constants/api_constants.dart';
import 'package:store_project/features/products/models/pagination_data.dart';
import 'package:store_project/features/products/models/product_model.dart';
import 'package:http/http.dart' as http;
import 'package:store_project/features/services/auth_service.dart';

class ProductResponse {
  final List<Product> products;
  final PaginationData pagination;

  ProductResponse(this.products, this.pagination);
}

class ProductRepository {
  final AuthService _authService = AuthService();

  /// Obtener todos los productos
  Future<List<Product>> getProducts() async {
    final response = await http.get(
      Uri.parse(ApiConstants.products),
      headers: _authService.getAuthHeaders(),
    );

    if (response.statusCode == 200) {
      final Map<String, dynamic> body = json.decode(response.body);
      final List<dynamic> data = body['data'];

      return data.map((item) => Product.fromJson(item)).toList();
    } else {
      throw Exception('Error al cargar productos');
    }
  }

  /// Obtener productos y usar paginación
  Future<ProductResponse> getPaginatedProducts(int page, int pageSize) async {
    final url = Uri.parse(
      '${ApiConstants.products}?pagination[page]=$page&pagination[pageSize]=$pageSize',
    );
    final response = await http.get(
      url,
      headers: _authService.getAuthHeaders(),
    );

    if (response.statusCode == 200) {
      final jsonResponse = jsonDecode(response.body);
      final List<dynamic> dataList = jsonResponse['data'];
      final products = dataList.map((item) => Product.fromJson(item)).toList();
      final pagination = PaginationData.fromJson(
        jsonResponse['meta']['pagination'],
      );
      return ProductResponse(products, pagination);
    } else {
      throw Exception('Error al cargar productos');
    }
  }

  /// Obtener producto por Id
  Future<Product> getProduct(int id) async {
    final response = await http.get(
      Uri.parse('${ApiConstants.products}/$id'),
      headers: _authService.getAuthHeaders(),
    );

    if (response.statusCode == 200) {
      // final List<dynamic> data = json.decode(response.body);
      return Product.fromJson(json.decode(response.body));
    } else {
      throw Exception('Error al cargar productos');
    }
  }

  /// Crear producto
  Future<Product> create(Product product) async {
    final response = await http.post(
      Uri.parse(ApiConstants.products),
      headers: _authService.getAuthHeaders(),
      body: json.encode({"data": product.toJson()}),
    );

    if (response.statusCode == 201 || response.statusCode == 200) {
      final responseData = json.decode(response.body);
      final productData = responseData['data'] ?? responseData;
      return Product.fromJson(productData);
    } else {
      throw Exception('Error al crear el producto: ${response.body}');
    }
  }

  /// Actualizar producto
  Future<Product> updateProduct(int id, Product product) async {
    final response = await http.put(
      Uri.parse('${ApiConstants.products}/$id'),
      headers: _authService.getAuthHeaders(),
      body: json.encode(product.toJson()),
    );

    if (response.statusCode == 200) {
      return Product.fromJson(json.decode(response.body));
    } else {
      throw Exception('Error al actualizar el producto');
    }
  }

  /// Eliminar producto
  Future<void> deleteProduct(int id) async {
    final response = await http.delete(
      Uri.parse('${ApiConstants.products}/$id'),
      headers: _authService.getAuthHeaders(),
    );

    if (response.statusCode != 200) {
      throw Exception('Error al eliminar producto');
    }
  }
}
