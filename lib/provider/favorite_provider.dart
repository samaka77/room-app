import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class FavoriteProvider extends ChangeNotifier {
  List<String> _favoriteIds = [];
  
  List<String> get favorites => _favoriteIds;

  FavoriteProvider() {
    loadFavorites();
  }

  // تحميل المفضلة عند بدء التطبيق
  Future<void> loadFavorites() async {
    final prefs = await SharedPreferences.getInstance();
    _favoriteIds = prefs.getStringList('favorite_places') ?? [];
    notifyListeners();
  }

  // تبديل حالة المفضلة
  void toggleFavorite(String placeId) async {
    if (_favoriteIds.contains(placeId)) {
      _favoriteIds.remove(placeId);
    } else {
      _favoriteIds.add(placeId);
    }
    await saveFavorites(); // حفظ القائمة بعد التعديل
    notifyListeners();
  }

  // حفظ المفضلة في SharedPreferences
  Future<void> saveFavorites() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setStringList('favorite_places', _favoriteIds);
  }

  // التحقق مما إذا كان العنصر موجودًا في المفضلة
  bool isExist(String placeId) {
    return _favoriteIds.contains(placeId);
  }
}
