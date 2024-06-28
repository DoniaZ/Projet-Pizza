class Ingredient {
  final String id;
  final String name;
  final String category;
  final double price;

  Ingredient({
    required this.id,
    required this.name,
    required this.category,
    required this.price,
  });

  factory Ingredient.fromJson(Map<String, dynamic> json) {
    return Ingredient(
      id: json['id'],
      name: json['name'],
      category: json['category'],
      price: json['price'].toDouble(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'category': category,
      'price': price,
    };
  }
}
