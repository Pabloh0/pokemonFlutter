// To parse this JSON data, do
//
//     final movesResponse = movesResponseFromJson(jsonString);

import 'dart:convert';

MovesResponse movesResponseFromJson(String str) =>
    MovesResponse.fromJson(json.decode(str));

String movesResponseToJson(MovesResponse data) => json.encode(data.toJson());

class MovesResponse {
  String status;
  List<Move> moves;

  MovesResponse({required this.status, required this.moves});

  factory MovesResponse.fromJson(Map<String, dynamic> json) => MovesResponse(
    status: json["status"],
    moves: List<Move>.from(json["data"].map((x) => Move.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "status": status,
    "data": List<dynamic>.from(moves.map((x) => x.toJson())),
  };
}

class Move {
  int id;
  int accuracy;
  DamageClass damageClass;
  int introducedInGen;
  int? pp;
  String name;
  String description;
  int power;
  MoveType type;

  Move({
    required this.id,
    required this.accuracy,
    required this.damageClass,
    required this.introducedInGen,
    required this.pp,
    required this.name,
    required this.description,
    required this.power,
    required this.type,
  });

  factory Move.fromJson(Map<String, dynamic> json) => Move(
    id: json["id"],
    accuracy: json["accuracy"],
    damageClass: damageClassValues.map[json["damage_class"]]!,
    introducedInGen: json["introduced_in_gen"],
    pp: json["pp"],
    name: json["name"],
    description: json["description"],
    power: json["power"],
    type: moveTypeValues.map[json["type"]]!,
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "accuracy": accuracy,
    "damage_class": damageClassValues.reverse[damageClass],
    "introduced_in_gen": introducedInGen,
    "pp": pp,
    "name": name,
    "description": description,
    "power": power,
    "type": moveTypeValues.reverse[type],
  };
}

enum DamageClass { ESPECIAL, ESTADO, FSICO }

final damageClassValues = EnumValues({
  "Especial": DamageClass.ESPECIAL,
  "Estado": DamageClass.ESTADO,
  "Físico": DamageClass.FSICO,
});

enum MoveType {
  ACERO,
  AGUA,
  BICHO,
  DRAGN,
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
  SHADOW,
  SINIESTRO,
  TIERRA,
  VENENO,
  VOLADOR,
}

final moveTypeValues = EnumValues<MoveType>({
  "Acero": MoveType.ACERO,
  "Agua": MoveType.AGUA,
  "Bicho": MoveType.BICHO,
  "Dragón": MoveType.DRAGN,
  "Eléctrico": MoveType.ELCTRICO,
  "Fantasma": MoveType.FANTASMA,
  "Fuego": MoveType.FUEGO,
  "Hada": MoveType.HADA,
  "Hielo": MoveType.HIELO,
  "Lucha": MoveType.LUCHA,
  "Normal": MoveType.NORMAL,
  "Planta": MoveType.PLANTA,
  "Psíquico": MoveType.PSQUICO,
  "Roca": MoveType.ROCA,
  "shadow": MoveType.SHADOW,
  "Siniestro": MoveType.SINIESTRO,
  "Tierra": MoveType.TIERRA,
  "Veneno": MoveType.VENENO,
  "Volador": MoveType.VOLADOR,
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
