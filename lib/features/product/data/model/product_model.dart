import 'package:json_annotation/json_annotation.dart';

class Product {
  final String id;
  final String name;
  final String description;
  final String image;
  final double price;

  Product({
    required this.id,
    required this.name,
    required this.description,
    required this.image,
    required this.price,
  });

  factory Product.fromJson(Map<String, dynamic> json) {
    return Product(
      id: json['_id'],
      name: json['productName'],
      description: json['productDescription'],
      image: json['productImage'],
      price: json['productPrice'].toDouble(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      '_id': id,
      'productName': name,
      'productDescription': description,
      'productImage': image,
      'productPrice': price,
    };
  }
}
