import 'package:flutter/material.dart';

class NameField extends StatelessWidget {
  final TextEditingController nameController;

  const NameField({super.key, required this.nameController});

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: nameController,
      decoration: const InputDecoration(
        labelText: "Nombre",
        hintText: "Ingrese su nombre",
      ),
      validator: (value) {
        if (value == null || value.isEmpty) {
          return "Por favor escriba su nombre";
        }
        return null;
      },
    );
  }
}
