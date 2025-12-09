import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            ElevatedButton.icon(
              onPressed: () => Navigator.pushNamed(context, 'inicio'),
              icon: const Icon(Icons.home),
              label: const Text('Inicio'),
            ),
            const SizedBox(height: 12),
            ElevatedButton.icon(
              onPressed: () => Navigator.pushNamed(context, 'categorias'),
              icon: const Icon(Icons.category),
              label: const Text('Categorías'),
            ),
            const SizedBox(height: 12),
            ElevatedButton.icon(
              onPressed: () => Navigator.pushNamed(context, 'perfil'),
              icon: const Icon(Icons.person),
              label: const Text('Perfil'),
            ),
            const SizedBox(height: 12),
            ElevatedButton.icon(
              onPressed: () => Navigator.pushNamed(context, 'ajustes'),
              icon: const Icon(Icons.settings),
              label: const Text('Ajustes'),
            ),
          ],
        ),
      ),
    );
  }
}
