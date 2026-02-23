import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class FavoritesProvider with ChangeNotifier {
  List<int> favoriteIds = [];
  bool isLoading = true;

  FavoritesProvider() {
    loadFavorites();
  }

  Future<void> loadFavorites() async {
    isLoading = true;
    notifyListeners();

    final prefs = await SharedPreferences.getInstance();
    favoriteIds =
        prefs.getStringList('favorites')?.map(int.parse).toList() ??
        []; //Obtenemos la lista de favoritos guardada en disco

    isLoading = false;
    notifyListeners();
  }

  Future<void> toggleFavorite(int id) async {
    if (favoriteIds.contains(id)) {
      favoriteIds.remove(id);
    } else {
      favoriteIds.add(id);
    }

    final prefs = await SharedPreferences.getInstance();
    prefs.setStringList(
      'favorites',
      favoriteIds.map((e) => e.toString()).toList(),
    );

    notifyListeners();
  }

  bool isFavorite(int id) => favoriteIds.contains(
    id,
  ); //Este metodo me sirve para recorrer la lista de todos los pokemons y comprar si...
  //la id que tiene el pokemon esta en la lista de favs
}
