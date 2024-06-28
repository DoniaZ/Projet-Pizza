class Orderline {
  final String id;
  final double amount;
  final int quantity;

  Orderline({
    required this.id,
    required this.amount,
    required this.quantity,
  });

  factory Orderline.fromJson(Map<String, dynamic> json) {
    return Orderline(
      id: json['id'],
      amount: json['amount'].toDouble(),
      quantity: json['quantity'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'amount': amount,
      'quantity': quantity,
    };
  }
}
