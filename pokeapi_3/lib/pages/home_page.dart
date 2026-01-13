import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late List pokedex = [];
  dynamic changeColor(int index) {
    dynamic setColor;
    switch (pokedex[index]["type"][0]) {
      case "Grass":
        setColor = Colors.greenAccent;
        break;
      case "Fire":
        setColor = Colors.redAccent;
        break;
      case "Water":
        setColor = Colors.blue;
        break;
      case "Poison":
        setColor = Colors.deepPurpleAccent;
        break;
      case "Electric":
        setColor = Colors.amber;
        break;
      case "Rock":
        setColor = Colors.grey;
        break;
      case "Ground":
        setColor = Colors.brown;
        break;
      case "Psychic":
        setColor = Colors.indigo;
        break;
      case "Fighting":
        setColor = Colors.orange;
        break;
      case "Bug":
        setColor = Colors.lightGreenAccent;
        break;
      case "Ghost":
        setColor = Colors.deepPurple;
        break;
      case "Normal":
        setColor = Colors.white12;
        break;
      default:
        setColor = Colors.pink;
    }
    return setColor;
  }

  @override
  void initState() {
    super.initState();
    if (mounted) fetchPokeAPI();
  }

  @override
  Widget build(BuildContext context) {
    var screenWidth = MediaQuery.of(context).size.width;
    var screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      body: Container(
        width: screenWidth,
        height: screenHeight,
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [
              Color.fromARGB(255, 128, 64, 48),
              Color.fromARGB(255, 0, 0, 0),
            ],
            begin: Alignment.topRight,
            end: Alignment.bottomLeft,
          ),
        ),
        child: Stack(
          children: [
            Positioned(
              top: -50,
              right: -50,
              child: Image.asset(
                "assets/pokeball.png",
                width: 170.0,
                fit: BoxFit.fitWidth,
              ),
            ),
            Positioned(
              top: 100.0,
              left: 20.0,
              child: Text(
                "Pokedex",
                style: TextStyle(
                  color: Colors.white70.withValues(alpha: 0.6),
                  fontWeight: FontWeight.bold,
                  fontSize: 40.0,
                ),
              ),
            ),
            Positioned(
              top: 150.0,
              bottom: 0.0,
              width: screenWidth,
              child: Column(
                children: [
                  pokedex.isNotEmpty
                      ? Expanded(
                          child: GridView.builder(
                            gridDelegate:
                                const SliverGridDelegateWithFixedCrossAxisCount(
                                  crossAxisCount: 2,
                                  childAspectRatio: 3 / 5,
                                ),
                            itemCount: pokedex.length,
                            itemBuilder: (context, index) {
                              return Padding(
                                padding: const EdgeInsetsGeometry.symmetric(
                                  vertical: 5.0,
                                  horizontal: 10.0,
                                ),
                                child: InkWell(
                                  child: SafeArea(
                                    child: Stack(
                                      children: [
                                        Container(
                                          width: screenWidth,
                                          margin: const EdgeInsets.only(
                                            top: 80.0,
                                          ),
                                          decoration: const BoxDecoration(
                                            color: Colors.black26,
                                            borderRadius: BorderRadius.all(
                                              Radius.circular(25),
                                            ),
                                          ),
                                          child: Stack(
                                            children: [
                                              Positioned(
                                                top: 90.0,
                                                left: 15.0,
                                                child: Text(
                                                  pokedex[index]["num"],
                                                  style: const TextStyle(
                                                    fontWeight: FontWeight.bold,
                                                    fontSize: 18.0,
                                                    color: Color.fromARGB(
                                                      255,
                                                      128,
                                                      64,
                                                      48,
                                                    ),
                                                  ),
                                                ),
                                              ),
                                              Positioned(
                                                top: 130.0,
                                                left: 15.0,
                                                child: Text(
                                                  pokedex[index]["name"],
                                                  style: const TextStyle(
                                                    fontWeight: FontWeight.bold,
                                                    fontSize: 18.0,
                                                    color: Colors.white54,
                                                  ),
                                                ),
                                              ),
                                              Positioned(
                                                top: 170.0,
                                                left: 15.0,
                                                child: Container(
                                                  padding:
                                                      const EdgeInsets.symmetric(
                                                        horizontal: 10.0,
                                                        vertical: 5.0,
                                                      ),
                                                  decoration: BoxDecoration(
                                                    borderRadius:
                                                        const BorderRadius.all(
                                                          Radius.circular(20.0),
                                                        ),
                                                    color: Colors.black
                                                        .withValues(alpha: 0.5),
                                                  ),
                                                  child: Text(
                                                    pokedex[index]["type"][0],
                                                    style: TextStyle(
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      fontSize: 18.0,
                                                      color: changeColor(index),
                                                      shadows: [
                                                        BoxShadow(
                                                          color: changeColor(
                                                            index,
                                                          ),
                                                          offset: const Offset(
                                                            0,
                                                            0,
                                                          ),
                                                          spreadRadius: 1.0,
                                                          blurRadius: 15.0,
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                        Container(
                                          alignment: Alignment.topCenter,
                                          child: CachedNetworkImage(
                                            imageUrl: pokedex[index]["img"],
                                            height: 180.0,
                                            fit: BoxFit.fitHeight,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              );
                            },
                          ),
                        )
                      : const Center(child: CircularProgressIndicator()),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  void fetchPokeAPI() async {
    var url = Uri.https(
      "raw.githubusercontent.com",
      "/Biuni/PokemonGO-Pokedex/master/pokedex.json",
    );

    try {
      final response = await http.get(url);
      if (response.statusCode == 200) {
        var data = jsonDecode(response.body);
        setState(() {
          pokedex = data["pokemon"];
        });
        if (kDebugMode) print(pokedex);
      } else {
        if (kDebugMode) print("Error: ${response.statusCode}");
      }
    } catch (e) {
      if (kDebugMode) print("Error al obtener los datos: $e");
    }
  }
}
