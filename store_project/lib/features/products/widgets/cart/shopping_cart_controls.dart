import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:store_project/features/products/providers/cart_provider.dart';

class ShoppingCartControls extends StatelessWidget {
  final int productId;
  final int quantity;
  final double price;
  const ShoppingCartControls({
    super.key,
    required this.productId,
    required this.quantity,
    required this.price,
  });

  @override
  Widget build(BuildContext context) {
    final cart = context.read<CartProvider>();

    return Column(
      children: [
        // Botón de eliminar
        IconButton(
          onPressed: () {
            cart.removeProduct(productId);
          },
          icon: const Icon(Icons.delete, color: Colors.red, size: 20.0),
        ),

        // Controles +/-
        Row(
          children: [
            // Botón decrementar
            IconButton(
              onPressed: () {
                cart.decrementQuantity(productId);
              },
              icon: const Icon(Icons.remove_circle_outline, size: 24.0),
            ),

            // Cantidad
            Text(
              "$quantity",
              style: const TextStyle(
                fontSize: 16.0,
                fontWeight: FontWeight.bold,
              ),
            ),

            // Botón incrementar
            IconButton(
              onPressed: () {
                cart.incrementQuantity(productId);
              },
              icon: const Icon(Icons.add_circle_outline, size: 24.0),
            ),
          ],
        ),

        // Precio unitario
        Text(
          "Unidad: ${price.round()}",
          style: const TextStyle(fontSize: 12.0, color: Colors.grey),
        ),
      ],
    );
  }
}
