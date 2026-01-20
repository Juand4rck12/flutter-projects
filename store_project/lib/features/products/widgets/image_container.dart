import 'package:flutter/material.dart';
import 'package:store_project/features/products/models/product_model.dart';

class ImageContainer extends StatelessWidget {
  final Product product;
  final double screenWidth;
  final double screenHeight;
  const ImageContainer({
    super.key,
    required this.product,
    required this.screenWidth,
    required this.screenHeight,
  });

  @override
  Widget build(BuildContext context) {
    return Image.network(
      product.images.isNotEmpty && product.images.first.isNotEmpty
          ? product.images.first
          : '',
      width: double.infinity, // Ocupa todo el ancho disponible
      height: screenHeight * 0.35,
      fit: BoxFit.cover, // Cubre todo el espacio sin deformar
      errorBuilder: (context, error, stackTrace) {
        return Image.asset(
          "assets/not-available.jpg",
          width: double.infinity,
          height: screenHeight * 0.35,
          fit: BoxFit.cover,
        );
      },
      loadingBuilder: (context, child, loadingProgress) {
        if (loadingProgress == null) return child;
        return SizedBox(
          width: double.infinity,
          height: screenHeight * 0.35,
          child: const Center(child: CircularProgressIndicator()),
        );
      },
    );
  }
}
