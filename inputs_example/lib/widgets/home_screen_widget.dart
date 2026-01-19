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
  final TextEditingController _phoneController = TextEditingController();

  bool isAccept = false;

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
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text("Ingrese su email", style: TextStyle(fontSize: 18.0)),
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
            const Text(
              "Ingrese su número telefonico",
              style: TextStyle(fontSize: 18.0),
            ),
            TextField(
              controller: _phoneController,
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                labelText: "Teléfono",
                hintText: "Ingrese su número telefonico",
              ),
            ),
            const SizedBox(height: 20.0),
            Row(
              children: [
                Checkbox(
                  value: isAccept,
                  onChanged: (bool? value) {
                    setState(() {
                      isAccept = value ?? false;
                    });
                  },
                ),
                const Text("Acepto terminos y condiciones"),
              ],
            ),
            if (isAccept) const Text("Gracias por aceptar terminos"),
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
