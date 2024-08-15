// import 'package:final_assignment/features/product/domain/entity/product_entiry.dart';
// import 'package:final_assignment/features/product/presentation/viewmodel/product_viewmodel.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_riverpod/flutter_riverpod.dart';


// class ProductView extends ConsumerStatefulWidget {
//   const ProductView({super.key});

//   @override
//   ConsumerState<ProductView> createState() => _AddProductViewState();
// }

// class _AddProductViewState extends ConsumerState<ProductView> {
//   final gap = const SizedBox(height: 8);
//   final productController = TextEditingController();
//   @override
//   Widget build(BuildContext context) {
//     var productState = ref.watch(productViewModelProvider);
//     return SafeArea(
//       child: Scaffold(
//         body: Padding(
//           padding: const EdgeInsets.all(8.0),
//           child: Column(
//             children: [
//               gap,
//               const Align(
//                 alignment: Alignment.center,
//                 child: Text(
//                   'Add Product',
//                   style: TextStyle(
//                     fontSize: 18,
//                     fontWeight: FontWeight.bold,
//                   ),
//                 ),
//               ),
//               gap,
//               TextFormField(
//                 controller: productController,
//                 decoration: const InputDecoration(
//                   border: OutlineInputBorder(),
//                   hintText: 'Product Name',
//                 ),
//                 validator: (value) {
//                   if (value!.isEmpty) {
//                     return 'Please enter product';
//                   }
//                   return null;
//                 },
//               ),
//               gap,
//               SizedBox(
//                 width: double.infinity,
//                 child: ElevatedButton(
//                   onPressed: () {
//                     ProductEntiry productEntity =
//                         ProductEntity(
//                           productName: productController.text,
//                           productCategory: productController.text,
//                           productDescription: productController.text,
//                           productImage: productController.text);
//                     // Pass the data to ViewModel
//                     ref
//                         .read(productViewModelProvider.notifier)
//                         .addProduct(productEntity);
//                   },
//                   child: const Text('Add Product'),
//                 ),
//               ),
//               const SizedBox(height: 10),
//               const Align(
//                 alignment: Alignment.center,
//                 child: Text(
//                   'List of Products',
//                   style: TextStyle(
//                     fontSize: 18,
//                     fontWeight: FontWeight.bold,
//                   ),
//                 ),
//               ),

//               // Display List of products
//               if (productState.isLoading) ...{
//                 const Center(child: CircularProgressIndicator()),
//               } else if (productState.error != null) ...{
//                 Text(productState.error.toString()),
//               } else if (productState.lstProducts.isEmpty) ...{
//                 const Center(child: Text('No Products')),
//               } else ...{
//                 Expanded(
//                   child: ListView.builder(
//                     itemCount: productState.lstProducts.length,
//                     itemBuilder: (context, index) {
//                       var product = productState.lstProducts[index];
//                       return ListTile(
//                         title: Text(product.productName),
//                         subtitle: Text(product.productId ?? ''),
//                         trailing: IconButton(
//                           icon: const Icon(Icons.delete),
//                           onPressed: () {
//                             // Delete the batch
//                           },
//                         ),
//                       );
//                     },
//                   ),
//                 ),
//               }
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }

