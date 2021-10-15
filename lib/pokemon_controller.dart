import 'package:flutter/material.dart';
import 'package:pokemon/network_service.dart';
import 'package:pokemon/pokemon.dart';
import 'package:provider/provider.dart';

class PokemonController extends ChangeNotifier {
  final List<Pokemon> _pokemons = [];
  final NetworkService _networkService = NetworkService();

  static const String JSON_pokemon_url =
      'https://pokeapi.co/api/v2/pokemon/?limit=50';

  _fetchJSON() async {
    dynamic json = await _networkService.fetchJSONFrom(url: JSON_pokemon_url);
    List<dynamic> jsonPokemons = json['results'];
    for (int i = 0; i < jsonPokemons.length; i++) {
      var pokemon = jsonPokemons[i];
      _pokemons.add(Pokemon.fromJSON(pokemon));
    }
    notifyListeners();
  }

  PokemonController() {
    _fetchJSON();
  }

  int get numberOfPokemons {
    return _pokemons.length;
  }

  Pokemon getPokemonOf({required int index}) {
    return _pokemons[index];
  }

  List<Pokemon> get pokemons {
    return _pokemons;
  }

  add({required Pokemon pokemon}) {
    //noget db add noget
  }
}
