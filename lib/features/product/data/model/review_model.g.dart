// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'review_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Review _$ReviewFromJson(Map<String, dynamic> json) => Review(
      id: json['_id'] as String,
      productId: json['productId'] as String,
      userId: json['userId'] as String,
      rating: (json['rating'] as num).toInt(),
      reviewText: json['reviewText'] as String,
      createdAt: json['createdAt'] as String,
    );

Map<String, dynamic> _$ReviewToJson(Review instance) => <String, dynamic>{
      '_id': instance.id,
      'productId': instance.productId,
      'userId': instance.userId,
      'rating': instance.rating,
      'reviewText': instance.reviewText,
      'createdAt': instance.createdAt,
    };
