import 'package:flutter/material.dart';
import 'package:navigation_example/screen/list_view_screen.dart';
import 'package:navigation_example/screen/news_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "Lista de navegación",
      initialRoute: "/",
      routes: {
        "/": (context) => const ListViewScreen(),
        "/noticias": (context) => const NewsScreen()
      },
    );
  }
}
