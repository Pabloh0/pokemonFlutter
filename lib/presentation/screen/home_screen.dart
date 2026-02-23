import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:pokemon_app/models/pokemon_response_model.dart';
import 'package:pokemon_app/providers/favorites_provider.dart';
import 'package:pokemon_app/providers/pokemon_provider.dart';
import 'package:pokemon_app/widget/pokemon_card_widget.dart';
import 'package:pokemon_app/widget/type_tag_widget.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final pokemonProvider = Provider.of<PokemonProvider>(context);

    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        elevation: 12,
        backgroundColor: Colors.redAccent,
        title: Text(
          "¡Buenos días entrenador!",
          style: TextStyle(
            fontSize: 22,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
      ),
      bottomNavigationBar: NavigationBar(
        backgroundColor: Colors.red[400],
        selectedIndex: 0,
        onDestinationSelected: (index) {
          if (index == 0) context.push('/home');
          if (index == 1) context.push('/pokedex');
          if (index == 2) context.push('/favorites');
        },
        destinations: const [
          NavigationDestination(icon: Icon(Icons.home), label: "Home"),
          NavigationDestination(icon: Icon(Icons.list), label: "Pokedex"),
          NavigationDestination(icon: Icon(Icons.favorite), label: "Favorites"),
        ],
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: ListView(
            children: [
              //
              const SizedBox(height: 20),

              _PokemonOfDayCard(pokemon: pokemonProvider.pokemonDelDia),
              const SizedBox(height: 20),

              Text(
                'Más populares',
                style: TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.w900,
                  color: Colors.black87,
                  letterSpacing: 1.2,
                ),
              ),
              SizedBox(height: 10),
              SizedBox(
                height: 200,
                child: ListView.separated(
                  scrollDirection: Axis.horizontal,
                  itemCount: pokemonProvider.pokemonsPopulares.length,
                  separatorBuilder: (_, __) => const SizedBox(width: 12),
                  itemBuilder: (context, i) {
                    Pokemon p = pokemonProvider.pokemonsPopulares[i];
                    return PokemonCard(pokemon: p);
                  },
                ),
              ),

              const SizedBox(height: 20),

              Text(
                "Noticias Pokémon",
                style: TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.w900,
                  letterSpacing: 1.2,
                ),
              ),

              const SizedBox(height: 10),

              PokemonNewsSection(),
            ],
          ),
        ),
      ),
    );
  }
}

class _PokemonOfDayCard extends StatelessWidget {
  final Pokemon? pokemon;

  const _PokemonOfDayCard({required this.pokemon});

  @override
  Widget build(BuildContext context) {
    if (pokemon == null) {
      return Container(
        height: 185,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [Colors.orange.shade100, Colors.orange.shade300],
          ),
          borderRadius: BorderRadius.circular(20),
        ),
        child: const Center(child: CircularProgressIndicator()),
      );
    }

    return GestureDetector(
      onTap: () {
        context.push('/pokemon', extra: pokemon);
      },
      child: Container(
        height: 200,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [Colors.orange.shade200, Colors.orange.shade400],
          ),
          borderRadius: BorderRadius.circular(20),
        ),
        padding: const EdgeInsets.all(16),
        child: Row(
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "Pokémon del día",
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w900,
                      color: Colors.white.withOpacity(0.9),
                      letterSpacing: 1.2,
                    ),
                  ),
                  const SizedBox(height: 8),

                  Text(
                    pokemon!.name,
                    style: const TextStyle(
                      fontSize: 26,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                  Text(
                    "#${pokemon!.id.toString().padLeft(3, '0')}",
                    style: const TextStyle(color: Colors.white70),
                  ),
                  const SizedBox(height: 10),

                  Row(children: pokemon!.types.map((t) => typeTag(t)).toList()),
                ],
              ),
            ),
            Image.network(pokemon!.image, width: 120, height: 120),
          ],
        ),
      ),
    );
  }
}
