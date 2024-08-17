import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:dio/dio.dart';
import '../../data/order_model.dart';
import '../../../../app/constant/api_endpoint.dart';

final orderListProvider = FutureProvider<List<Order>>((ref) async {
  final userId = '66847f3cb51bc68060b9ff86'; // Replace with the actual user ID
  final response = await Dio()
      .get('${ApiEndpoints.baseUrl}${ApiEndpoints.getOrders}$userId');

  if (response.statusCode == 200) {
    final ordersData = response.data['orders'] as List;
    return ordersData.map((orderJson) => Order.fromJson(orderJson)).toList();
  } else {
    throw Exception('Failed to load orders');
  }
});
