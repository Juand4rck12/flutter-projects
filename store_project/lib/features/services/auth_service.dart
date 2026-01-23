import 'package:store_project/features/auth/user_model.dart';

class AuthService {
  // Singleton pattern
  static final AuthService _instance = AuthService._internal();
  factory AuthService() => _instance;
  AuthService._internal();

  // Variables globales del servicio
  String? _token;
  User? _currentUser;
  bool _isAuthenticated = false;

  // Getters publicos
  String? get token => _token;
  User? get currentUser => _currentUser;
  bool get isAuthenticated => _isAuthenticated;

  // Setters para actualizar el estado
  void setAuthData(String token, User user) {
    _token = token;
    _currentUser = user;
    _isAuthenticated = true;
  }

  void clearAuthData() {
    _token = null;
    _currentUser = null;
    _isAuthenticated = false;
  }

  // Metodo para obtener headers con el token
  Map<String, String> getAuthHeaders() {
    return {
      'Content-Type': 'application/json',
      if (_token != null) 'Authorization': 'Bearer $_token',
    };
  }
}
