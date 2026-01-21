import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:store_project/features/products/providers/cart_provider.dart';
import 'package:store_project/features/products/providers/login_form_provider.dart';
import 'package:store_project/features/products/screens/admin_login_screen.dart';
import 'package:store_project/features/products/screens/product_list_screen.dart';

void main() {
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => CartProvider()),
        ChangeNotifierProvider(create: (_) => LoginFormProvider()),
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "Fake Store",
      home: const ProductListScreen(),
      debugShowCheckedModeBanner: false,
      routes: {"/admin-login": (context) => const AdminLoginScreen()},
    );
  }
}
