import 'package:flutter/material.dart';

class NewsScreen extends StatelessWidget {
  const NewsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Noticias")),
      body: const Center(
        child: Text(
          "Bienvenido a la sección de noticias",
          style: TextStyle(fontSize: 18.0),
        ),
      ),
    );
  }
}
