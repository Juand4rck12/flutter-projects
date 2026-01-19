import 'package:flutter/material.dart';
import 'package:store_project/features/products/models/product_model.dart';

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
    return Column(
      spacing: 8.0,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Image.network(
          product.images.isNotEmpty && product.images.first.isNotEmpty
              ? product.images.first
              : '',
          width: screenWidth * 0.15,
          height: screenHeight * 0.30,
          fit: BoxFit.cover,
          errorBuilder: (context, error, stackTrace) {
            return Image.asset(
              "assets/not-available.jpg",
              width: screenWidth * 0.15,
              height: screenHeight * 0.30,
              fit: BoxFit.cover,
            );
          },
          loadingBuilder: (context, child, loadingProgress) {
            if (loadingProgress == null) return child;
            return SizedBox(
              width: screenWidth * 0.15,
              height: screenHeight * 0.30,
              child: const Center(child: CircularProgressIndicator()),
            );
          },
        ),
        Text(
          product.title,
          style: const TextStyle(fontSize: 16.0, fontWeight: FontWeight.bold),
        ),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 12.0),
          decoration: BoxDecoration(
            color: Colors.green,
            borderRadius: BorderRadius.circular(15.0),
          ),
          child: Text(
            "\$${product.price.round()}",
            style: const TextStyle(fontWeight: FontWeight.bold),
          ),
        ),
      ],
    );
  }
}
