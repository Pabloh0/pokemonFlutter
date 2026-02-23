import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:pokemon_app/models/pokemon_response_model.dart';

final Map<PokemonType, Color> typeColors = {
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
