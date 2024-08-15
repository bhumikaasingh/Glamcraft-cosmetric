// import 'package:flutter/material.dart';

// class FavouriteView extends StatelessWidget {
//   const FavouriteView({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       // appBar: AppBar(
//       //   title: const Text('Favourites'),
//       //   backgroundColor: Colors.pinkAccent,
//       // ),
//       body: Padding(
//         padding: const EdgeInsets.all(16),
//         child: ListView.builder(
//           itemCount: 8, // Replace with the number of items in your favourites
//           itemBuilder: (context, index) {
//             return _buildFavouriteItem(context, index);
//           },
//         ),
//       ),
//     );
//   }

//   Widget _buildFavouriteItem(BuildContext context, int index) {
//     return Card(
//       margin: const EdgeInsets.only(bottom: 16),
//       elevation: 5,
//       shape: RoundedRectangleBorder(
//         borderRadius: BorderRadius.circular(15),
//       ),
//       child: Padding(
//         padding: const EdgeInsets.all(12.0),
//         child: Row(
//           children: [
//             // Product Image
//             ClipRRect(
//               borderRadius: BorderRadius.circular(8),
//               child: Image.asset(
//                 'assets/images/Sunscreeen.png', // Replace with your product image asset
//                 width: 90,
//                 height: 90,
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
//                     '\Rs.500', // Replace with product price
//                     style: TextStyle(
//                       fontSize: 16,
//                       color: Colors.black,
//                     ),
//                   ),
//                 ],
//               ),
//             ),
//             IconButton(
//               icon: Icon(
//                 Icons.favorite,
//                 color: Colors.red,
//               ),
//               onPressed: () {
//                 // Handle remove from favourites
//               },
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }

import 'package:flutter/material.dart';
import 'dart:async';

class FavouriteView extends StatefulWidget {
  const FavouriteView({super.key});

  @override
  _FavouriteViewState createState() => _FavouriteViewState();
}

class _FavouriteViewState extends State<FavouriteView> {
  // Sample favourite items data
  List<Map<String, dynamic>> favouriteItems = [
    {
      'name': 'Sunscreen',
      'price': 500,
      'imagePath': 'assets/images/Sunscreeen.png',
      'isFavourite': true
    },
    {
      'name': 'Moisturizer',
      'price': 800,
      'imagePath': 'assets/images/Sunscreeen.png',
      'isFavourite': true
    },
    {
      'name': 'Lip Balm',
      'price': 300,
      'imagePath': 'assets/images/Sunscreeen.png',
      'isFavourite': true
    },
    {
      'name': 'Face Wash',
      'price': 400,
      'imagePath': 'assets/images/Sunscreeen.png',
      'isFavourite': true
    },
    // Add more items as needed
  ];

  void _toggleFavourite(int index) {
    setState(() {
      favouriteItems[index]['isFavourite'] =
          !favouriteItems[index]['isFavourite'];
    });

    if (!favouriteItems[index]['isFavourite']) {
      Timer(const Duration(seconds: 1), () {
        setState(() {
          favouriteItems.removeAt(index);
        });
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: ListView.builder(
          itemCount: favouriteItems.length,
          itemBuilder: (context, index) {
            return _buildFavouriteItem(context, index);
          },
        ),
      ),
    );
  }

  Widget _buildFavouriteItem(BuildContext context, int index) {
    return Card(
      margin: const EdgeInsets.only(bottom: 16),
      elevation: 5,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15),
      ),
      child: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Row(
          children: [
            // Product Image
            ClipRRect(
              borderRadius: BorderRadius.circular(8),
              child: Image.asset(
                favouriteItems[index]
                    ['imagePath'], // Fetch product image dynamically
                width: 90,
                height: 90,
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
                    favouriteItems[index]['name'],
                    style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    'Rs.${favouriteItems[index]['price']}',
                    style: const TextStyle(
                      fontSize: 16,
                      color: Colors.black,
                    ),
                  ),
                ],
              ),
            ),
            IconButton(
              icon: Icon(
                favouriteItems[index]['isFavourite']
                    ? Icons.favorite
                    : Icons.favorite_border,
                color: favouriteItems[index]['isFavourite']
                    ? Colors.red
                    : Colors.grey,
              ),
              onPressed: () {
                _toggleFavourite(index);
              },
            ),
          ],
        ),
      ),
    );
  }
}
