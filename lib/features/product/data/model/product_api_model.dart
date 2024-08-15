import 'package:final_assignment/features/product/domain/entity/product_entiry.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:json_annotation/json_annotation.dart';

final productApiModelProvider = Provider<ProductApiModel>(
  (ref) => ProductApiModel.empty(),
);

@JsonSerializable()
class ProductApiModel {
  @JsonKey(name: '_id')
  final String? productId;
  final String? productName;
  final int? productPrice;
  final String? productCategory;
  final String? productDescription;
  final String? productImage;
  final String? createdAt;

  ProductApiModel({
    this.productId,
    this.productName,
    this.productPrice,
    this.productCategory,
    this.productDescription,
    this.productImage,
    this.createdAt,
  });
  ProductApiModel.empty()
      : productId = '',
        productName = '',
        productPrice = 0,
        productCategory = '',
        productDescription = '',
        productImage = '',
        createdAt = '';

  // From Json , write full code without generator
  factory ProductApiModel.fromJson(Map<String, dynamic> json) {
    return ProductApiModel(
      productId: json['_id'],
      productName: json['productName'],
      productPrice: json['productPrice'],
      productCategory: json['productCategory'],
      productDescription: json['productDescription'],
      productImage: json['productImage'],
      createdAt: json['createdAt'],
    );
  }

  // To Json , write full code without generator
  Map<String, dynamic> toJson() {
    return {
      'productId': productId,
      'productName': productName,
      'productPrice': productPrice,
      'productCategory': productCategory,
      'productDescription': productDescription,
      'productImage': productImage,
      'createdAt': createdAt
    };
  }

  ProductEntiry toEntity() => ProductEntiry(
        productId: productId,
        productName: productName,
        productPrice: productPrice,
        productCategory: productCategory,
        productDescription: productDescription,
        productImage: productImage,
        createdAt: createdAt,
      );

  
  ProductApiModel fromEntity(ProductEntiry entity) => ProductApiModel(
        productId: entity.productId ?? '',
        productName: entity.productName,
        productPrice: entity.productPrice,
        productCategory: entity.productCategory,
        productDescription: entity.productDescription,
        productImage: entity.productImage,
        createdAt: entity.createdAt,
      );

  // Convert API List to Entity List
  List<ProductEntiry> toEntityList(List<ProductApiModel> models) =>
      models.map((model) => model.toEntity()).toList();
}
