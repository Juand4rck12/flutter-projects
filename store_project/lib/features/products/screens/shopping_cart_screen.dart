import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:store_project/features/products/providers/cart_provider.dart';
import 'package:store_project/features/products/widgets/cart/shopping_cart_products.dart';
import 'package:store_project/features/products/widgets/cart/thanks_dialog.dart';
import 'package:store_project/features/products/widgets/custom_snackbar_alert.dart';

class ShoppingCartScreen extends StatelessWidget {
  const ShoppingCartScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final windowSize = MediaQuery.sizeOf(context);

    return Drawer(
      width: windowSize.width * 0.30,
      child: Consumer<CartProvider>(
        builder: (context, cart, child) {
          return Column(
            children: [
              // Header del carrito
              Container(
                padding: const EdgeInsets.all(20.0),
                color: Colors.teal,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text(
                      "Carrito de compras",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 20.0,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    IconButton(
                      onPressed: () => Navigator.pop(context),
                      icon: const Icon(Icons.close, color: Colors.white),
                    ),
                  ],
                ),
              ),

              // Lista de productos
              ShoppingCartProducts(cart: cart),

              // Footer con total y botón de compra
              if (cart.items.isNotEmpty)
                Container(
                  padding: const EdgeInsets.all(20.0),
                  decoration: BoxDecoration(
                    color: Colors.grey[100],
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.withValues(alpha: 0.3),
                        spreadRadius: 1,
                        blurRadius: 5,
                        offset: const Offset(0, -3),
                      ),
                    ],
                  ),
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Text(
                            "Total:",
                            style: TextStyle(
                              fontSize: 20.0,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Text(
                            "\$${cart.totalPrice.round()}",
                            style: const TextStyle(
                              fontSize: 24.0,
                              fontWeight: FontWeight.bold,
                              color: Colors.teal,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 12.0),
                      SizedBox(
                        width: double.infinity,
                        child: ElevatedButton(
                          onPressed: () {
                            showDialog(
                              context: context,
                              builder: (context) {
                                return const ThanksDialog();
                              },
                            );
                            cart.clearCart();
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.teal,
                            padding: const EdgeInsets.symmetric(vertical: 16.0),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadiusGeometry.circular(8.0),
                            ),
                          ),
                          child: const Text(
                            "Proceder al pago",
                            style: TextStyle(
                              fontSize: 16.0,
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
            ],
          );
        },
      ),
    );
  }
}
