import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class OrderProvider with ChangeNotifier {
  List<Order> _orders = [];

  List<Order> get orders => _orders;

  Future<void> fetchOrders(String userId) async {
    final url = Uri.parse('https://pizzas.shrp.dev/orders?userId=$userId');
    final response = await http.get(url);

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body) as List;
      _orders = data.map((order) => Order.fromJson(order)).toList();
      notifyListeners();
    } else {
      throw Exception('Failed to load orders');
    }
  }

  void createCustomPizza(List<String> selectedIngredients) {}
}

class Order {
  final String id;
  final String status;
  final List<String> pizzas;

  Order({required this.id, required this.status, required this.pizzas});

  factory Order.fromJson(Map<String, dynamic> json) {
    return Order(
      id: json['id'],
      status: json['status'],
      pizzas: List<String>.from(json['pizzas']),
    );
  }
}
