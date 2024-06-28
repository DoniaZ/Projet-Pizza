import 'ingredient.dart';

class CustomPizza {
  final String id;
  final String base;
  final double price;
  final List<Ingredient> ingredients;

  CustomPizza({
    required this.id,
    required this.base,
    required this.price,
    required this.ingredients,
  });

  factory CustomPizza.fromJson(Map<String, dynamic> json) {
    return CustomPizza(
      id: json['id'],
      base: json['base'],
      price: json['price'].toDouble(),
      ingredients: (json['ingredients'] as List)
          .map((i) => Ingredient.fromJson(i))
          .toList(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'base': base,
      'price': price,
      'ingredients': ingredients.map((i) => i.toJson()).toList(),
    };
  }
}
