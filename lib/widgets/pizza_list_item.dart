import 'package:flutter/material.dart';
import '../models/pizza.dart';

class PizzaListItem extends StatelessWidget {
  final Pizza pizza;
  final VoidCallback onTap;

  const PizzaListItem({super.key, required this.pizza, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(pizza.name),
      //subtitle: Text(pizza.),
      onTap: onTap,
    );
  }
}
