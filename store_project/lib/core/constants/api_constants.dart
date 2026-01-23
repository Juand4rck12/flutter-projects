// import 'package:flutter_dotenv/flutter_dotenv.dart';

class ApiConstants {
  static const String baseUrl = "https://store-backend.devjuan.xyz/api";
  static const String products = "$baseUrl/products";
  static const String categories = "$baseUrl/categories";
  static const String auth = "$baseUrl/auth/local";
  // static final String? bearerToken = dotenv.env["BEARER_TOKEN"];
}
