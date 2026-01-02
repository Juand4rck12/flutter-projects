import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter_application_demo/models/supplier_model.dart';

class SupplierService {
  final String baseUrl = "http://localhost:8080/api/v1/suppliers";

  // GET
  Future<List<SupplierModel>> getSuppliers() async {
    final response = await http.get(Uri.parse(baseUrl));

    if (response.statusCode == 200) {
      final Map<String, dynamic> body = jsonDecode(response.body);

      List<dynamic> data = body['data'];

      return data.map((dynamic item) => SupplierModel.fromJson(item)).toList();
    } else {
      throw Exception("Fallo al cargar proveedores");
    }
  }

  // POST
  Future<void> createSupplier(SupplierModel supplier) async {
    final response = await http.post(
      Uri.parse("$baseUrl/add"),
      headers: {"Content-Type": "application/json"},
      body: jsonEncode(supplier.toJson()),
    );

    if (response.statusCode != 201 && response.statusCode != 200) {
      throw Exception(response.body);
    }
  }

  // PUT
  Future<void> updateSupplier(SupplierModel supplier) async {
    final response = await http.put(
      Uri.parse("$baseUrl/edit/${supplier.supplierId}"),
      headers: {"Content-Type": "application/json"},
      body: jsonEncode(supplier.toJson(isUpdate: true)),
    );

    if (response.statusCode != 200) throw Exception(response.body);
  }

  // DELETE
  Future<void> deleteSupplier(int id) async {
    final response = await http.delete(Uri.parse("$baseUrl/delete/$id"));
    if (response.statusCode != 200) throw Exception(response.body);
  }
}
