import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../viewmodel/cart_viewmode.dart';
import '../../../../app/constant/api_endpoint.dart';
import '../../../product/presentation/viewmodel/product_viewmodel.dart';
import 'package:dio/dio.dart';

class CartView extends ConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final cartAsyncValue = ref.watch(cartViewModelProvider);
    final userId =
        '66847f3cb51bc68060b9ff86'; // Replace with the actual user ID

    Future<void> checkout() async {
      try {
        final cart = ref.read(cartViewModelProvider).value;
        if (cart == null) {
          throw Exception('Cart is empty');
        }

        final items = cart.products
            .map((item) => {
                  'productId': item.productId,
                  'quantity': item.quantity,
                })
            .toList();

        final totalAmount = cart.products.fold(0.0, (sum, item) {
          final product =
              ref.read(productDetailsProvider(item.productId)).value;
          return sum + (product?.price ?? 0) * item.quantity;
        });

        final response = await Dio()
            .post('${ApiEndpoints.baseUrl}${ApiEndpoints.createOrder}', data: {
          'userId': userId,
          'items': items,
          'totalAmount': totalAmount,
        });

        if (response.statusCode == 201) {
          Navigator.pushNamed(
              context, '/order-list'); // Update route as necessary
        } else {
          throw Exception('Failed to create order');
        }
      } catch (e) {
        print('Error creating order: $e');
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Error creating order: $e')),
        );
      }
    }

    return Scaffold(
      appBar: AppBar(
        title: Text('Cart'),
      ),
      body: cartAsyncValue.when(
        data: (cart) => Column(
          children: [
            Expanded(
              child: ListView.builder(
                itemCount: cart.products.length,
                itemBuilder: (context, index) {
                  final item = cart.products[index];
                  final productAsyncValue =
                      ref.watch(productDetailsProvider(item.productId));

                  return productAsyncValue.when(
                    data: (product) => ListTile(
                      leading: product.image.isNotEmpty
                          ? Image.network(
                              '${ApiEndpoints.baseUrl}products/${product.image}',
                            )
                          : null,
                      title: Text(product.name),
                      subtitle: Text(
                          'Quantity: ${item.quantity}\nPrice: \$${product.price.toStringAsFixed(2)}'),
                    ),
                    loading: () => ListTile(
                      title: Text('Loading product details...'),
                    ),
                    error: (e, stack) => ListTile(
                      title: Text('Error loading product: $e'),
                    ),
                  );
                },
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: ElevatedButton(
                onPressed: checkout,
                child: Text('Checkout'),
              ),
            ),
          ],
        ),
        loading: () => Center(child: CircularProgressIndicator()),
        error: (e, stack) => Center(child: Text('Error fetching cart: $e')),
      ),
    );
  }
}
