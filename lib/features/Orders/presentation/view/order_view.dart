import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../viewmodel/order_viewmodel.dart'; // Update import path accordingly

class OrderListView extends ConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final ordersAsyncValue = ref.watch(orderListProvider);

    return Scaffold(
      appBar: AppBar(
        title: Text('Order List'),
      ),
      body: ordersAsyncValue.when(
        data: (orders) => ListView.builder(
          itemCount: orders.length,
          itemBuilder: (context, index) {
            final order = orders[index];
            return ListTile(
              title: Text('Order ID: ${order.id}'),
              subtitle: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                      'Total Amount: \$${order.totalAmount.toStringAsFixed(2)}'),
                  Text('Status: ${order.status}'),
                  Text('Tracking: ${order.tracking}'),
                  Text('Created At: ${order.createdAt.toLocal()}'),
                ],
              ),
            );
          },
        ),
        loading: () => Center(child: CircularProgressIndicator()),
        error: (e, stack) => Center(child: Text('Error fetching orders: $e')),
      ),
    );
  }
}
