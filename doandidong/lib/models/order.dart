import 'food_item.dart';

class Order {
  final int? id;
  final String userEmail;
  final List<FoodItem> items;
  final double total;
  final String status;

  Order({
    this.id,
    required this.userEmail,
    required this.items,
    required this.total,
    this.status = 'Pending',
  });

  factory Order.fromMap(Map<String, dynamic> json) => Order(
    id: json['id'],
    userEmail: json['userEmail'],
    items: (json['items'] as String)
        .split(',')
        .map((item) => FoodItem.fromMap({'name': item}))
        .toList(),
    total: json['total'],
    status: json['status'],
  );

  Map<String, dynamic> toMap() => {
    'id': id,
    'userEmail': userEmail,
    'items': items.map((item) => item.name).join(','),
    'total': total,
    'status': status,
  };
}
