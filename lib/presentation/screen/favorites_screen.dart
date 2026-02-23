import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:pokemon_app/widget/pokemon_card_widget.dart';
import 'package:provider/provider.dart';
import 'package:pokemon_app/providers/favorites_provider.dart';
import 'package:pokemon_app/providers/pokemon_provider.dart';

class FavoritesScreen extends StatelessWidget {
  const FavoritesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final favProvider = Provider.of<FavoritesProvider>(context);
    final pokemonProvider = Provider.of<PokemonProvider>(context);

    final favoritePokemons = pokemonProvider.pokemons
        .where((p) => favProvider.favoriteIds.contains(p.id))
        .toList();
        //le pasamos la lista de favoritos entera y la filtramos con el metodo del provider 

    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text("Favoritos", style: TextStyle(color: Colors.white)),
        backgroundColor: Colors.redAccent,
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

      body: favoritePokemons.isEmpty
          ? const Center(
              child: Text(
                "No tienes Pokémon favoritos aún",
                style: TextStyle(fontSize: 18, color: Colors.grey),
              ),
            )
          : GridView.builder(
              padding: const EdgeInsets.all(12),
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                mainAxisSpacing: 16,
                crossAxisSpacing: 16,
                childAspectRatio: 0.9,
              ),
              itemCount: favoritePokemons.length,
              itemBuilder: (context, index) {
                final pokemon = favoritePokemons[index];
                return PokemonCard(pokemon: pokemon);
              },
            ),
    );
  }
}
