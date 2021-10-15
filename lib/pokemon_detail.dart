import 'package:flutter/material.dart';
import 'pokemon.dart';

class PokemonDetail extends StatefulWidget {
   Pokemon pokemon;

  PokemonDetail({Key? key, required this.pokemon}) : super(key: key);

  @override
  State<PokemonDetail> createState() => _PokemonDetailState();
}

class _PokemonDetailState extends State<PokemonDetail> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.pokemon.name),
      ),
      body: ListView(
        children: [
          FutureBuilder(
              future: widget.pokemon.fetchImageURL(),
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  String imageURL = snapshot.data as String;
                  return Image.network(imageURL);
                } else {
                  return const CircularProgressIndicator();
                }
              }),
          InkWell(
            child: Icon(widget.pokemon.favorite
                ? Icons.favorite
                : Icons.favorite_border),
            onTap: () {
              setState(() {
                widget.pokemon.favorite = !(widget.pokemon.favorite);
              });
            },
          ),
          FloatingActionButton(onPressed: () {
            Navigator.pop(context, widget.pokemon);
          }),
        ],
      ),
    );
  }
}
