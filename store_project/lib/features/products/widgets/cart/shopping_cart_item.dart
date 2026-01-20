import 'package:flutter/material.dart';
import 'package:store_project/features/products/providers/cart_provider.dart';
import 'package:store_project/features/products/widgets/cart/shopping_cart_controls.dart';

class ShoppingCartItem extends StatelessWidget {
  final CartItem cartItem;
  const ShoppingCartItem({super.key, required this.cartItem});

  @override
  Widget build(BuildContext context) {
    final product = cartItem.product;

    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
      child: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Row(
          children: [
            // Imagen del producto
            ClipRRect(
              borderRadius: BorderRadius.circular(8.0),
              child: Image.network(
                product.images.first,
                width: 80.0,
                height: 80.0,
                fit: BoxFit.cover,
                errorBuilder: (context, error, stackTrace) {
                  return Container(
                    width: 80.0,
                    height: 80.0,
                    color: Colors.grey[300],
                    child: const Icon(Icons.error),
                  );
                },
              ),
            ),

            const SizedBox(width: 12.0),

            // Información del producto
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    product.title,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 14.0,
                    ),
                  ),
                  const SizedBox(height: 4.0),

                  // Subtotal
                  Text(
                    "\$${(product.price * cartItem.quantity).round()}",
                    style: const TextStyle(
                      fontSize: 16.0,
                      color: Colors.teal,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),

            // Controles de cantidad
            ShoppingCartControls(
              productId: product.id,
              quantity: cartItem.quantity,
              price: product.price,
            ),
          ],
        ),
      ),
    );
  }
}
