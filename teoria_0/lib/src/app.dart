import 'package:flutter/material.dart';
import 'package:teoria_0/src/pages/home.dart';

// Widget sin estado
class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        useMaterial3: false,
        primarySwatch: Colors.blue
      ),
      home: Center(
        child: Home(),
      ),
    );
  }
}