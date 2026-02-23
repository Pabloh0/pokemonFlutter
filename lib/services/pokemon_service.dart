import 'dart:convert';

import 'package:http/http.dart';
import 'package:pokemon_app/models/admin_response_model.dart';
import 'package:pokemon_app/models/moves_response_model.dart';
import 'package:pokemon_app/models/pokemon_response_model.dart';

class PokemonService {
  final _pointAdmins =
      'https://pokemonbackend-9y1j.onrender.com/api/v1/pokedex/admins';
  final _pointPokemons =
      'https://pokemonbackend-9y1j.onrender.com/api/v1/pokedex/pokemons';
  final _pointMoves =
      'https://pokemonbackend-9y1j.onrender.com/api/v1/pokedex/moves';
  final _apiKey = '3f5b8a2c-9d1e-4b7a-bc6d-123456789abc';

  Future<List<Admin>> getAdmins() async {
    List<Admin> admins = [];
    Uri uri = Uri.parse(_pointAdmins);
    Response response = await get(
      uri,
      headers: {
        'api-key': '3f5b8a2c-9d1e-4b7a-bc6d-123456789abc',
        'Content-Type': 'application/json',
      },
    );
    print('aaaaaaaaaaaaaaaaaaaaaaaaaa');
    if (response.statusCode != 200) return admins;
    final adminResponse = adminResponseFromJson(response.body);
    print('aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa');
    print(adminResponse.admins);
    return adminResponse.admins;
  }

  Future<List<Pokemon>> getPokemons() async {
    List<Pokemon> pokemons = [];
    Uri uri = Uri.parse(_pointPokemons);
    Response response = await get(uri);
    print('aaaaaaaaaaaaaaaaaaaaaaaaaa');
    if (response.statusCode != 200) return pokemons;
    final pokemonResponse = pokemonResponseFromJson(response.body);
    print('aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa');
    print(pokemonResponse.pokemons);
    return pokemonResponse.pokemons;
  }

  //Este al final no lo uso
  // Future<List<Move>> getMoves() async {
  //   List<Move> moves = [];
  //   Uri uri = Uri.parse(_pointMoves);
  //   Response response = await get(uri);
  //   print('aaaaaaaaaaaaaaaaaaaaaaaaaa');
  //   if (response.statusCode != 200) return moves;
  //   final moveResponse = movesResponseFromJson(response.body);
  //   print('aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa');
  //   print(moveResponse.moves);
  //   return moveResponse.moves;
  // }

  Future<Pokemon> getPokemon(int id) async {
    Uri uri = Uri.parse('$_pointPokemons/$id');
    Response response = await get(uri);

    final decoded = json.decode(response.body);

    final pokemonMap = decoded["data"];

    final pokemon = Pokemon.fromJson(pokemonMap);

    return pokemon;
  }
}
