import 'package:flutter/material.dart';

class ContainerPage extends StatelessWidget {
  const ContainerPage({super.key});

  @override
  Widget build(BuildContext context) {
    return DefaultTextStyle(
      style: const TextStyle(fontSize: 25.0),
      child: Center(
        child: Container(
          width: 200.0,
          height: 200.0,
          alignment: Alignment.center,
          decoration: const BoxDecoration(
            color: Colors.red,
            // Radio total 
            // borderRadius: BorderRadius.all(Radius.circular(25.0))

            // Radio con opciones
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(20.0),
              bottomRight: Radius.circular(20.0)
            )
          ),
          child: const Text("Hola Flutter"),
        ),
      ),
    );
  }
}
