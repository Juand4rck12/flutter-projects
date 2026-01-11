import 'package:flutter/material.dart';
import 'package:onepiece_list_2/src/widgets/header_widget.dart';
import 'package:onepiece_list_2/src/widgets/list_widget.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      backgroundColor: Color.fromARGB(255, 16, 16, 16),
      body: Column(
        children: <Widget>[
          HeaderWidget(),
          CharactersList()
        ],
      ),
    );
  }
}