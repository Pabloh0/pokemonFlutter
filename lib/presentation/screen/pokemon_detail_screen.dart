import 'package:flutter/material.dart';
import 'package:pokemon_app/models/pokemon_response_model.dart';
import 'package:pokemon_app/widget/type_tag_widget.dart';

class PokemonDetailScreen extends StatelessWidget {
  final Pokemon pokemon;

  const PokemonDetailScreen({super.key, required this.pokemon});

  @override
  Widget build(BuildContext context) {
    final PokemonType mainType = pokemon.types.first; //Cogemos el primer tipo
    return Scaffold(
      backgroundColor: (typeColors[mainType] ?? Colors.grey).withOpacity(
        0.8,
      ), //Segun el primer tipo le damos color con el mapper

      appBar: AppBar(
        backgroundColor: (typeColors[mainType] ?? Colors.grey),
        elevation: 0,
        title: Text(
          pokemon.name,
          style: const TextStyle(
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
        centerTitle: true,
      ),

      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Center(child: Image.network(pokemon.image, height: 180)),

            const SizedBox(height: 20),

            Text(
              "#${pokemon.id.toString().padLeft(3, '0')}", //Formater para la id
              style: const TextStyle(fontSize: 20, color: Colors.white),
            ),

            const SizedBox(height: 8),

            Text(
              pokemon.name,
              style: const TextStyle(
                fontSize: 32,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),

            const SizedBox(height: 10),

            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: pokemon.types.map((t) => typeTag(t)).toList(),
            ),

            const SizedBox(height: 25),

            Text(
              pokemon.description,
              textAlign: TextAlign.center,
              style: const TextStyle(
                fontSize: 16,
                height: 1.4,
                color: Colors.white,
              ),
            ),

            const SizedBox(height: 35),

            Align(
              alignment: Alignment.centerLeft,
              child: Text(
                "Stats Base",
                style: TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
            ),

            const SizedBox(height: 12),

            _StatBar(label: "HP", value: pokemon.stats.hp, color: Colors.green),
            _StatBar(
              label: "ATK",
              value: pokemon.stats.attack,
              color: Colors.red,
            ),
            _StatBar(
              label: "DEF",
              value: pokemon.stats.defense,
              color: Colors.blue,
            ),
            _StatBar(
              label: "SpA",
              value: pokemon.stats.spAttack,
              color: Colors.orange,
            ),
            _StatBar(
              label: "SpD",
              value: pokemon.stats.spDefense,
              color: Colors.teal,
            ),
            _StatBar(
              label: "SPD",
              value: pokemon.stats.speed,
              color: Colors.purple,
            ),

            const SizedBox(height: 40),

            if (pokemon.evolutionLine.isNotEmpty)
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Línea evolutiva",
                    style: TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                  const SizedBox(height: 12),

                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: pokemon.evolutionLine.map((id) {
                      return Container(
                        margin: const EdgeInsets.symmetric(horizontal: 8),
                        padding: const EdgeInsets.all(10),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(14),
                          boxShadow: [
                            BoxShadow(color: Colors.black12, blurRadius: 4),
                          ],
                        ),
                        child: Text(
                          "#${id.toString().padLeft(3, '0')}",
                          style: const TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 16,
                          ),
                        ),
                      );
                    }).toList(),
                  ),
                ],
              ),
          ],
        ),
      ),
    );
  }
}

class _StatBar extends StatelessWidget {
  final String label;
  final int value;
  final Color color;

  const _StatBar({
    required this.label,
    required this.value,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    final maxWidth = MediaQuery.of(context).size.width * 0.6;

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6),
      child: Row(
        children: [
          SizedBox(
            width: 50,
            child: Text(
              label,
              style: const TextStyle(fontWeight: FontWeight.bold),
            ),
          ),

          Expanded(
            child: Stack(
              children: [
                Container(
                  height: 10,
                  decoration: BoxDecoration(
                    color: Colors.grey.shade300,
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),

                Container(
                  height: 10,
                  width:
                      (value / 150) *
                      maxWidth, //Calculo para adaptar la barra segun las estadisticas
                  decoration: BoxDecoration(
                    color: color,
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
              ],
            ),
          ),

          const SizedBox(width: 10),

          Text(value.toString()),
        ],
      ),
    );
  }
}
