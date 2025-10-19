import 'package:shared_preferences/shared_preferences.dart';

class FavoritesManager {
  static const String _favoritesKey = 'favorite_combo_ids';

  static Future<Set<String>> getFavorites() async {
    final prefs = await SharedPreferences.getInstance();
    final favorites = prefs.getStringList(_favoritesKey) ?? [];
    return favorites.toSet();
  }

  static Future<void> addFavorite(String comboId) async {
    final prefs = await SharedPreferences.getInstance();
    final favorites = prefs.getStringList(_favoritesKey) ?? [];
    if (!favorites.contains(comboId)) {
      favorites.add(comboId);
      await prefs.setStringList(_favoritesKey, favorites);
    }
  }

  static Future<void> removeFavorite(String comboId) async {
    final prefs = await SharedPreferences.getInstance();
    final favorites = prefs.getStringList(_favoritesKey) ?? [];
    favorites.remove(comboId);
    await prefs.setStringList(_favoritesKey, favorites);
  }

  static Future<bool> isFavorite(String comboId) async {
    final favorites = await getFavorites();
    return favorites.contains(comboId);
  }

  static Future<void> toggleFavorite(String comboId) async {
    final isFav = await isFavorite(comboId);
    if (isFav) {
      await removeFavorite(comboId);
    } else {
      await addFavorite(comboId);
    }
  }
}
