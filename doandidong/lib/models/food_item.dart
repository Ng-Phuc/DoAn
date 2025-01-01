class FoodItem {
  final int? id;
  final String name;
  final String description;
  final double price;
  final String image;

  FoodItem({
    this.id,
    required this.name,
    required this.description,
    required this.price,
    required this.image,
  });

  factory FoodItem.fromMap(Map<String, dynamic> json) => FoodItem(
    id: json['id'],
    name: json['name'],
    description: json['description'],
    price: json['price'],
    image: json['image'],
  );

  Map<String, dynamic> toMap() => {
    'id': id,
    'name': name,
    'description': description,
    'price': price,
    'image': image,
  };
}
