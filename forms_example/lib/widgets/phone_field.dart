import 'package:flutter/material.dart';

class PhoneField extends StatelessWidget {
  final TextEditingController phoneController;

  const PhoneField({super.key, required this.phoneController});

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: phoneController,
      keyboardType: TextInputType.phone,
      maxLength: 10,
      decoration: const InputDecoration(
        labelText: "teléfono",
        hintText: "Ingrese su teléfono",
      ),
      validator: (value) {
        if (value == null || value.isEmpty) {
          return "Por favor ingrese su correo electronico";
        }
        if (!RegExp(r'^[0-9]+$').hasMatch(value)) {
          return "Por favor ingrese un teléfono valido";
        }
        if (value.length != 10) {
          return "El número debe tener 10 digitos";
        }
        return null;
      },
    );
  }
}
