// import 'package:flutter/material.dart';

// class CartView extends StatelessWidget {
//   const CartView({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       // appBar: AppBar(
//       //   title: const Text('Cart'),
//       //   backgroundColor: Colors.green,
//       // ),
//       body: Padding(
//         padding: const EdgeInsets.all(16.0),
//         child: Column(
//           children: [
//             Expanded(
//               child: ListView.builder(
//                 itemCount: 4, // Replace with the number of items in your cart
//                 itemBuilder: (context, index) {
//                   return _buildCartItem(context, index);
//                 },
//               ),
//             ),
//             const SizedBox(height: 16),

//             // Total Price Section
//             _buildTotalSection(context),

//             const SizedBox(height: 16),

//             // Checkout Button
//             ElevatedButton(
//               onPressed: () {
//                 // Handle checkout action
//               },
//               style: ElevatedButton.styleFrom(
//                 backgroundColor: Colors.red,
//                 shape: RoundedRectangleBorder(
//                   borderRadius: BorderRadius.circular(8),
//                 ),
//                 padding:
//                     const EdgeInsets.symmetric(horizontal: 24, vertical: 10),
//               ),
//               child: const Text(
//                 'Checkout',
//                 style: TextStyle(fontSize: 18),
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }

//   Widget _buildCartItem(BuildContext context, int index) {
//     return Card(
//       margin: const EdgeInsets.only(bottom: 16),
//       elevation: 3,
//       shape: RoundedRectangleBorder(
//         borderRadius: BorderRadius.circular(15),
//       ),
//       child: Padding(
//         padding: const EdgeInsets.all(8.0),
//         child: Row(
//           children: [
//             // Product Image
//             ClipRRect(
//               borderRadius: BorderRadius.circular(8),
//               child: Image.asset(
//                 'assets/images/Sunscreeen.png', // Replace with your product image asset
//                 width: 80,
//                 height: 80,
//                 fit: BoxFit.cover,
//               ),
//             ),
//             const SizedBox(width: 16),

//             // Product Info
//             Expanded(
//               child: Column(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: [
//                   const Text(
//                     'Sunscreen',
//                     style: TextStyle(
//                       fontSize: 18,
//                       fontWeight: FontWeight.bold,
//                     ),
//                   ),
//                   const SizedBox(height: 8),
//                   const Text(
//                     'Rs.500', // Replace with product price
//                     style: TextStyle(
//                       fontSize: 16,
//                       color: Colors.black,
//                     ),
//                   ),
//                 ],
//               ),
//             ),

//             // Quantity Control
//             Column(
//               children: [
//                 IconButton(
//                   icon: Icon(Icons.add_circle_outline, color: Colors.red),
//                   onPressed: () {},
//                 ),
//                 const Text(
//                   '1', // Replace with the current quantity
//                   style: TextStyle(fontSize: 16),
//                 ),
//                 IconButton(
//                   icon: Icon(Icons.remove_circle_outline, color: Colors.red),
//                   onPressed: () {
//                     // Decrease quantity
//                   },
//                 ),
//               ],
//             ),
//           ],
//         ),
//       ),
//     );
//   }

//   Widget _buildTotalSection(BuildContext context) {
//     return Container(
//       padding: const EdgeInsets.all(10),
//       decoration: BoxDecoration(
//         color: Colors.grey[400],
//         borderRadius: BorderRadius.circular(10),
//       ),
//       child: Row(
//         mainAxisAlignment: MainAxisAlignment.spaceBetween,
//         children: [
//           const Text(
//             'Total',
//             style: TextStyle(
//               fontSize: 18,
//               fontWeight: FontWeight.bold,
//             ),
//           ),
//           const Text(
//             '\Rs.2000', // Replace with the calculated total price
//             style: TextStyle(
//               fontSize: 18,
//               fontWeight: FontWeight.bold,
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }
import 'package:flutter/material.dart';

class CartView extends StatefulWidget {
  const CartView({super.key});

  @override
  _CartViewState createState() => _CartViewState();
}

class _CartViewState extends State<CartView> {
  // Sample cart data
  List<Map<String, dynamic>> cartItems = [
    {
      'name': 'Sunscreen',
      'price': 500,
      'quantity': 1,
      'imagePath': 'assets/images/Sunscreeen.png'
    },
    {
      'name': 'Moisturizer',
      'price': 800,
      'quantity': 1,
      'imagePath': 'assets/images/Sunscreeen.png'
    },
    {
      'name': 'Lip Balm',
      'price': 300,
      'quantity': 1,
      'imagePath': 'assets/images/Sunscreeen.png'
    },
    {
      'name': 'Face Wash',
      'price': 400,
      'quantity': 1,
      'imagePath': 'assets/images/Sunscreeen.png'
    },
  ];

  // int _calculateTotal() {
  //   return cartItems.fold(
  //     0,
  //     (sum, item) => sum + (item['price'] * item['quantity']),
  //   );
  // }

  void _increaseQuantity(int index) {
    setState(() {
      cartItems[index]['quantity']++;
    });
  }

  void _decreaseQuantity(int index) {
    setState(() {
      if (cartItems[index]['quantity'] > 1) {
        cartItems[index]['quantity']--;
      }
    });
  }

  void _removeItem(int index) {
    setState(() {
      cartItems.removeAt(index);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Expanded(
              child: ListView.builder(
                itemCount: cartItems.length,
                itemBuilder: (context, index) {
                  return Dismissible(
                    key: Key(cartItems[index]['name']),
                    direction: DismissDirection.endToStart,
                    background: Container(
                      color: Colors.red,
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      alignment: Alignment.centerLeft,
                      child: const Icon(Icons.delete, color: Colors.white),
                    ),
                    onDismissed: (direction) {
                      _removeItem(index);
                    },
                    child: _buildCartItem(index),
                  );
                },
              ),
            ),
            const SizedBox(height: 16),

            // Total Price Section
            _buildTotalSection(),

            const SizedBox(height: 16),

            // Checkout Button
            ElevatedButton(
              onPressed: () {
                // Handle checkout action
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.lightGreen,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
                padding:
                    const EdgeInsets.symmetric(horizontal: 24, vertical: 10),
              ),
              child: const Text(
                'Checkout',
                style: TextStyle(fontSize: 18),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildCartItem(int index) {
    return Card(
      margin: const EdgeInsets.only(bottom: 16),
      elevation: 3,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15),
      ),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Row(
          children: [
            // Product Image
            ClipRRect(
              borderRadius: BorderRadius.circular(8),
              child: Image.asset(
                cartItems[index]
                    ['imagePath'], // Fetch product image dynamically
                width: 80,
                height: 80,
                fit: BoxFit.cover,
              ),
            ),
            const SizedBox(width: 16),

            // Product Info
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    cartItems[index]['name'],
                    style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    'Rs.${cartItems[index]['price']}',
                    style: const TextStyle(
                      fontSize: 16,
                      color: Colors.black,
                    ),
                  ),
                ],
              ),
            ),

            // Quantity Control
            Column(
              children: [
                IconButton(
                  icon: const Icon(Icons.add_circle_outline, color: Colors.red),
                  onPressed: () {
                    _increaseQuantity(index);
                  },
                ),
                Text(
                  '${cartItems[index]['quantity']}',
                  style: const TextStyle(fontSize: 16),
                ),
                IconButton(
                  icon: const Icon(Icons.remove_circle_outline,
                      color: Colors.red),
                  onPressed: () {
                    _decreaseQuantity(index);
                  },
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTotalSection() {
    return Container(
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: Colors.grey[400],
        borderRadius: BorderRadius.circular(10),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          const Text(
            'Total',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
          Text(
            'Rs.2500',
            style: const TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }
}
