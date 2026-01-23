import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:store_project/features/products/models/product_model.dart';
import 'package:store_project/features/products/providers/cart_provider.dart';
import 'package:store_project/features/products/repositories/product_repository.dart';
import 'package:store_project/features/products/screens/shopping_cart_screen.dart';
import 'package:store_project/features/products/widgets/cart/cart_container.dart';
import 'package:store_project/features/products/widgets/product/product_view_widget.dart';
import 'package:store_project/features/products/widgets/main_view_paginator.dart';

class ProductListScreen extends StatefulWidget {
  const ProductListScreen({super.key});

  @override
  State<ProductListScreen> createState() => _ProductListScreenState();
}

class _ProductListScreenState extends State<ProductListScreen> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  double screenHeight = 0;
  double screenWidth = 0;
  final ProductRepository _repository = ProductRepository();
  List<Product> _products = [];
  bool _isLoading = true;
  int currentPage = 1;
  int pageSize = 12;
  int totalPages = 1;

  @override
  void initState() {
    super.initState();
    if (mounted) _loadProducts();
  }

  Future<void> _loadProducts() async {
    try {
      final response = await _repository.getPaginatedProducts(
        currentPage,
        pageSize,
      );
      setState(() {
        _products = response.products;
        totalPages = response.pagination.pageCount;
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
    screenHeight = MediaQuery.sizeOf(context).height;
    screenWidth = MediaQuery.sizeOf(context).width;

    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
        title: const Text(
          "Listado de productos",
          style: TextStyle(fontSize: 24.0, fontWeight: FontWeight.bold),
        ),
        actions: [
          Row(
            children: <Widget>[
              IconButton(
                onPressed: () {
                  Navigator.pushNamed(context, "/admin-login");
                },
                icon: const Icon(Icons.account_circle_rounded, size: 40.0),
              ),
              Stack(
                alignment: Alignment.topRight,
                children: [
                  IconButton(
                    onPressed: () {
                      _scaffoldKey.currentState?.openEndDrawer();
                    },
                    icon: const Icon(Icons.shopping_cart, size: 40.0),
                  ),
                  Consumer<CartProvider>(
                    builder: (context, cart, child) {
                      return CartContainer(cart: cart);
                    },
                  ),
                ],
              ),
            ],
          ),
          const SizedBox(width: 16.0),
        ],
      ),
      endDrawer: const ShoppingCartScreen(),
      body: _isLoading
          ? const Center(child: CircularProgressIndicator())
          : Column(
              children: [
                Expanded(
                  child: GridView.builder(
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 4,
                          childAspectRatio: 0.90,
                          crossAxisSpacing: 16.0,
                          mainAxisSpacing: 16.0,
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
                ),
                const Divider(height: 1.0, thickness: 2.0),
                MainViewPaginator(
                  currentPage: currentPage,
                  totalPages: totalPages,
                  onPageChanged: (page) {
                    setState(() {
                      currentPage = page;
                      _loadProducts();
                    });
                  },
                ),
              ],
            ),
    );
  }
}
