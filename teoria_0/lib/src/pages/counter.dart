import 'package:flutter/material.dart';

class Counter extends StatefulWidget {
  const Counter({super.key});

  @override
  State<Counter> createState() => _CounterState();
}

class _CounterState extends State<Counter> {
  // Toda variable se declara antes del @override
  int counter = 25;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Contador")),
      body: Center(
        child: Text("Contador: $counter", style: TextStyle(fontSize: 25)),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => {increment()},
        child: const Icon(Icons.add),
      ),
    );
  }

  void increment() {
    setState(() {
      counter++;
    });
  }
}
