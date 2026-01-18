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
        ],
      ),
    );
  }
}
