import 'package:flutter/material.dart';

class ListViewPage extends StatefulWidget {
  const ListViewPage({super.key});

  @override
  State<ListViewPage> createState() => ListViewPageState();
}

class ListViewPageState extends State<ListViewPage> {
  final List<String> nombres = <String>["Numero 1", "Numero 2", "Numero 3"];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("List View")),
      body: ListView.builder(
        itemCount: nombres.length,
        itemBuilder: (BuildContext context, int index) {
          // Se puede usar container o SizedBox
          return SizedBox(
            height: 60.0,
            child: Center(child: Text("Texto ${nombres[index]}")),
          );
        },
      ),
    );
  }
}
