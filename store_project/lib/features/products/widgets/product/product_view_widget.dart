import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:store_project/features/products/models/product_model.dart';
import 'package:store_project/features/products/providers/cart_provider.dart';
import 'package:store_project/features/products/widgets/utils/custom_snackbar_alert.dart';
import 'package:store_project/features/products/widgets/utils/image_container.dart';

class ProductViewWidget extends StatelessWidget {
  final Product product;
  final double screenWidth;
  final double screenHeight;
  const ProductViewWidget({
    super.key,
    required this.product,
    required this.screenWidth,
    required this.screenHeight,
  });

  @override
  Widget build(BuildContext context) {
    var formatterCurrency = NumberFormat.currency(
      locale: 'es_CO',
      name: "",
      decimalDigits: 0,
    );

    return Card(
      // Card da elevacion y bordes redondeados
      elevation: 2,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12.0)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          ClipRRect(
            // ClipRRect recorta la imagen con bordes redondeados
            borderRadius: const BorderRadius.vertical(
              top: Radius.circular(12.0),
            ),
            child: ImageContainer(
              product: product,
              screenWidth: screenWidth,
              screenHeight: screenHeight,
            ),
          ),

          // Padding para separar el contenido de los bordes
          Padding(
            padding: const EdgeInsets.all(12.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              spacing: 8.0,
              children: [
                // Titulo del producto
                Text(
                  product.title,
                  maxLines: 2,
                  // Añade "..." si es muy largo
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(
                    fontSize: 16.0,
                    fontWeight: FontWeight.bold,
                    height: 1.3, // Espaciado entre lineas
                  ),
                ),

                const SizedBox(height: 4.0),

                // Row para precio y botón
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    // Precio
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "\$${formatterCurrency.format(product.price)}",
                          style: const TextStyle(
                            fontSize: 18.0,
                            fontWeight: FontWeight.bold,
                            color: Colors.black87,
                          ),
                        ),
                        const Text(
                          "Precio unitario",
                          style: TextStyle(fontSize: 10.0, color: Colors.grey),
                        ),
                      ],
                    ),

                    // Boton para agregar al carrito
                    CircleAvatar(
                      radius: 20.0,
                      backgroundColor: Colors.teal,
                      child: IconButton(
                        onPressed: () {
                          showCustomSnackBar(
                            context,
                            message: "Articulo añadido exitosamente!",
                          );
                          // Lee el provider y agrega el producto
                          context.read<CartProvider>().addProduct(product);
                        },
                        icon: const Icon(
                          Icons.add,
                          color: Colors.white,
                          size: 20.0,
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
