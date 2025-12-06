import 'package:flutter/material.dart';

class PageOne extends StatefulWidget {
  const PageOne({super.key});

  @override
  State<PageOne> createState() => _PageOneState();
}

class _PageOneState extends State<PageOne> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(child: Text("Hola soy la página 1")),
      floatingActionButton: FloatingActionButton(
        // con el pushNamed navegamos a la ruta especificada
        onPressed: () => {Navigator.pushNamed(context, "pagina2")},
        // con el pushReplacementNamed eliminamos la pagina anterior al redirigir a la nueva
        // onPressed: () => {Navigator.pushReplacementNamed(context, "pagina2")},
        child: Icon(Icons.nat),
      ),
    );
  }
}
