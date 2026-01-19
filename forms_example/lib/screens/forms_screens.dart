import 'package:flutter/material.dart';

class FormsScreens extends StatefulWidget {
  const FormsScreens({super.key});

  @override
  State<FormsScreens> createState() => _FormsScreensState();
}

class _FormsScreensState extends State<FormsScreens> {
  final _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Formulario")),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              TextFormField(
                decoration: const InputDecoration(
                  labelText: "Nombre",
                  hintText: "Ingrese su nombre",
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return "Por favor ingrese su nombre";
                  }
                  return null;
                },
              ),
              const SizedBox(height: 20.0),
              ElevatedButton(
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text("Formulario valido")),
                    );
                  }
                },
                child: const Text("Enviar"),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
