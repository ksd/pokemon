import 'package:flutter/material.dart';
import 'package:pokemon/pokemon_controller.dart';
//import 'package:pokemon/pokemon_detail.dart';
import 'package:provider/provider.dart';
import 'pokemon.dart';

void main() {
  runApp(
    ChangeNotifierProvider(
        create: (BuildContext context) => PokemonController(),
        child: const MyApp()),
  );
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

class MyHomePage extends StatelessWidget {
  const MyHomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Pokemons"),
      ),
      body: Consumer<PokemonController>(
          builder: (context, _pokemonController, widget) {
        return ListView.builder(
            itemCount: _pokemonController.numberOfPokemons,
            itemBuilder: (context, index) {
              final Pokemon pokemon =
                  _pokemonController.getPokemonOf(index: index);
              return pokemonRow(context, pokemon);
            });
      }),
    );
  }

  pokemonRow(BuildContext context, Pokemon pokemon) {
    return ListTile(
      leading: const Icon(Icons.person_pin_outlined),
      title: Text(pokemon.name),
    );
  }
}
