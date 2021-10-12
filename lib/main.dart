import 'package:flutter/material.dart';
import 'package:pokemon/pokemon_detail.dart';
import 'pokemon.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key}) : super(key: key);

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

Future<List<Pokemon>> fetchPokemons() async {
  final response =
      await http.get(Uri.parse('https://pokeapi.co/api/v2/pokemon/?limit=50'));
  List<Pokemon> pokemons = [];
  if (response.statusCode == 200) {
    var jsonData = json.decode(response.body);

    List<dynamic> jsonPokemons = jsonData['results'];
    for (int i = 0; i < jsonPokemons.length; i++) {
      var pokemon = jsonPokemons[i];
      pokemons.add(Pokemon.fromJSON(pokemon));
    }
  }
  return pokemons;
}

class _MyHomePageState extends State<MyHomePage> {
  late Future<List<Pokemon>> _futurePokemonList;

  @override
  void initState() {
    super.initState();
    _futurePokemonList = fetchPokemons();
  }

  _navigate_to_Detail(Pokemon pokemon, int index) async {
    var editedPokemon = await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) {
          return PokemonDetail(
            pokemon: pokemon,
          );
        },
      ),
    );
    
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Pokemons"),
      ),
      body: FutureBuilder(
        future: _futurePokemonList,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            List<Pokemon> pokemonsSnapshot = snapshot.data as List<Pokemon>;
            return ListView.builder(
              itemCount: pokemonsSnapshot.length,
              itemBuilder: (context, index) {
                Pokemon pokemon = pokemonsSnapshot[index];
                return InkWell(
                  onTap: () => {_navigate_to_Detail(pokemon, index)},
                  child: Card(
                      child: ListTile(
                    title: Text(pokemon.name),
                    leading: FutureBuilder(
                        future: pokemon.fetchImageURL(),
                        builder: (context, snapshot) {
                          if (snapshot.hasData) {
                            String imageURL = snapshot.data as String;
                            return Image.network(imageURL);
                          } else {
                            return const CircularProgressIndicator();
                          }
                        }),
                  )),
                );
              },
            );
          } else if (snapshot.hasError) {
            return Text("$snapshot.error");
          } else {
            return const CircularProgressIndicator();
          }
        },
      ),
    );
  }
}
