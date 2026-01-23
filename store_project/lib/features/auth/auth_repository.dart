import 'dart:convert';

import 'package:store_project/core/constants/api_constants.dart';
import 'package:store_project/features/auth/auth_response.dart';
import 'package:store_project/features/auth/user_model.dart';
import 'package:store_project/features/services/auth_service.dart';
import 'package:http/http.dart' as http;

class AuthRepository {
  final AuthService _authService = AuthService();

  /// Logueo con usuario/email y contraseña, y almacenar jwt token
  Future<AuthResponse> login(String identifier, String password) async {
    try {
      final response = await http.post(
        Uri.parse(ApiConstants.auth),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({'identifier': identifier, 'password': password}),
      );

      if (response.statusCode == 200) {
        final authResponse = AuthResponse.fromJson(jsonDecode(response.body));
        // Guardar en el servicio singleton
        _authService.setAuthData(authResponse.jwt, authResponse.user);

        return authResponse;
      } else {
        final errorBody = jsonDecode(response.body);
        throw Exception(errorBody['error']['message'] ?? 'Error en registro');
      }
    } catch (e) {
      throw Exception("Error de conexión");
    }
  }

  /// Registrar nuevo usuario
  Future<AuthResponse> register(
    String username,
    String email,
    String password,
  ) async {
    try {
      final response = await http.post(
        Uri.parse(ApiConstants.auth),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({
          'username': username,
          'email': email,
          'password': password,
        }),
      );

      if (response.statusCode == 200) {
        final authResponse = AuthResponse.fromJson(jsonDecode(response.body));
        // Guardar en el servicio singleton
        _authService.setAuthData(authResponse.jwt, authResponse.user);

        return authResponse;
      } else {
        final errorBody = jsonDecode(response.body);
        throw Exception(errorBody['error']['message'] ?? 'Error en registro');
      }
    } catch (e) {
      throw Exception("Error de conexión");
    }
  }

  /// Cerrar sesión
  Future<void> logout() async {
    _authService.clearAuthData(); // Limpiar datos del servicio
  }

  /// Verificar si el usuario esta autenticado
  bool isAuthenticated() {
    return _authService.isAuthenticated;
  }

  /// Obtener el usuario actual
  User? getCurrentUser() {
    return _authService.currentUser;
  }
}
