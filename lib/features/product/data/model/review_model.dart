import 'package:json_annotation/json_annotation.dart';

part 'review_model.g.dart'; // Make sure this line is present

@JsonSerializable()
class Review {
  final String id;
  final String? productId;
  final String? userId; // Make this nullable
  final int rating;
  final String? reviewText; // Make this nullable
  final DateTime createdAt;

  Review({
    required this.id,
    this.productId,
    this.userId,
    required this.rating,
    this.reviewText,
    required this.createdAt,
  });

  factory Review.fromJson(Map<String, dynamic> json) => _$ReviewFromJson(json);
  Map<String, dynamic> toJson() => _$ReviewToJson(this);
}
