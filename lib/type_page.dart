import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:lottie/lottie.dart';

class TypePage extends StatefulWidget {
  const TypePage({Key? key}) : super(key: key);

  @override
  State<TypePage> createState() => _TypePageState();
}

class _TypePageState extends State<TypePage> {
  Map<String, List<dynamic>> categorizedPokemons = {};
  List<String> types = [];
  List<dynamic> pokedex = [];

  final String pokeApi =
      "https://raw.githubusercontent.com/Biuni/PokemonGO-Pokedex/master/pokedex.json";

  @override
  void initState() {
    super.initState();
    fetchPokemonData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 100,
        backgroundColor: Colors.orange,

        title: Row(
          children: [

            Padding(
              padding: EdgeInsets.only(left: 45.0),
              child: Lottie.asset(
                'assets/lottie/ground.json', 
                height: 200,
                width: 200,
                fit: BoxFit.contain,
              ),

            ),
          ],
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: GridView.builder(

          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            childAspectRatio: 1,

          ),
          itemCount: types.length,
          itemBuilder: (context, index) {
            var type = types[index];
            return InkWell(
              child: Padding(
                padding: EdgeInsets.symmetric(
                  vertical: 4,
                  horizontal: 4,
                ),
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(20)),
                    color: type == 'Grass'
                        ? Colors.greenAccent
                        : type == 'Fire'
                            ? Colors.redAccent
                            : type == 'Water'
                                ? Colors.blueAccent
                                : type == 'Electric'
                                    ? Color.fromARGB(255, 192, 192, 95)
                                    : type == 'Rock'
                                        ? Colors.grey
                                        : type == 'Ground'
                                            ? const Color.fromARGB(255, 101, 38,
                                                15)
                                            : type == 'Psychic'
                                                ? Colors.indigo
                                                : type == 'Fighting'
                                                    ? Colors.orange
                                                    : type == 'Bug'
                                                        ? Colors.lightGreen
                                                        : type == 'Ghost'
                                                            ? const Color
                                                                .fromARGB(255,
                                                                3, 93, 6)
                                                            : type == 'Normal'
                                                                ? Colors.black26
                                                                : type ==
                                                                        'Poison'
                                                                    ? Colors
                                                                        .amberAccent
                                                                    : type ==
                                                                            'Ice'
                                                                        ? Colors
                                                                            .blueGrey
                                                                        : type ==
                                                                                'Dragon'
                                                                            ? Color.fromARGB(
                                                                                255,
                                                                                158,
                                                                                86,
                                                                                86)
                                                                            : type == 'Flying'
                                                                                ? const Color.fromARGB(255, 77, 3, 27)
                                                                                : Colors.pinkAccent,
                    border: Border.all(color: Colors.black),
                  ),
                  child: Stack(
                    children: [
                      Positioned(
                        bottom: -10,
                        right: -8,
                        child: Image.asset(
                          'assets/images/pball.png',
                          height: 100,
                          fit: BoxFit.fitHeight,
                        ),
                      ),
                      Positioned(
                        top: 16,
                        left: 10,
                        child: Text(
                          type, // Use the 'type' variable
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                            fontSize: 18,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }

  Future<void> fetchPokemonData() async {
    var url = Uri.https(
      "raw.githubusercontent.com",
      "Biuni/PokemonGO-Pokedex/master/pokedex.json",
    );

    try {
      var response = await http.get(url);
      if (response.statusCode == 200) {
        var decodedJsonData = jsonDecode(response.body);
        var pokemons = decodedJsonData['pokemon'];

        categorizedPokemons.clear();
        pokedex = pokemons;

        for (var pokemon in pokemons) {
          var types = pokemon['type'];
          for (var type in types) {
            if (!categorizedPokemons.containsKey(type)) {
              categorizedPokemons[type] = [];
            }
            categorizedPokemons[type]!.add(pokemon);
          }
        }

        setState(() {
          types = categorizedPokemons.keys.toList();
        });
      }
    } catch (error) {
      print("Error fetching Pokemon data: $error");
    }
  }
}