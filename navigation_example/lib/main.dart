import 'package:flutter/material.dart';
import 'package:navigation_example/screen/home_screen.dart';
import 'package:navigation_example/screen/news_screen.dart';
import 'package:navigation_example/screen/profile_screen.dart';
import 'package:navigation_example/screen/settings_screen.dart';

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
        "/": (context) => const HomeScreen(),
        "/news": (context) => const NewsScreen(),
        "/profile": (context) => const ProfileScreen(),
        "/settings": (context) => const SettingsScreen()
      },
      debugShowCheckedModeBanner: false,
    );
  }
}
