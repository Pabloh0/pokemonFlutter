// To parse this JSON data, do
//
//     final pokemonResponse = pokemonResponseFromJson(jsonString);

import 'dart:convert';

PokemonResponse pokemonResponseFromJson(String str) =>
    PokemonResponse.fromJson(json.decode(str));

String pokemonResponseToJson(PokemonResponse data) =>
    json.encode(data.toJson());

class PokemonResponse {
  String status;
  List<Pokemon> pokemons;

  PokemonResponse({required this.status, required this.pokemons});

  factory PokemonResponse.fromJson(Map<String, dynamic> json) =>
      PokemonResponse(
        status: json["status"],
        pokemons: List<Pokemon>.from(
          json["data"].map((x) => Pokemon.fromJson(x)),
        ),
      );

  Map<String, dynamic> toJson() => {
    "status": status,
    "data": List<dynamic>.from(pokemons.map((x) => x.toJson())),
  };
}

class Pokemon {
  String image;
  List<int> evolutionLine;
  List<PokemonType> types;
  Stats stats;
  String name;
  int id;
  int generation;
  String description;

  Pokemon({
    required this.image,
    required this.evolutionLine,
    required this.types,
    required this.stats,
    required this.name,
    required this.id,
    required this.generation,
    required this.description,
  });

  factory Pokemon.fromJson(Map<String, dynamic> json) => Pokemon(
    image: json["image"],
    evolutionLine: List<int>.from(json["evolution_line"].map((x) => x)),
    types: List<PokemonType>.from(
      json["types"].map((x) => pokemonTypeValues.map[x]!),
    ),
    stats: Stats.fromJson(json["stats"]),
    name: json["name"],
    id: json["id"],
    generation: json["generation"],
    description: json["description"],
  );

  Map<String, dynamic> toJson() => {
    "image": image,
    "evolution_line": List<dynamic>.from(evolutionLine.map((x) => x)),
    "types": List<dynamic>.from(types.map((x) => pokemonTypeValues.reverse[x])),
    "stats": stats.toJson(),
    "name": name,
    "id": id,
    "generation": generation,
    "description": description,
  };
}

class Stats {
  int speed;
  int defense;
  int spAttack;
  int attack;
  int hp;
  int spDefense;

  Stats({
    required this.speed,
    required this.defense,
    required this.spAttack,
    required this.attack,
    required this.hp,
    required this.spDefense,
  });

  factory Stats.fromJson(Map<String, dynamic> json) => Stats(
    speed: json["speed"],
    defense: json["defense"],
    spAttack: json["sp_attack"],
    attack: json["attack"],
    hp: json["hp"],
    spDefense: json["sp_defense"],
  );

  Map<String, dynamic> toJson() => {
    "speed": speed,
    "defense": defense,
    "sp_attack": spAttack,
    "attack": attack,
    "hp": hp,
    "sp_defense": spDefense,
  };
}

enum PokemonType {
  ACERO,
  AGUA,
  BICHO,
  DRAGN,
  DRAGON,
  ELCTRICO,
  FANTASMA,
  FUEGO,
  HADA,
  HIELO,
  LUCHA,
  NORMAL,
  PLANTA,
  PSQUICO,
  ROCA,
  SINIESTRO,
  TIERRA,
  TYPE_AGUA,
  VENENO,
  VOLADOR,
}

final pokemonTypeValues = EnumValues<PokemonType>({
  "Acero": PokemonType.ACERO,
  "Agua": PokemonType.AGUA,
  "Bicho": PokemonType.BICHO,
  "Dragón": PokemonType.DRAGN,
  "dragon": PokemonType.DRAGON,
  "Eléctrico": PokemonType.ELCTRICO,
  "Fantasma": PokemonType.FANTASMA,
  "Fuego": PokemonType.FUEGO,
  "Hada": PokemonType.HADA,
  "Hielo": PokemonType.HIELO,
  "Lucha": PokemonType.LUCHA,
  "Normal": PokemonType.NORMAL,
  "Planta": PokemonType.PLANTA,
  "Psíquico": PokemonType.PSQUICO,
  "Roca": PokemonType.ROCA,
  "Siniestro": PokemonType.SINIESTRO,
  "Tierra": PokemonType.TIERRA,
  "agua": PokemonType.TYPE_AGUA,
  "Veneno": PokemonType.VENENO,
  "Volador": PokemonType.VOLADOR,
});

class EnumValues<T> {
  Map<String, T> map;
  late Map<T, String> reverseMap;

  EnumValues(this.map);

  Map<T, String> get reverse {
    reverseMap = map.map((k, v) => MapEntry(v, k));
    return reverseMap;
  }
}
