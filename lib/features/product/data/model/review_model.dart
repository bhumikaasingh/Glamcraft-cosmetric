import 'package:json_annotation/json_annotation.dart';

part 'review_model.g.dart';

@JsonSerializable()
class Review {
  @JsonKey(name: '_id') // Matches the API field name
  final String id;
  @JsonKey(name: 'productId') // Matches the API field name
  final String productId;
  @JsonKey(name: 'userId') // Matches the API field name
  final String userId;
  final int rating;
  @JsonKey(name: 'reviewText') // Matches the API field name
  final String reviewText;
  @JsonKey(name: 'createdAt') // Matches the API field name
  final DateTime createdAt;

  Review({
    required this.id,
    required this.productId,
    required this.userId,
    required this.rating,
    required this.reviewText,
    required this.createdAt,
  });

  factory Review.fromJson(Map<String, dynamic> json) => _$ReviewFromJson(json);
  Map<String, dynamic> toJson() => _$ReviewToJson(this);
}
