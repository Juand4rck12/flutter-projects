import 'package:flutter/material.dart';

class PasswordField extends StatelessWidget {
  final TextEditingController passwordController;
  const PasswordField({super.key, required this.passwordController});

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: passwordController,
      obscureText: true,
      decoration: const InputDecoration(
        labelText: "Contraseña",
        hintText: "Ingrese su contraseña",
      ),
      validator: (value) {
        if (value == null || value.isEmpty) {
          return "Por favor ingrese su contraseña";
        }
        if (value.length < 6) {
          return "Por favor ingrese una contraseña con más de 6 caracteres";
        }
        return null;
      },
    );
  }
}
