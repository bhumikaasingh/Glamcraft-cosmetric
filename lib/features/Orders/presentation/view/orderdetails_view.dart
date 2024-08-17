// import 'package:flutter/material.dart';

// class OrderDetailsPage extends StatefulWidget {
//   final String orderId;

//   const OrderDetailsPage({required this.orderId});

//   @override
//   _OrderDetailsPageState createState() => _OrderDetailsPageState();
// }

// class _OrderDetailsPageState extends State<OrderDetailsPage> {
//   bool _loading = true;
//   Order? _order;
//   String? _error;

//   @override
//   void initState() {
//     super.initState();
//     _fetchOrderDetails();
//   }

//   Future<void> _fetchOrderDetails() async {
//     try {
//       // Replace with your API call
//       final response = await fetchOrderDetailsApi(widget.orderId);
//       setState(() {
//         _order = response.order;
//         _loading = false;
//       });
//     } catch (error) {
//       setState(() {
//         _error = error.toString();
//         _loading = false;
//       });
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     if (_loading) {
//       return Center(child: CircularProgressIndicator());
//     }

//     if (_error != null) {
//       return Center(child: Text('Error: $_error'));
//     }

//     return Scaffold(
//       appBar: AppBar(title: Text('Order Details')),
//       body: _order != null
//           ? Padding(
//               padding: const EdgeInsets.all(16.0),
//               child: Column(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: [
//                   Text('Order ID: ${_order!.id}',
//                       style:
//                           TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
//                   Text(
//                       'Total Amount: Rs. ${_order!.totalAmount.toStringAsFixed(2)}'),
//                   Text('Status: ${_order!.status}'),
//                   SizedBox(height: 20),
//                   Text('Items:',
//                       style:
//                           TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
//                   Expanded(
//                     child: ListView.builder(
//                       itemCount: _order!.items.length,
//                       itemBuilder: (context, index) {
//                         final item = _order!.items[index];
//                         return ListTile(
//                           title: Text('Product ID: ${item.productId}'),
//                           subtitle: Text('Quantity: ${item.quantity}'),
//                         );
//                       },
//                     ),
//                   ),
//                 ],
//               ),
//             )
//           : Center(child: Text('No order found')),
//     );
//   }
// }

// // Replace this with your actual API call
// Future<OrderDetailsResponse> fetchOrderDetailsApi(String orderId) async {
//   // Example response
//   return OrderDetailsResponse(
//     order: Order(
//       id: orderId,
//       totalAmount: 1000.0,
//       status: 'completed',
//       items: [OrderItem(productId: '123', quantity: 2)],
//     ),
//   );
// }

// // OrderDetailsResponse model
// class OrderDetailsResponse {
//   final Order order;

//   OrderDetailsResponse({required this.order});
// }

// // OrderItem model
// class OrderItem {
//   final String productId;
//   final int quantity;

//   OrderItem({required this.productId, required this.quantity});
// }
