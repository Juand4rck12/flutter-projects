import 'package:flutter/material.dart';

class ContainerPage extends StatelessWidget {
  const ContainerPage({super.key});

  @override
  Widget build(BuildContext context) {
    return DefaultTextStyle(
      style: TextStyle(fontSize: 25.0),
      child: Center(
        child: Container(
          width: 400.0,
          height: 200.0,
          color: Colors.red,
          child: Center(child: Text("Hola Flutter",
          )),
        ),
      ),
    );
  }
}
