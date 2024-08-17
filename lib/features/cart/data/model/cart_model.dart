import 'package:json_annotation/json_annotation.dart';

part 'cart_model.g.dart';

@JsonSerializable()
class Cart {
  final String id;
  final String userId;
  final List<CartItem> products;

  Cart({
    required this.id,
    required this.userId,
    required this.products,
  });

  factory Cart.fromJson(Map<String, dynamic> json) => _$CartFromJson(json);
  Map<String, dynamic> toJson() => _$CartToJson(this);
}

@JsonSerializable()
class CartItem {
  final String productId;
  final int quantity;

  CartItem({
    required this.productId,
    required this.quantity,
  });

  factory CartItem.fromJson(Map<String, dynamic> json) =>
      _$CartItemFromJson(json);
  Map<String, dynamic> toJson() => _$CartItemToJson(this);
}
