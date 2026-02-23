import 'package:flutter/material.dart';
import 'package:pokemon_app/router/app_router.dart';
import 'package:pokemon_app/providers/pokemon_provider.dart';
import 'package:pokemon_app/providers/favorites_provider.dart';
import 'package:provider/provider.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized(); //Esto lo necesito para avisarle que tiene que leer de disco

  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => PokemonProvider()),
        ChangeNotifierProvider(create: (_) => FavoritesProvider()),
      ],
      child: const MainApp(),
    ),
  );
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      routerConfig: appRouter,
      debugShowCheckedModeBanner: false,
    );
  }
}
