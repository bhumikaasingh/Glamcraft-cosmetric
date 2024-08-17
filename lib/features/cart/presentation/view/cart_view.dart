import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../viewmodel/cart_viewmode.dart';

class CartView extends ConsumerWidget {
  @override
  Widget build(BuildContext context, ScopedReader watch) {
    final cartAsyncValue = watch(cartViewModelProvider);

    return Scaffold(
      appBar: AppBar(
        title: Text('Cart'),
      ),
      body: cartAsyncValue.when(
        data: (cart) => ListView.builder(
          itemCount: cart.products.length,
          itemBuilder: (context, index) {
            final item = cart.products[index];
            return ListTile(
              title: Text('Product ID: ${item.productId}'),
              subtitle: Text('Quantity: ${item.quantity}'),
            );
          },
        ),
        loading: () => Center(child: CircularProgressIndicator()),
        error: (e, stack) => Center(child: Text('Error: $e')),
      ),
    );
  }
}
