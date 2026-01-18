import 'package:flutter/material.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Pantalla de perfil")),
      body: Center(
        child: ElevatedButton(
          onPressed: () {
            _showDialogConfirmation(context);
          },
          child: const Text("Ir a configuracion"),
        ),
      ),
    );
  }
}

void _showDialogConfirmation(BuildContext context) {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        title: const Text("Confirmacion"),
        content: const Text("¿Estas seguro que quieres ir a configuración?"),
        actions: [
          ElevatedButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            child: const Text("Cancelar"),
          ),
          TextButton(
            onPressed: () {
              Navigator.pushReplacementNamed(context, "/settings");
            },
            child: const Text("Ir a configuración"),
          ),
        ],
      );
    },
  );
}
