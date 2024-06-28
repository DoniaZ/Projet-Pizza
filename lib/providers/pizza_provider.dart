import 'package:flutter/material.dart';
import '../models/pizza.dart';
import '../services/api_services.dart';

class PizzaProvider with ChangeNotifier {
  
    List<Pizza> _pizzas = [
      /*
    Pizza(
      id: '1',
      name: 'Margherita',
      price: 8.5,
      ingredients: ['Tomate', 'Mozzarella'],
      base: 'Tomate',
      image: 'assets/images/margherita.png',
      category: 'Classique',
    ),
    Pizza(
      id: '2',
      name: 'Pepperoni',
      price: 9.5,
      ingredients: ['Tomate', 'Mozzarella', 'Pepperoni'],
      base: 'Tomate',
      image: 'assets/images/pepperoni.png',
      category: 'Classique',
    ),
    
    */
  ];
     

  final ApiService _apiService = ApiService();

  List<Pizza> get pizzas => _pizzas;
  
  List<Pizza> searchPizzaByName(String name) {
    return _pizzas.where((pizza) => pizza.name.toLowerCase().contains(name.toLowerCase())).toList();
  }

  Future<void> fetchPizzas() async {
    _pizzas = await _apiService.getPizzas();
    notifyListeners();
  }

}
