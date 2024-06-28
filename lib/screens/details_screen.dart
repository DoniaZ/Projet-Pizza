import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import '../providers/cart_provider.dart';
import '../models/pizza.dart';

class DetailsScreen extends StatelessWidget {
  const DetailsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final Pizza pizza = GoRouterState.of(context).extra as Pizza;

    return Scaffold(
      appBar: AppBar(
        title: Text(pizza.name),
      ),
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Image.network(
              'https://pizzas.shrp.dev/assets/${pizza.image}',
              width: 200,
              height: 200,
            ),
            const SizedBox(height: 10),
            Text(
              pizza.name,
              style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            Text('Ingrédients: ${pizza.ingredients.join(', ')}'),
            const SizedBox(height: 8),
            Text('Base: ${pizza.base}'),
            const SizedBox(height: 8),
            Text('Tarif: ${pizza.price} €'),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: () {
                Provider.of<CartProvider>(context, listen: false)
                    .addToCart(pizza);
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('Pizza ajoutée au panier!')),
                );
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFF93C572),
                foregroundColor: Colors.white,
              ),
              child: const Text('Ajouter au panier'),
            ),
          ],
        ),
      ),
    );
  }
}
