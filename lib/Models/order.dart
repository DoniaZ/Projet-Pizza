import 'orderline.dart';

class Order {
  final String id;
  final double amount;
  final DateTime dateCreated;
  final DateTime dateUpdated;
  final String userCreated;
  final String status;
  final List<Orderline> orderlines;

  Order({
    required this.id,
    required this.amount,
    required this.dateCreated,
    required this.dateUpdated,
    required this.userCreated,
    required this.status,
    required this.orderlines,
  });

  factory Order.fromJson(Map<String, dynamic> json) {
    return Order(
      id: json['id'],
      amount: json['amount'].toDouble(),
      dateCreated: DateTime.parse(json['date_created']),
      dateUpdated: DateTime.parse(json['date_updated']),
      userCreated: json['user_created'],
      status: json['status'],
      orderlines: (json['orderlines'] as List)
          .map((i) => Orderline.fromJson(i))
          .toList(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'amount': amount,
      'date_created': dateCreated.toIso8601String(),
      'date_updated': dateUpdated.toIso8601String(),
      'user_created': userCreated,
      'status': status,
      'orderlines': orderlines.map((i) => i.toJson()).toList(),
    };
  }
}
