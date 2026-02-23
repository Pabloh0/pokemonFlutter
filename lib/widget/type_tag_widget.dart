import 'package:flutter/material.dart';
import 'package:pokemon_app/models/pokemon_response_model.dart';

final Map<PokemonType, Color> typeColors = {
  //Mapeo los colores por tipo
  PokemonType.AGUA: Colors.blue,
  PokemonType.FUEGO: Colors.red,
  PokemonType.PLANTA: Colors.green,
  PokemonType.ELCTRICO: Colors.yellow,
  PokemonType.ROCA: Colors.brown,
  PokemonType.TIERRA: Colors.brown,
  PokemonType.HIELO: Colors.cyan,
  PokemonType.VOLADOR: Colors.indigo,
  PokemonType.VENENO: Colors.purple,
  PokemonType.BICHO: Colors.lightGreen,
  PokemonType.NORMAL: Colors.grey,
  PokemonType.LUCHA: Colors.orange,
  PokemonType.PSQUICO: Colors.pink,
  PokemonType.SINIESTRO: Colors.black87,
  PokemonType.HADA: Colors.pinkAccent,
  PokemonType.FANTASMA: Colors.deepPurple,
  PokemonType.ACERO: Colors.blueGrey,
  PokemonType.DRAGON: Colors.indigo,
};

Widget typeTag(PokemonType type) {
  //Creo las tags
  return Container(
    padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
    margin: const EdgeInsets.only(right: 6),
    decoration: BoxDecoration(
      color:
          typeColors[type] ?? Colors.grey, //miro que tipo es y le pongo color
      borderRadius: BorderRadius.circular(12),
    ),
    child: Text(
      pokemonTypeValues.reverse[type]!,
      style: const TextStyle(
        color: Colors.white,
        fontWeight: FontWeight.bold,
        fontSize: 9,
      ),
    ),
  );
}
