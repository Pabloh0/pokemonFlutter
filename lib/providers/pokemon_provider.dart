import 'dart:async';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:pokemon_app/models/admin_response_model.dart';
import 'package:pokemon_app/models/moves_response_model.dart';
import 'package:pokemon_app/models/pokemon_response_model.dart';
import 'package:pokemon_app/services/pokemon_service.dart';

class PokemonProvider with ChangeNotifier {
  List<Admin> admins = [];
  List<Pokemon> pokemons = [];
  //List<Move> moves = [];
  Pokemon? pokemonDelDia;
  final List<int> idsPopulares = [25, 6, 133, 1, 150];
  List<Pokemon> pokemonFiltrados = [];

  int id = 25; //Aqui es donde empieza siempre el pokemon del dia (Pikachu)
  final _random = Random();

  bool isLoading =
      true; //Esta variable is loading me sirve sobre todo para el login, ya que hasta que no termine..
  //de llegar los datos no deja darle al boton de iniciar sesion, ya que si le daba y lo tenia bien le iba a decir que no igual

  PokemonService pokemonService = PokemonService();

  PokemonProvider() {
    getAdmins();
    getPokemons();
    //getMoves();
    getPokemonDelDia(
      id,
    ); //Primero llamamos al pokemon del dia para no esperar los primeros 20 segundos
    startRandomIdGenerator();
  }

  void filterPokemons(String query) {
    //Esto me sirve para el buscador, se le pasa la query y va mirando pokemon por pokemon..
    //cuales contienen las letras que le estamos pasando, cada vez que se cambia una letra se actualiza
    if (query.isEmpty) {
      pokemonFiltrados = pokemons;
    } else {
      pokemonFiltrados = pokemons
          .where((p) => p.name.toLowerCase().contains(query.toLowerCase()))
          .toList();
    }
    notifyListeners();
  }

  Future getAdmins() async {
    isLoading = true;
    notifyListeners();

    admins = await pokemonService.getAdmins();

    isLoading = false;
    notifyListeners();
  }

  Future getPokemons() async {
    isLoading = true;
    notifyListeners();

    pokemons = await pokemonService.getPokemons();

    isLoading = false;
    notifyListeners();
  }

  // Future getMoves() async {
  //   isLoading = true;
  //   notifyListeners();

  //   moves = await pokemonService.getMoves();

  //   isLoading = false;
  //   notifyListeners();
  // }

  Future getPokemonDelDia(int id) async {
    pokemonDelDia = await pokemonService.getPokemon(id);
    notifyListeners();
  }

  void startRandomIdGenerator() {
    //Aqui es donde se genera la id para el pokemon del día
    Timer.periodic(Duration(seconds: 20), (timer) async {
      id = _random.nextInt(600) + 1;
      print('Nuevo id: $id');
      await getPokemonDelDia(id);
    });
  }

  List<Pokemon> get pokemonsPopulares {
    return pokemons.where((p) => idsPopulares.contains(p.id)).toList();
  }
}
