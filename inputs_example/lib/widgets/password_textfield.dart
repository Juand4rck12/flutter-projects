import 'package:flutter/material.dart';

class PasswordTextfield extends StatefulWidget {
  const PasswordTextfield({super.key});

  @override
  State<PasswordTextfield> createState() => _PasswordTextfieldState();
}

class _PasswordTextfieldState extends State<PasswordTextfield> {
  final TextEditingController _passwordController = TextEditingController();
  bool _hidePassword = true;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(1.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text("Ingrese su contraseña", style: TextStyle(fontSize: 18.0)),
          const SizedBox(height: 10.0),
          TextField(
            controller: _passwordController,
            obscureText: _hidePassword,
            decoration: InputDecoration(
              border: const OutlineInputBorder(),
              labelText: "Contraseña",
              suffixIcon: IconButton(
                onPressed: () {
                  setState(() {
                    _hidePassword = !_hidePassword;
                  });
                },
                icon: Icon(
                  _hidePassword ? Icons.visibility : Icons.visibility_off,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
