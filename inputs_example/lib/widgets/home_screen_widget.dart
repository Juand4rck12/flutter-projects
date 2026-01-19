import 'package:flutter/material.dart';

class HomeScreenWidget extends StatefulWidget {
  const HomeScreenWidget({super.key});

  @override
  State<HomeScreenWidget> createState() => _HomeScreenWidgetState();
}

class _HomeScreenWidgetState extends State<HomeScreenWidget> {
  // Controlador para el TextField
  final TextEditingController _controller = TextEditingController();
  String? errorMessage;

  void _validateInput() {
    setState(() {
      if (_controller.text.isEmpty) {
        errorMessage = "Este campo no puede estar vacio";
      } else {
        errorMessage = null;
      }
    });
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
              controller: _controller,
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
            ElevatedButton(
              onPressed: () {
                _validateInput();
                if (errorMessage == null) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text("Hola! ${_controller.text}!")),
                  );
                }
              },
              child: const Text("Mostrar nombre"),
            ),
          ],
        ),
      ),
    );
  }
}
