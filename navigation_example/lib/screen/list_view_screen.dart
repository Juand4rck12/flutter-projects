import 'package:faker/faker.dart';
import 'package:flutter/material.dart';
import 'package:navigation_example/screen/news_screen.dart';

class ListViewScreen extends StatelessWidget {
  const ListViewScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final faker = Faker();
    return Scaffold(
      appBar: AppBar(title: const Text("Lista de navegación")),
      body: ListView.builder(
        itemCount: 10,
        itemBuilder: (context, index) {
          final title = faker.lorem.sentence();
          final description = faker.lorem.word();

          return ListTile(
            leading: const Icon(Icons.article, color: Colors.blue),
            title: Text(title),
            trailing: const Icon(Icons.arrow_forward_ios),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => NewsScreen(
                  title: title,
                  description: description
                )),
              );
            },
          );
        },
      ),
    );
  }
}
