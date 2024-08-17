import 'package:json_annotation/json_annotation.dart';

class Review {
  final String id;
  final String? productId;
  final String? userId; // Make this nullable
  final int rating;
  final String reviewText;
  final DateTime createdAt;

  Review({
    required this.id,
    this.productId,
    this.userId,
    required this.rating,
    required this.reviewText,
    required this.createdAt,
  });

  factory Review.fromJson(Map<String, dynamic> json) {
    return Review(
      id: json['_id'],
      productId: json['productId'],
      userId: json['userId'], // Handle as nullable
      rating: json['rating'],
      reviewText: json['reviewText'],
      createdAt: DateTime.parse(json['createdAt']),
    );
  }
}
