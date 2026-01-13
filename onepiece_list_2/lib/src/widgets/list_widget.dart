import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:onepiece_list_2/src/pages/detail_page.dart';

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
          charactersPageBlocks("Brook", 0xff4913c4, "o1"),
          charactersPageBlocks("Luffy", 0xffF82A2D, "o2"),
          charactersPageBlocks("Porgas D. Ace", 0xffFFCB28, "o3"),
          charactersPageBlocks("Boa Hancock", 0xffFE4649, "o4"),
          charactersPageBlocks("Boa Hancock", 0xffDF1C6A, "o5"),
          charactersPageBlocks("Roronoa Zoro", 0xff21E295, "o6"),
        ],
      ),
    );
  }

  Widget charactersPageBlocks(String name, int color, String image) {
    return GestureDetector(
      onTap: () => {
        Navigator.of(context).push(
          CupertinoPageRoute(
            builder: ((context) => DetailPage(
              color: color,
              image: "assets/$image.png",
              title: name,
            )),
          ),
        ),
      },
      child: Container(
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
                  child: Hero(
                    tag: color,
                    child: Image.asset("assets/$image.png"),
                  ),
                ),
                const SizedBox(width: 12.0),
                Text(
                  name,
                  style: const TextStyle(fontSize: 16.0, color: Colors.white),
                ),
              ],
            ),
            IconButton(
              onPressed: () {},
              icon: const Icon(Icons.more_vert_rounded, color: Colors.grey),
            ),
          ],
        ),
      ),
    );
  }

  // PORTADA
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
