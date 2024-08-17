import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
// Update import path accordingly
import '../viewmodel/order_viewmodel.dart';
import '../../../../app/constant/api_endpoint.dart';
import '../../data/order_model.dart'; // Import your Order model

class OrderDetailView extends ConsumerWidget {
  final String orderId;

  const OrderDetailView({Key? key, required this.orderId}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final orderAsyncValue = ref.watch(orderDetailProvider(orderId));

    return Scaffold(
      appBar: AppBar(
        title: Text('Order Details'),
      ),
      body: orderAsyncValue.when(
        data: (order) {
          return Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Order ID: ${order.id ?? "Unknown"}'),
                SizedBox(height: 10),
                Text('Total Amount: \Rs.${order.totalAmount ?? 0}'),
                SizedBox(height: 10),
                Text('Status: ${order.status ?? "Unknown"}'),
                SizedBox(height: 10),
                Text('Tracking: ${order.tracking ?? "Unknown"}'),
                SizedBox(height: 10),
                Text('Created At: ${order.createdAt?.toLocal() ?? "Unknown"}'),
                // Add more details if needed
              ],
            ),
          );
        },
        loading: () => Center(child: CircularProgressIndicator()),
        error: (e, stack) =>
            Center(child: Text('Error fetching order details: $e')),
      ),
    );
  }
}
