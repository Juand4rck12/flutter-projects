import 'package:store_project/features/auth/user_model.dart';

class AuthResponse {
  final String jwt;
  final User user;

  AuthResponse({required this.jwt, required this.user});

  factory AuthResponse.fromJson(Map<String, dynamic> json) {
    return AuthResponse(
      jwt: json['jwt'], 
      user: User.fromJson(json['user']),
    );
  }
}

