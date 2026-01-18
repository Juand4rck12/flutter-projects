import 'package:flutter/material.dart';

class NewsScreen extends StatelessWidget {
  final String title;
  final String description;
  const NewsScreen({super.key, required this.title, required this.description});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Noticias")),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          // spacing: 20.0, // igual que usar el sizedBox()
          children: [
            Text(
              title,
              style: const TextStyle(
                fontSize: 24.0,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 20.0),
            Text(description, style: const TextStyle(fontSize: 18.0)),
          ],
        ),
      ),
    );
  }
}
