import 'package:flutter/material.dart';
import 'package:inputs_example/widgets/password_textfield.dart';

class HomeScreenWidget extends StatefulWidget {
  const HomeScreenWidget({super.key});

  @override
  State<HomeScreenWidget> createState() => _HomeScreenWidgetState();
}

class _HomeScreenWidgetState extends State<HomeScreenWidget> {
  // Controlador para el TextField
  final TextEditingController _emailController = TextEditingController();

  String? errorMessage;

  void validateEmail() {
    setState(() {
      String email = _emailController.text;
      if (email.isEmpty) {
        errorMessage = "El correo no puede estar vacio";
      } else if (!isValidEmail(email)) {
        errorMessage = "Ingrese un correo valido";
      } else {
        errorMessage = null;
      }
    });
  }

  bool isValidEmail(String email) {
    String emailPattern = r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$';
    RegExp regExp = RegExp(emailPattern);
    return regExp.hasMatch(email);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("TextField Input")),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text("Ingrese su nombre", style: TextStyle(fontSize: 18.0)),
            TextField(
              controller: _emailController,
              decoration: InputDecoration(
                border: const OutlineInputBorder(),
                labelText: "Nombre",
                hintText: "Ingrese su nombre completo",
                errorText: errorMessage,
              ),
              onChanged: (text) {
                debugPrint("Texto ingresado: $text");
              },
            ),
            const SizedBox(height: 20.0),
            const PasswordTextfield(),
            const SizedBox(height: 20.0),
            ElevatedButton(
              onPressed: validateEmail,
              child: const Text("Enviar"),
            ),
          ],
        ),
      ),
    );
  }
}
