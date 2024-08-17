import 'package:json_annotation/json_annotation.dart';

part 'review_model.g.dart';

@JsonSerializable()
class Review {
  @JsonKey(name: '_id')
  final String id;

  @JsonKey(name: 'productId')
  final String productId;

  @JsonKey(name: 'userId')
  final String userId;

  @JsonKey(name: 'rating')
  final int rating;

  @JsonKey(name: 'reviewText')
  final String reviewText;

  @JsonKey(name: 'createdAt')
  final String createdAt;

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
