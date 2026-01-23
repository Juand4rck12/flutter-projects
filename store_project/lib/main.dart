import 'package:flutter/material.dart';
// import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:provider/provider.dart';
import 'package:store_project/features/products/providers/cart_provider.dart';
import 'package:store_project/features/products/providers/create_product_provider.dart';
import 'package:store_project/features/auth/login_form_provider.dart';
import 'package:store_project/features/products/screens/admin_login_screen.dart';
import 'package:store_project/features/products/screens/create_product_screen.dart';
import 'package:store_project/features/products/screens/product_list_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  // await dotenv.load(fileName: ".env");
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => CartProvider()),
        ChangeNotifierProvider(create: (_) => LoginFormProvider()),
        ChangeNotifierProvider(create: (_) => CreateProductProvider()),
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
      routes: {
        "/admin-login": (context) => const AdminLoginScreen(),
        "/create-product": (context) => const CreateProductScreen(),
      },
    );
  }
}
