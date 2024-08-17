import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../viewmodel/order_viewmodel.dart';
import '../../../product/presentation/viewmodel/product_viewmodel.dart';

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
                SizedBox(height: 20),
                Text('Ordered Products:',
                    style:
                        TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                ListView.builder(
                  shrinkWrap: true,
                  itemCount: order.items?.length ?? 0,
                  itemBuilder: (context, index) {
                    final productId = order.items?[index].productId;

                    if (productId == null) {
                      return ListTile(
                        title: Text('Unknown Product'),
                        subtitle: Text('Product details unavailable'),
                      );
                    }

                    final productAsyncValue =
                        ref.watch(productDetailsProvider(productId!));

                    return productAsyncValue.when(
                      data: (product) {
                        return ListTile(
                          title: Text(product.name),
                          subtitle: Text('\Rs. ${product.price}'),
                          trailing: Text(
                              'Quantity: ${order.items?[index].quantity ?? "N/A"}'),
                        );
                      },
                      loading: () => Center(child: CircularProgressIndicator()),
                      error: (e, stack) =>
                          Text('Error loading product details: $e'),
                    );
                  },
                ),
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
