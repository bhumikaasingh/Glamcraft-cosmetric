import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:dio/dio.dart';
import '../../data/order_model.dart';
import '../../../../app/constant/api_endpoint.dart';

final orderListProvider = FutureProvider<List<Order>>((ref) async {
  final userId = '66847f3cb51bc68060b9ff86'; // Replace with the actual user ID
  final response = await Dio()
      .get('${ApiEndpoints.baseUrl}${ApiEndpoints.getOrders}/$userId');

  if (response.statusCode == 200) {
    final ordersData =
        response.data['orders'] as List<dynamic>?; // Handling nullable list
    if (ordersData != null) {
      return ordersData.map((orderJson) {
        // Handle potential null values
        return Order.fromJson(orderJson as Map<String, dynamic>? ?? {});
      }).toList();
    } else {
      return [];
    }
  } else {
    throw Exception('Failed to load orders');
  }
});

final orderDetailProvider =
    FutureProvider.family<Order, String>((ref, orderId) async {
  final response = await Dio()
      .get('${ApiEndpoints.baseUrl}${ApiEndpoints.getSingleOrder}$orderId');
  if (response.statusCode == 200) {
    return Order.fromJson(response.data['order']);
  } else {
    throw Exception('Failed to load order details');
  }
});

