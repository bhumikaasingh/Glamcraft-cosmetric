import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:dio/dio.dart';
import '../../../../app/constant/api_endpoint.dart';
import '../../data/model/cart_model.dart';

final cartViewModelProvider = FutureProvider<Cart>((ref) async {
  final userId = ref.read(userIdProvider); // Assume you have a userIdProvider
  final response = await Dio().get('${ApiEndpoints.baseUrl}/cart/$userId');

  if (response.statusCode == 200) {
    return Cart.fromJson(response.data['cart']);
  } else {
    throw Exception('Failed to fetch cart');
  }
});
