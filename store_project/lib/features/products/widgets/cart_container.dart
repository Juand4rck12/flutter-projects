import 'package:flutter/material.dart';
import 'package:store_project/features/products/providers/cart_provider.dart';

class CartContainer extends StatelessWidget {
  final CartProvider cart;
  const CartContainer({super.key, required this.cart});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(4.0),
      decoration: BoxDecoration(
        color: Colors.red,
        borderRadius: BorderRadius.circular(10.0),
      ),
      constraints: const BoxConstraints(minWidth: 20.0, minHeight: 20.0),
      child: Text(
        "${cart.itemCount}",
        style: const TextStyle(
          color: Colors.white,
          fontSize: 12.0,
          fontWeight: FontWeight.bold,
        ),
        textAlign: TextAlign.center,
      ),
    );
  }
}
