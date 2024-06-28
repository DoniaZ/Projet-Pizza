// ignore_for_file: library_private_types_in_public_api, unused_element

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import '../providers/pizza_provider.dart';
import '../providers/user_provider.dart';
import '../models/pizza.dart';

class MasterScreen extends StatefulWidget {
  const MasterScreen({super.key});

  @override
  _MasterScreenState createState() => _MasterScreenState();
}

class _MasterScreenState extends State<MasterScreen> {
  final TextEditingController _searchController = TextEditingController();
  List<Pizza> _searchResults = [];

  @override
  void initState() {
    super.initState();
    _searchResults = Provider.of<PizzaProvider>(context, listen: false).pizzas;
  }

  void _searchPizza() {
    final provider = Provider.of<PizzaProvider>(context, listen: false);
    final results = provider.searchPizzaByName(_searchController.text);
    setState(() {
      _searchResults = results;
    });
  }

 

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Liste des Pizzas'),
        actions: [
          IconButton(
            icon: const Icon(Icons.add),
            onPressed: () {
              context.go('/custom-pizza');
            },
            tooltip: 'Composer ta pizza',
          ),
          IconButton(
            icon: const Icon(Icons.shopping_cart),
            onPressed: () {
              context.go('/cart');
            },
          ),
          IconButton(
            icon: const Icon(Icons.logout),
            onPressed: () {
              Provider.of<UserProvider>(context, listen: false).signOut();
              context.go('/login');
            },
          ),
        ],
      ),
      body: FutureBuilder(
        future:
            Provider.of<PizzaProvider>(context, listen: false).fetchPizzas(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else {
            return Consumer<PizzaProvider>(
              builder: (context, pizzaProvider, child) {
                return Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: TextField(
                        controller: _searchController,
                        decoration: InputDecoration(
                          hintText: 'Rechercher une pizza',
                          prefixIcon: const Icon(Icons.search),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(30.0),
                            borderSide: BorderSide.none,
                          ),
                          filled: true,
                          fillColor: Colors.grey[200],
                        ),
                        onChanged: (value) {
                          _searchPizza();
                        },
                      ),
                    ),
                    Expanded(
                      child: ListView.builder(
                        itemCount: _searchResults.length,
                        itemBuilder: (context, index) {
                          final pizza = _searchResults[index];
                          return ListTile(
                            title: Text(pizza.name),
                            subtitle: Text(
                                'Ingrédients: ${pizza.ingredients.join(', ')}'),
                            onTap: () {
                              context.go('/details', extra: pizza);
                            },
                          );
                        },
                      ),
                    ),
                  ],
                );
              },
            );
          }
        },
      ),
    );
  }
}
