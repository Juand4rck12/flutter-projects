import 'package:flutter/material.dart';
import 'package:store_project/features/products/providers/cart_provider.dart';
import 'package:store_project/features/products/widgets/cart/shopping_cart_item.dart';

class ShoppingCartProducts extends StatelessWidget {
  final CartProvider cart;

  const ShoppingCartProducts({super.key, required this.cart});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: cart.items.isEmpty
          ? const Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.add_shopping_cart_outlined,
                    size: 80.0,
                    color: Colors.grey,
                  ),
                  SizedBox(height: 16.0),
                  Text(
                    "Tu carrito está vacio",
                    style: TextStyle(fontSize: 18.0, color: Colors.grey),
                  ),
                ],
              ),
            )
          : ListView.builder(
              itemCount: cart.items.length,
              itemBuilder: (context, index) {
                final cartItem = cart.items[index];
                return ShoppingCartItem(cartItem: cartItem);
              },
            ),
    );
  }
}
