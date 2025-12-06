import 'package:flutter/material.dart';
import 'package:teoria_0/pages/containerPage.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      title: "Container",
      home: ContainerPage(),
    );
  }
}
