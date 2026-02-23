import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:pokemon_app/models/pokemon_response_model.dart';
import 'package:pokemon_app/providers/favorites_provider.dart';
import 'package:pokemon_app/providers/pokemon_provider.dart';
import 'package:pokemon_app/widget/type_tag_widget.dart';
import 'package:provider/provider.dart';

class PokedexScreen extends StatelessWidget {
  const PokedexScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final pokemonProvider = Provider.of<PokemonProvider>(context);

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.redAccent,
        elevation: 4,
        title: const Text(
          "Pokédex",
          style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white),
        ),
        centerTitle: true,
      ),

      //Fotter con la navegación
      bottomNavigationBar: NavigationBar(
        backgroundColor: Colors.red[400],
        selectedIndex: 0,
        onDestinationSelected: (index) {
          if (index == 0) context.push('/home');
          if (index == 1) context.push('/pokedex');
          if (index == 2) context.go('/favorites');
        },
        destinations: const [
          NavigationDestination(icon: Icon(Icons.home), label: "Home"),
          NavigationDestination(icon: Icon(Icons.list), label: "Pokedex"),
          NavigationDestination(icon: Icon(Icons.favorite), label: "Favorites"),
        ],
      ),

      body: Column(
        children: [
          const SizedBox(height: 10),

          _PokedexSearchBar(), //Buscador

          const SizedBox(height: 10),

          Expanded(
            child: _PokedexList(pokemons: pokemonProvider.pokemonFiltrados),
          ),
        ],
      ),
    );
  }
}

class _PokedexSearchBar extends StatefulWidget {
  @override
  State<_PokedexSearchBar> createState() => _PokedexSearchBarState();
}

class _PokedexSearchBarState extends State<_PokedexSearchBar> {
  String query = "";

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<PokemonProvider>(context, listen: false);

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: TextField(
        onChanged: (value) {
          //Como hemos puesto un onchange cada vez que cambie se actualiza
          setState(() => query = value);
          provider.filterPokemons(
            value,
          ); //Aqui solo actualizamos en el provider
        },
        decoration: InputDecoration(
          hintText: "Buscar Pokémon...",
          prefixIcon: const Icon(Icons.search),
          filled: true,
          fillColor: Colors.grey.shade200,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(14),
            borderSide: BorderSide.none,
          ),
        ),
      ),
    );
  }
}

class _PokedexList extends StatelessWidget {
  final List<Pokemon> pokemons;

  const _PokedexList({required this.pokemons});

  @override
  Widget build(BuildContext context) {
    final favProvider = Provider.of<FavoritesProvider>(context);

    return ListView.builder(
      itemCount: pokemons.length,
      itemBuilder: (_, i) {
        final p = pokemons[i];

        return GestureDetector(
          onTap: () => context.push('/pokemon', extra: p),
          child: Container(
            margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            padding: const EdgeInsets.all(12),
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
                Image.network(p.image, width: 70, height: 70),

                const SizedBox(width: 12),

                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        p.name,
                        style: const TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),

                      const SizedBox(height: 4),

                      Row(children: p.types.map((t) => typeTag(t)).toList()),
                    ],
                  ),
                ),

                const SizedBox(width: 8),

                Text(
                  "#${p.id.toString().padLeft(3, '0')}",
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Colors.black54,
                  ),
                ),

                const SizedBox(width: 12),

                GestureDetector(
                  behavior:
                      HitTestBehavior.opaque, // evita que el tap pase a la card
                  onTap: () {
                    favProvider.toggleFavorite(p.id);
                  },
                  child: Icon(
                    favProvider.isFavorite(p.id)
                        ? Icons.favorite
                        : Icons.favorite_border,
                    color: favProvider.isFavorite(p.id)
                        ? Colors.redAccent
                        : Colors.grey,
                    size: 28,
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
