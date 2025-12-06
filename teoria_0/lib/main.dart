import 'package:flutter/material.dart';
import 'package:teoria_0/pages/pageOne.dart';
import 'package:teoria_0/pages/pageTwo.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "Navegación",
      initialRoute: "pagina1",
      routes: {
        "pagina1": (BuildContext context) => const PageOne(),
        "pagina2": (BuildContext context) => const PageTwo(),
      },
    );
  }
}
