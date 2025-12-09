import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Sistema de Inventario"),
        centerTitle: true,
      ),
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            ElevatedButton.icon(
              onPressed: () => Navigator.pushNamed(context, 'categorias'),
              icon: const Icon(Icons.category),
              label: const Text('Categorías'),
            ),
            const SizedBox(height: 12),
            ElevatedButton.icon(
              onPressed: () => Navigator.pushNamed(context, 'proveedores'),
              icon: const Icon(Icons.local_shipping),
              label: const Text('Proveedores'),
            ),
            const SizedBox(height: 12),
            ElevatedButton.icon(
              onPressed: () => Navigator.pushNamed(context, 'productos'),
              icon: const Icon(Icons.inventory),
              label: const Text('Productos'),
            ),
            const SizedBox(height: 12),
            ElevatedButton.icon(
              onPressed: () => Navigator.pushNamed(context, 'ventas'),
              icon: const Icon(Icons.point_of_sale),
              label: const Text('Ventas'),
            ),
          ],
        ),
      ),
    );
  }
}
