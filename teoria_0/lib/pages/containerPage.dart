import 'package:flutter/material.dart';

class ContainerPage extends StatelessWidget {
  const ContainerPage({super.key});

  @override
  Widget build(BuildContext context) {
    return DefaultTextStyle(
      style: TextStyle(fontSize: 25.0),
      child: Center(
        child: Container(

          width: 200.0,
          height: 200.0,
          color: Colors.red,

          // Padding only, para especificar direcciones
          padding: EdgeInsets.only(
            top: 25.0,
            bottom: 25.0,
            right: 15.0,
            left: 15.0
          ),

          // Padding all para mismo valor en todas las direcciones
          // padding: EdgeInsets.all(25),

          // Padding simetrico para especificar lados
          // Verticales y horizontales
          // padding: EdgeInsets.symmetric(
          //   vertical: 10.0,
          //   horizontal: 10.0
          // ),

          child: Container(
            width: 200.0,
            height: 200.0,
            color: Colors.amber,
            alignment: Alignment.center,
            child: Text("Hola Flutter")),
        ),
      ),
    );
  }
}
