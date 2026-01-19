import 'package:flutter/material.dart';

class EmailField extends StatelessWidget {
  final TextEditingController emailController;

  const EmailField({super.key, required this.emailController});

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: emailController,
      keyboardType: TextInputType.emailAddress,
      decoration: const InputDecoration(
        labelText: "email",
        hintText: "Ingrese su correo electronico",
      ),
      validator: (value) {
        if (value == null || value.isEmpty) {
          return "Por favor ingrese su correo electronico";
        }
        if (!RegExp(r'^[^@]+@[^@]+\.[^@]+$').hasMatch(value)) {
          return "Por favor ingrese un correo valido";
        }
        return null;
      },
    );
  }
}
