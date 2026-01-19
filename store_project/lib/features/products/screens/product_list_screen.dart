import 'package:flutter/material.dart';
import 'package:store_project/features/products/models/product_model.dart';
import 'package:store_project/features/products/repositories/product_repository.dart';
import 'package:store_project/features/products/widgets/product_view_widget.dart';

class ProductListScreen extends StatefulWidget {
  const ProductListScreen({super.key});

  @override
  State<ProductListScreen> createState() => _ProductListScreenState();
}

class _ProductListScreenState extends State<ProductListScreen> {
  double screenHeight = 0;
  double screenWidth = 0;
  final ProductRepository _repository = ProductRepository();
  List<Product> _products = [];
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    if (mounted) _loadProducts();
  }

  Future<void> _loadProducts() async {
    try {
      final products = await _repository.getProducts();
      setState(() {
        _products = products;
        _isLoading = false;
      });
    } catch (e) {
      setState(() => _isLoading = false);
      if (mounted) {
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(SnackBar(content: Text("Error: $e")));
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    screenHeight = MediaQuery.of(context).size.height;
    screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Listado de productos",
          style: TextStyle(
            fontSize: 24.0,
            fontWeight: FontWeight.bold,
            // color: Colors.blueGrey,
          ),
        ),
      ),
      body: _isLoading
          ? const Center(child: CircularProgressIndicator())
          : GridView.builder(
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 5,
                childAspectRatio: 4 / 5,
              ),
              itemCount: _products.length,
              itemBuilder: (context, index) {
                final product = _products[index];
                return ProductViewWidget(
                  product: product,
                  screenWidth: screenWidth,
                  screenHeight: screenHeight,
                );
              },
            ),
    );
  }
}
