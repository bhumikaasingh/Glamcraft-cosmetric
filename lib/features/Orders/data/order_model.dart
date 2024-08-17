import 'package:json_annotation/json_annotation.dart';

part 'order_model.g.dart';

@JsonSerializable()
class Order {
  @JsonKey(name: '_id')
  final String? id;
  final String? userId;
  final List<OrderItem>? items;
  final double? totalAmount;
  final String? status;
  final String? tracking;
  final DateTime? createdAt;

  Order({
    this.id,
    this.userId,
    this.items,
    this.totalAmount,
    this.status,
    this.tracking,
    this.createdAt,
  });

  factory Order.fromJson(Map<String, dynamic> json) => _$OrderFromJson(json);
  Map<String, dynamic> toJson() => _$OrderToJson(this);
}

@JsonSerializable()
class OrderItem {
  final String? productId; // Made nullable
  final int? quantity; // Made nullable

  OrderItem({
    this.productId,
    this.quantity,
  });

  factory OrderItem.fromJson(Map<String, dynamic> json) =>
      _$OrderItemFromJson(json);
  Map<String, dynamic> toJson() => _$OrderItemToJson(this);
}
