import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter_application_demo/models/sale_model.dart';

class SaleService {
  final String baseUrl = "http://localhost:8080/api/v1/sales";

  // GET
  Future<List<SaleModel>> getSales() async {
    final response = await http.get(Uri.parse(baseUrl));

    if (response.statusCode == 200) {
      final Map<String, dynamic> body = jsonDecode(response.body);

      List<dynamic> data = body['data'];

      return data.map((dynamic item) => SaleModel.fromJson(item)).toList();
    } else {
      throw Exception("Fallo al cargar ventas");
    }
  }

  // POST
  Future<void> createSale(SaleModel sale) async {
    final response = await http.post(
      Uri.parse("$baseUrl/add"),
      headers: {"Content-Type": "application/json"},
      body: jsonEncode(sale.toJson()),
    );

    if (response.statusCode != 201 && response.statusCode != 200) {
      throw Exception(response.body);
    }
  }

  // PUT
  Future<void> updateSale(SaleModel sale) async {
    final response = await http.put(
      Uri.parse("$baseUrl/edit/${sale.saleId}"),
      headers: {"Content-Type": "application/json"},
      body: jsonEncode(sale.toJson(isUpdate: true)),
    );

    if (response.statusCode != 200) throw Exception(response.body);
  }

  // DELETE
  Future<void> deleteSale(int id) async {
    final response = await http.delete(Uri.parse("$baseUrl/delete/$id"));
    if (response.statusCode != 200) throw Exception(response.body);
  }
}
