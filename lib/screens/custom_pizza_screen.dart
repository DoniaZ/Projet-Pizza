// ignore_for_file: library_private_types_in_public_api, prefer_const_constructors, use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:pizzas/services/api_services.dart';
import 'package:provider/provider.dart';
import '../providers/order_provider.dart';

class CustomPizzaScreen extends StatefulWidget {
  const CustomPizzaScreen({super.key});

  @override
  _CustomPizzaScreenState createState() => _CustomPizzaScreenState();
}

class _CustomPizzaScreenState extends State<CustomPizzaScreen> {
  final List<String> _selectedIngredients = [];
  List<String> _availableIngredients = [];
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _fetchPizzas();
  }

  Future<void> _fetchPizzas() async {
    final apiService = ApiService();
    try {
      final pizzas = await apiService.getPizzas();
      final ingredients =
          pizzas.expand((pizza) => pizza.ingredients).toSet().toList();
      setState(() {
        _availableIngredients = ingredients;
        _isLoading = false;
      });
    } catch (e) {
      setState(() {
        _isLoading = false;
      });
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Failed to load ingredients')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Create Custom Pizza'),
      ),
      body: _isLoading
          ? Center(child: CircularProgressIndicator())
          : Column(
              children: [
                Expanded(
                  child: ListView.builder(
                    itemCount: _availableIngredients.length,
                    itemBuilder: (context, index) {
                      final ingredient = _availableIngredients[index];
                      final isSelected =
                          _selectedIngredients.contains(ingredient);
                      return ListTile(
                        title: Text(ingredient),
                        trailing: isSelected
                            ? Icon(Icons.check_box)
                            : Icon(Icons.check_box_outline_blank),
                        onTap: () {
                          setState(() {
                            if (isSelected) {
                              _selectedIngredients.remove(ingredient);
                            } else if (_selectedIngredients.length < 5) {
                              _selectedIngredients.add(ingredient);
                            } else {
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(
                                    content: Text(
                                        'You can select up to 5 ingredients')),
                              );
                            }
                          });
                        },
                      );
                    },
                  ),
                ),
                ElevatedButton(
                  onPressed: () {
                    if (_selectedIngredients.length == 5) {
                      Provider.of<OrderProvider>(context, listen: false)
                          .createCustomPizza(_selectedIngredients);
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content: Text('Custom Pizza Ordered for 14€')),
                      );
                    } else {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content: Text('Please select 5 ingredients')),
                      );
                    }
                  },
                  child: Text('Order Custom Pizza for 14€'),
                ),
              ],
            ),
    );
  }
}
