import 'package:flutter_dotenv/flutter_dotenv.dart';

class ApiConstants {
  static const String baseUrl = "https://api.escuelajs.co/api/v1";
  static const String products = "$baseUrl/products";
  static final String? bearerToken = dotenv.env["BEARER_TOKEN"];
}
