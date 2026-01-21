import 'dart:convert';

import 'package:store_project/core/constants/api_constants.dart';
import 'package:store_project/features/products/models/pagination_data.dart';
import 'package:store_project/features/products/models/product_model.dart';
import 'package:http/http.dart' as http;

class ProductResponse {
  final List<Product> products;
  final PaginationData pagination;

  ProductResponse(this.products, this.pagination);
}

class ProductRepository {
  /// Obtener todos los productos
  Future<List<Product>> getProducts() async {
    final response = await http.get(
      Uri.parse(ApiConstants.products),
      headers: {'Authorization': 'Bearer ${ApiConstants.bearerToken}'},
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
      headers: {'Authorization': 'Bearer ${ApiConstants.bearerToken}'},
    );

    if (response.statusCode == 200) {
      final json = jsonDecode(response.body);
      final List<dynamic> dataList = json['data'];
      final products = dataList.map((item) => Product.fromJson(item)).toList();
      final pagination = PaginationData.fromJson(json['meta']['pagination']);
      return ProductResponse(products, pagination);
    } else {
      throw Exception('Error al cargar productos');
    }
  }

  /// Obtener producto por Id
  Future<Product> getProduct(int id) async {
    final response = await http.get(
      Uri.parse('${ApiConstants.products}/$id'),
      headers: {'Authorization': 'Bearer ${ApiConstants.bearerToken}'},
    );

    if (response.statusCode == 200) {
      // final List<dynamic> data = json.decode(response.body);
      return Product.fromJson(json.decode(response.body));
    } else {
      throw Exception('Error al cargar productos');
    }
  }

  /// Crear producto
  Future<Product> creteProduct(Product product) async {
    final response = await http.post(
      Uri.parse(ApiConstants.products),
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer ${ApiConstants.bearerToken}',
      },
      body: json.encode(product.toJson()),
    );

    if (response.statusCode == 201) {
      return Product.fromJson(json.decode(response.body));
    } else {
      throw Exception('Error al crear el producto');
    }
  }

  /// Actualizar producto
  Future<Product> updateProduct(int id, Product product) async {
    final response = await http.put(
      Uri.parse('${ApiConstants.products}/$id'),
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer ${ApiConstants.bearerToken}',
      },
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
      headers: {'Authorization': 'Bearer ${ApiConstants.bearerToken}'},
    );

    if (response.statusCode != 200) {
      throw Exception('Error al eliminar producto');
    }
  }
}
