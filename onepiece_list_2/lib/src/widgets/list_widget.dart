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
          charactersPageBlocks("nombre", 0xff21E295, "o1"),
          charactersPageBlocks("nombre", 0xff21E295, "o1"),
          charactersPageBlocks("nombre", 0xff21E295, "o1"),
          charactersPageBlocks("nombre", 0xff21E295, "o1"),
          charactersPageBlocks("nombre", 0xff21E295, "o1"),
          charactersPageBlocks("nombre", 0xff21E295, "o1"),
        ],
      ),
    );
  }

  Widget charactersPageBlocks(String name, int color, String image) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 5.0),
      margin: const EdgeInsets.only(bottom: 20.0),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(15.0),
        color: const Color.fromARGB(66, 43, 43, 43),
      ),
      height: 65.0,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              Container(
                decoration: BoxDecoration(
                  boxShadow: [
                    BoxShadow(
                      blurRadius: 8.0,
                      offset: const Offset(0, 5),
                      spreadRadius: 0.0,
                      blurStyle: BlurStyle.normal,
                      color: Color(color),
                    ),
                  ],
                  borderRadius: BorderRadius.circular(20.0),
                ),
                padding: const EdgeInsets.all(5.0),
                child: Image.asset("assets/$image.png"),
              ),
              const SizedBox(width: 12.0),
              Text(
                name,
                style: const TextStyle(fontSize: 16.0, color: Colors.white),
              ),
            ],
          ),
          const IconButton(
            onPressed: null,
            icon: Icon(Icons.more_vert_rounded, color: Colors.grey),
          ),
        ],
      ),
    );
  }

  Widget frontPageBlocks(String image, String title, String subtitle) {
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
