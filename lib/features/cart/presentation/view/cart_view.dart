import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../viewmodel/cart_viewmode.dart';
import '../../../../app/constant/api_endpoint.dart';
import '../../../product/presentation/viewmodel/product_viewmodel.dart';
import 'package:dio/dio.dart';
import '../../../Orders/presentation/view/order_view.dart';

class CartView extends ConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final cartAsyncValue = ref.watch(cartViewModelProvider);
    final userId =
        '66847f3cb51bc68060b9ff86'; // Replace with the actual user ID

    Future<void> checkout() async {
      try {
        final cart = cartAsyncValue.value;
        if (cart == null) {
          throw Exception('Cart is empty');
        }

        // Ensure product details are available
        final productsAsyncValues = await Future.wait(
          cart.products.map((item) async {
            final product =
                await ref.read(productDetailsProvider(item.productId).future);
            return {
              'productId': item.productId,
              'quantity': item.quantity,
              'price': product.price,
            };
          }),
        );

        final totalAmount = productsAsyncValues.fold(0.0, (sum, item) {
          return sum + (item['price'] as double) * (item['quantity'] as int);
        });

        final response = await Dio().post(
          '${ApiEndpoints.baseUrl}${ApiEndpoints.createOrder}',
          data: {
            'userId': userId,
            'items': productsAsyncValues,
            'totalAmount': totalAmount,
          },
        );

        if (response.statusCode == 201) {
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (context) => OrderListView()),
          );
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
        data: (cart) {
          if (cart.products.isEmpty) {
            return Center(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'Your cart is empty.',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: 16),
                    Text(
                      'It looks like you haven\'t added any items to your cart yet.',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 16,
                        color: Colors.grey,
                      ),
                    ),
                    SizedBox(height: 24),
                    ElevatedButton(
                      onPressed: () {
                        Navigator.popUntil(
                          context,
                          ModalRoute.withName(
                              '/home'), // Change '/home' to the route you use for your product list
                        );
                      },
                      child: Text('Shop More'),
                    ),
                  ],
                ),
              ),
            );
          }

          return Column(
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
                            'Quantity: ${item.quantity}\nPrice: \Rs. ${product.price.toStringAsFixed(2)}'),
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
          );
        },
        loading: () => Center(child: CircularProgressIndicator()),
        error: (e, stack) => Center(child: Text('Error fetching cart: $e')),
      ),
    );
  }
}
