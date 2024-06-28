import 'package:flutter/material.dart';
import '../models/pizza.dart';

class CartProvider with ChangeNotifier {
  final List<Pizza> _cartItems = [];

  List<Pizza> get cartItems => _cartItems;

  void addToCart(Pizza pizza) {
    _cartItems.add(pizza);
    notifyListeners();
  }

  void removeFromCart(Pizza pizza) {
    _cartItems.remove(pizza);
    notifyListeners();
  }

  double get totalAmount {
    return _cartItems.fold(0, (sum, item) => sum + item.price);
  }
}
