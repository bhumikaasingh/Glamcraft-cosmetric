import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:dio/dio.dart';
import '../../../../app/constant/api_endpoint.dart';
import '../../data/model/cart_model.dart';

// final cartViewModelProvider = FutureProvider<Cart>((ref) async {
//   // final userId = ref.read(userIdProvider); // Assume you have a userIdProvider
//   final response = await Dio().get(
//       '${ApiEndpoints.baseUrl}${ApiEndpoints.getCart}/66847f3cb51bc68060b9ff86');

//   if (response.statusCode == 200) {
//     final data = response.data;
//     if (data['success'] == true && data['cart'] != null) {
//       return Cart.fromJson(data['cart']);
//     } else {
//       throw Exception('Failed to fetch cart');
//     }
//   } else {
//     throw Exception(
//         'Failed to fetch cart: ${response.statusCode} ${response.statusMessage}');
//   }
// });

final cartViewModelProvider = FutureProvider<Cart>((ref) async {
  final response = await Dio().get(
      '${ApiEndpoints.baseUrl}${ApiEndpoints.getCart}/${ApiEndpoints.userId}');
  if (response.statusCode == 200) {
    return Cart.fromJson(response.data['cart']);
  } else {
    throw Exception('Failed to fetch cart');
  }
});
