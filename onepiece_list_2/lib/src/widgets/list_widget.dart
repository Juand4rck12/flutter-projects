import 'package:flutter/material.dart';

class CharactersList extends StatefulWidget {
  const CharactersList({super.key});

  @override
  State<CharactersList> createState() => _CharactersListState();
}

class _CharactersListState extends State<CharactersList> {
  double screenWidth = 0.0;

  final titleStyle = const TextStyle(
    fontSize: 16.0,
    fontWeight: FontWeight.bold,
    color: Colors.white,
  );

  @override
  Widget build(BuildContext context) {
    screenWidth = MediaQuery.of(context).size.width - 50.0;

    return Expanded(
      child: ListView(
        padding: const EdgeInsets.all(25.0),
        children: [
          Text("Portada", style: titleStyle),
          const SizedBox(height: 15.0),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              frontPageBlocks("p1.jpg", "titulo: ", "2018"),
              frontPageBlocks("p2.jpg", "titulo: ", "2020"),
              frontPageBlocks("p3.jpg", "titulo: ", "2022"),
            ],
          ),
          const Divider(
            thickness: 1,
            height: 60.0,
            color: Color.fromARGB(255, 123, 123, 123),
          ),
          const SizedBox(height: 15.0),
        ],
      ),
    );
  }

  Column frontPageBlocks(String image, String title, String subtitle) {
    return Column(
      children: [
        ClipRRect(
          borderRadius: BorderRadiusGeometry.circular(18.0),
          child: Image.asset(
            "assets/$image",
            width: screenWidth * 0.3,
            height: 110.0,
            fit: BoxFit.cover,
          ),
        ),
        const SizedBox(height: 15.0),
        RichText(
          text: TextSpan(
            text: title,
            style: const TextStyle(color: Colors.white70, fontSize: 14.0),
            children: [
              TextSpan(
                text: subtitle,
                style: const TextStyle(
                  color: Colors.grey,
                  fontWeight: FontWeight.w300,
                  fontSize: 12.0,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
