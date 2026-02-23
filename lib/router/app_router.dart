import 'package:go_router/go_router.dart';
import 'package:pokemon_app/models/pokemon_response_model.dart';
import 'package:pokemon_app/presentation/screen/favorites_screen.dart';
import 'package:pokemon_app/presentation/screen/home_screen.dart';
import 'package:pokemon_app/presentation/screen/login_screen.dart';
import 'package:pokemon_app/presentation/screen/pokedex_screen.dart';
import 'package:pokemon_app/presentation/screen/pokemon_detail_screen.dart';
import 'package:pokemon_app/presentation/screen/seleccion_screen.dart';

final appRouter = GoRouter(
  initialLocation: '/',
  routes: [
    GoRoute(path: '/', builder: (context, state) => const SeleccionScreen()),
    GoRoute(path: '/login', builder: (context, state) => LoginScreen()),
    GoRoute(path: '/home', builder: (context, state) => HomeScreen()),
    GoRoute(path: '/pokedex', builder: (context, state) => PokedexScreen()),
    GoRoute(path: '/favorites', builder: (context, state) => FavoritesScreen()),
    GoRoute(
      path: '/pokemon',
      builder: (context, state) {
        final pokemon = state.extra as Pokemon;
        return PokemonDetailScreen(pokemon: pokemon);
      },
    ),
  ],
);
