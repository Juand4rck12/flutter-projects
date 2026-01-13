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
                  color: Colors.black12.withValues(alpha: 0.6),
                  fontWeight: FontWeight.bold,
                  fontSize: 30.0,
                ),
              ),
            ),
            Positioned(
              top: 150.0,
              bottom: 0.0,
              width: screenWidth,
              child: Column(
                children: [
                  pokedex != null
                      ? Expanded(
                          child: GridView.builder(
                            gridDelegate:
                                const SliverGridDelegateWithFixedCrossAxisCount(
                                  crossAxisCount: 2,
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
                                                child: Text(
                                                  pokedex[index]["num"],
                                                  style: const TextStyle(
                                                    fontWeight: FontWeight.bold,
                                                    fontSize: 18.0,
                                                    color: Colors.black87,
                                                  ),
                                                ),
                                              ),
                                            ],
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
