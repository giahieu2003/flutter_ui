import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';

class FavoritesNotifier extends ChangeNotifier {
  final _favBox = Hive.box('fav_box');
  List _ids = [];
  List _favorites = [];
  List _fav = [];

  List get ids => _ids;

  set ids(List newIds) {
    _ids = newIds;
    notifyListeners();
  }


   List get favorites => _favorites;

  set favorites(List newFav) {
    _favorites = newFav;
    notifyListeners();
  }

  List get fav => _fav;

  set fav(List newFav) {
    _fav = newFav;
    notifyListeners();
  }

    getFavorites() {
    final favData = _favBox.keys.map((key) {
      final item = _favBox.get(key);
      return {
        "key" : key,
        "id" : item['id'],
      };
    }).toList();

    _favorites = favData.toList();
    _ids = _favorites.map((item) => item['id']).toList();
  }

  getAllData(){
    final favData = _favBox.keys.map((key){
      final item = _favBox.get(key);
      return {
        "key" : key,
        "id" : item['id'],
        "name" : item['name'],
        "category" : item['category'],
        "imageUrl" : item['imageUrl'],
        "price" : item['price']
      };
    }).toList();
    _fav = favData.reversed.toList();
  }

  Future<void> deleteFav(int key) async{
    await  _favBox.delete(key);
  }

  Future<void> createFav(Map<String, dynamic> addFav) async {
    await _favBox.add(addFav);
    
  }
}