import 'package:flutter/material.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  double targetValue = 24.0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Animaciones")),
      body: Center(
        child: TweenAnimationBuilder<double>(
          tween: Tween<double>(begin: 0, end: targetValue),
          duration: const Duration(seconds: 1),
          builder: (BuildContext context, double size, Widget? child) {
            return IconButton(
              iconSize: size,
              color: Colors.blue,
              onPressed: () => {
                setState(() {
                  targetValue = targetValue == 24.0 ? 48.0 : 24.0;
                }),
              },
              icon: child!,
            );
          },
          child: const Icon(Icons.aspect_ratio),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.blue,
        onPressed: () => {},
        child: const Icon(Icons.play_arrow, color: Colors.white),
      ),
    );
  }
}
