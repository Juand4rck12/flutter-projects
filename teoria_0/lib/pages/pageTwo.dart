import 'package:flutter/material.dart';

class PageTwo extends StatefulWidget {
  const PageTwo({super.key});

  @override
  State<PageTwo> createState() => _PageTwoState();
}

class _PageTwoState extends State<PageTwo> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Text("Hola soy la página 2"),
      ),
      floatingActionButton: FloatingActionButton(
        // Con pop, volvemos a la ruta anterior
        onPressed: () => {Navigator.pop(context)},
        child: Icon(Icons.nat),
      ),
    );
  }
}