// ignore_for_file: library_private_types_in_public_api, unused_local_variable

import 'package:flutter/material.dart';

class OrderScreen extends StatefulWidget {
  const OrderScreen({super.key});

  @override
  _OrderScreenState createState() => _OrderScreenState();
}

class _OrderScreenState extends State<OrderScreen> {
  String _selectedMode = 'sur place';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Passer une commande'),
      ),
      body: Column(
        children: [
          ListTile(
            title: const Text('Sur place'),
            leading: Radio(
              value: 'sur place',
              groupValue: _selectedMode,
              onChanged: (value) {
                setState(() {
                  _selectedMode = value!;
                });
              },
            ),
          ),
          ListTile(
            title: const Text('Livrée à domicile'),
            leading: Radio(
              value: 'livrée à domicile',
              groupValue: _selectedMode,
              onChanged: (value) {
                setState(() {
                  _selectedMode = value!;
                });
              },
            ),
          ),
          Center(
            child: ElevatedButton(
              onPressed: () {
                final orderlines = [
                  {"pizza_id": "1", "quantity": 1},
                  {"pizza_id": "2", "quantity": 1},
                ];
                // Provider.of<OrderProvider>(context, listen: false).placeOrder(orderlines);
              },
              child: const Text('Passer la commande'),
            ),
          ),
          ElevatedButton(
            onPressed: () {
              
            },
            child: const Text('Calculate Delivery Time'),
          ),
        ],
      ),
    );
  }
}
