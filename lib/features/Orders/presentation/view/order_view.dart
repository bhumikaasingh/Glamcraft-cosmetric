import 'package:flutter/material.dart';

class OrderPage extends StatefulWidget {
  @override
  _OrderPageState createState() => _OrderPageState();
}

class _OrderPageState extends State<OrderPage> {
  bool _loading = true;
  List<Order> _orders = [];
  String? _error;

  @override
  void initState() {
    super.initState();
    _fetchOrders();
  }

  Future<void> _fetchOrders() async {
    try {
      // Replace with your API call
      final response = await fetchOrdersApi();
      setState(() {
        _orders = response.orders;
        _loading = false;
      });
    } catch (error) {
      setState(() {
        _error = error.toString();
        _loading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    if (_loading) {
      return Center(child: CircularProgressIndicator());
    }

    if (_error != null) {
      return Center(child: Text('Error: $_error'));
    }

    return Scaffold(
      appBar: AppBar(title: Text('Order List')),
      body: _orders.isNotEmpty
          ? ListView.builder(
              itemCount: _orders.length,
              itemBuilder: (context, index) {
                final order = _orders[index];
                return ListTile(
                  title: Text('Order ID: ${order.id}'),
                  subtitle: Text(
                      'Total Amount: Rs. ${order.totalAmount.toStringAsFixed(2)}'),
                  trailing: Text(order.status),
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) =>
                            OrderDetailsPage(orderId: order.id),
                      ),
                    );
                  },
                );
              },
            )
          : Center(child: Text('No orders found')),
    );
  }
}

// Replace this with your actual API call
Future<OrderResponse> fetchOrdersApi() async {
  // Example response
  return OrderResponse(
    orders: [
      Order(id: '1', totalAmount: 1000.0, status: 'completed'),
      Order(id: '2', totalAmount: 500.0, status: 'pending'),
    ],
  );
}

// Order model
class Order {
  final String id;
  final double totalAmount;
  final String status;

  Order({required this.id, required this.totalAmount, required this.status});
}

// OrderResponse model
class OrderResponse {
  final List<Order> orders;

  OrderResponse({required this.orders});
}
