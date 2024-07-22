import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';

class CartProvider extends ChangeNotifier {
  final _cartBox = Hive.box('cart_box');
  List<dynamic> _cart = [];

  List<dynamic> get cart => _cart;

  set cart(List<dynamic> newCart) {
    _cart = newCart;
    notifyListeners();
  }

  getCart() {
    final cartData = _cartBox.keys.map((key) {
      final item = _cartBox.get(key);
      return {
        "key": key,
        "id": item['id'],
        "name": item['name'],
        "price": item['price'],
        "qty": item['qty'],
        "category": item['category'],
        "imageUrl": item['imageUrl'],
        "sizes": item['sizes']
      };
    }).toList();
    _cart = cartData.reversed.toList();
  }

  Future<void> deleteCart(int key) async {
    await _cartBox.delete(key);
  }

  Future<void> createCart(Map<dynamic, dynamic> newCart) async {
    await _cartBox.add(newCart);
  }


  void increment(int key) {
    final item = _cartBox.get(key);
    item['qty'] += 1;
    _cartBox.put(key, item);
    notifyListeners();
  }

  void decrement(int key) {
    final item = _cartBox.get(key);
    if (item['qty'] > 1) {
      item['qty'] -= 1;
      _cartBox.put(key, item);
      notifyListeners();
    }
  }
}

