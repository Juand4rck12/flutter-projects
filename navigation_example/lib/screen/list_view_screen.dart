import 'package:flutter/material.dart';

class ListViewScreen extends StatelessWidget {
  const ListViewScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Lista de navegación")),
      body: ListView(
        children: [
          ListTile(
            leading: const Icon(Icons.article, color: Colors.blue),
            title: const Text("Noticias"),
            trailing: const Icon(Icons.arrow_forward_ios_rounded),
            onTap: () {
              Navigator.pushNamed(context, "/noticias");
            },
          ),
          const SizedBox(height: 20.0),
          ElevatedButton(
            onPressed: () {
              Navigator.pop(context);
            },
            child: const Text("Volver usando Pop"),
          ),
          ElevatedButton(
            onPressed: () {
              if (Navigator.canPop(context)) {
                Navigator.maybePop(context);
              } else {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text("No hay pantallas previas para regresar"),
                  ),
                );
              }
            },
            child: const Text("Volver usando maybePop"),
          ),
        ],
      ),
    );
  }
}
