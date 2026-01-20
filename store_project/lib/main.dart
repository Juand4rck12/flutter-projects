import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:store_project/features/products/providers/cart_provider.dart';
import 'package:store_project/features/products/screens/product_list_screen.dart';

void main() {
  runApp(
    ChangeNotifierProvider(create: (_) => CartProvider(), child: const MyApp()),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      title: "Fake Store",
      home: ProductListScreen(),
      debugShowCheckedModeBanner: false,
    );
  }
}
