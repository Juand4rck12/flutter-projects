import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "Imagenes",
      home: Scaffold(
        appBar: AppBar(title: const Text("Mostrar imagenes")),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              SizedBox(
                height: 250.0,
                width: 250.0,
                child: SvgPicture.asset("assets/wolf.svg"),
              ),

              SizedBox(
                height: 250.0,
                width: 250.0,
                child: Image.network(
                  'https://i.programmerhumor.io/2025/03/0366215f9d522a201fddf2849bb3cac7.jpeg',
                  fit: BoxFit.cover,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
