import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../viewmodel/order_viewmodel.dart'; // Update import path accordingly
import './orderdetails_view.dart'; // Import the OrderDetailView

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
              title: Text(
                  'Order ID: ${order.id ?? "Unknown"}'), // Handle null case
              subtitle: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                      'Total Amount: \Rs. ${order.totalAmount ?? 0}'), // Handle null case
                  Text(
                      'Status: ${order.status ?? "Unknown"}'), // Handle null case
                  Text(
                      'Tracking: ${order.tracking ?? "Unknown"}'), // Handle null case
                  Text(
                      'Created At: ${order.createdAt?.toLocal() ?? "Unknown"}'), // Handle null case
                ],
              ),
              onTap: () {
                // Navigate to OrderDetailView when tapped
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) =>
                        OrderDetailView(orderId: order.id ?? ''),
                  ),
                );
              },
            );
          },
        ),
        loading: () => Center(child: CircularProgressIndicator()),
        error: (e, stack) => Center(child: Text('Error fetching orders: $e')),
      ),
    );
  }
}
