import 'package:flutter/material.dart';
import 'package:flutter_application_demo/screens/category/category_screen.dart';
import 'package:flutter_application_demo/screens/supplier/supplier_screen.dart';
import 'package:flutter_application_demo/screens/product/product_screen.dart';
import 'package:flutter_application_demo/screens/sale/sale_screen.dart';
import 'package:flutter_application_demo/screens/home_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "CRUD",
      initialRoute: "home",
      routes: {
        "categorias": (BuildContext context) => const CategoryScreen(),
        "proveedores": (BuildContext context) => const SupplierScreen(),
        "productos": (BuildContext context) => const ProductScreen(),
        "ventas": (BuildContext context) => const SaleScreen(),
        "home": (BuildContext context) => const HomePage(),
      },
      debugShowCheckedModeBanner: false,
    );
  }
}
