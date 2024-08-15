import 'package:equatable/equatable.dart';

class ProductEntiry extends Equatable {
  final String? productId;
  final String? productName;
  final int? productPrice;
  final String? productCategory;
  final String? productDescription;
  final String? productImage;
  final String? createdAt;

  const ProductEntiry({
    this.productId,
    required this.productName,
    required this.productPrice,
    required this.productCategory,
    required this.productDescription,
    required this.productImage,
    required this.createdAt,


  });

  @override
  List<Object?> get props => [productId, productName,productPrice, productCategory, productDescription, productImage,createdAt];
}
