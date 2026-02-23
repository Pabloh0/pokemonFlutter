import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:go_router/go_router.dart';
import 'package:pokemon_app/models/pokemon_response_model.dart';
import 'package:pokemon_app/providers/favorites_provider.dart';
import 'package:pokemon_app/widget/type_tag_widget.dart';
import 'package:provider/provider.dart';

class PokemonCard extends StatefulWidget {
  final Pokemon pokemon;

  const PokemonCard({required this.pokemon});

  @override
  State<PokemonCard> createState() => PokemonCardState();
}

class PokemonCardState extends State<PokemonCard>
    with SingleTickerProviderStateMixin {
  bool _pressed = false;

  @override
  Widget build(BuildContext context) {
    final PokemonType mainType =
        widget.pokemon.types.first; //Miramos el primer tipo del pokemon
    final favProvider = Provider.of<FavoritesProvider>(context);

    return GestureDetector(
      onTap: () {
        context.push('/pokemon', extra: widget.pokemon);
      },

      onTapDown: (_) => setState(() => _pressed = true),
      onTapUp: (_) => setState(() => _pressed = false),
      onTapCancel: () => setState(() => _pressed = false),

      child: AnimatedScale(
        scale: _pressed ? 0.95 : 1.0,
        duration: const Duration(milliseconds: 120),
        curve: Curves.easeOut,
        child: Stack(
          children: [
            Container(
              width: 175,
              height: 190,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                border: Border.all(color: Colors.white, width: 4),
                gradient: LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: [
                    (typeColors[mainType] ?? Colors.grey).withOpacity(
                      0.7,
                    ), //Como hemos sacado el tipo principal del pokemon en una variable la podemos usar para darle color a la card
                    typeColors[mainType] ?? Colors.grey,
                  ],
                ),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black26,
                    blurRadius: 6,
                    offset: Offset(2, 3),
                  ),
                ],
              ),
              padding: const EdgeInsets.all(12),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "#${widget.pokemon.id.toString().padLeft(3, '0')}", //Esto es un format que he usado para que si es el num 1 de la pokedex salga 001
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Colors.white70,
                    ),
                  ),

                  const SizedBox(height: 4),

                  Text(
                    widget.pokemon.name,
                    style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),

                  const SizedBox(height: 6),

                  Row(
                    children: widget.pokemon.types
                        .map((t) => typeTag(t))
                        .toList(), //Separamos los tipos para crear tarjetas individuales
                  ),

                  Center(
                    child: Image.network(
                      widget.pokemon.image,
                      height: 70,
                      fit: BoxFit.contain,
                    ),
                  ),
                ],
              ),
            ),

            Positioned(
              right: 8,
              top: 8,
              child: GestureDetector(
                behavior:
                    HitTestBehavior.opaque, // evita que el tap pase a la card
                onTap: () {
                  final favProvider = Provider.of<FavoritesProvider>(
                    context,
                    listen: false,
                  );
                  favProvider.toggleFavorite(widget.pokemon.id);
                },
                child: Icon(
                  favProvider.isFavorite(widget.pokemon.id)
                      ? Icons.favorite
                      : Icons.favorite_border,
                  color: favProvider.isFavorite(widget.pokemon.id)
                      ? Colors.redAccent
                      : Colors.white,
                  size: 28,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class PokemonNewsSection extends StatelessWidget {
  //Noticias
  final List<Map<String, String>> noticias = const [
    {
      "title": "Nuevo evento en la región de Kanto",
      "subtitle":
          "Entrenadores reportan un aumento de Pikachu salvajes cerca del Bosque Verde.",
    },
    {
      "title": "Descubrimiento misterioso",
      "subtitle":
          "Un investigador afirma haber visto un Pokémon nunca antes registrado.",
    },
    {
      "title": "Competencia de entrenadores",
      "subtitle":
          "El torneo anual de Ciudad Azafrán abre inscripciones esta semana.",
    },
  ];

  const PokemonNewsSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: noticias.map((news) {
        return Container(
          margin: const EdgeInsets.only(bottom: 12),
          padding: const EdgeInsets.all(14),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(16),
            boxShadow: [
              BoxShadow(
                color: Colors.black12,
                blurRadius: 6,
                offset: Offset(2, 3),
              ),
            ],
          ),
          child: Row(
            children: [
              Container(
                width: 50,
                height: 50,
                decoration: BoxDecoration(
                  color: Colors.redAccent,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: const Icon(Icons.newspaper, color: Colors.white),
              ),

              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      news["title"]!,
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      news["subtitle"]!,
                      style: TextStyle(fontSize: 14, color: Colors.grey[700]),
                    ),
                  ],
                ),
              ),
            ],
          ),
        );
      }).toList(),
    );
  }
}
