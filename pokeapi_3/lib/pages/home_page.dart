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
  late List pokedex;
  @override
  void initState() {
    super.initState();
    if (mounted) fetchPokeAPI();
  }

  @override
  Widget build(BuildContext context) {
    return Container();
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
