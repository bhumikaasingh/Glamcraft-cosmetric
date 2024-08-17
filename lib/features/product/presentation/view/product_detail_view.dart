import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../viewmodel/product_viewmodel.dart';
import '../../../../app/constant/api_endpoint.dart';
import '../../data/model/review_model.dart';

class ProductDetailsView extends ConsumerWidget {
  final String productId;

  const ProductDetailsView({Key? key, required this.productId})
      : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final productAsyncValue = ref.watch(productDetailsProvider(productId));
    final reviewsAsyncValue = ref.watch(productReviewsProvider(productId));
    final productViewModel = ref.watch(productViewModelProvider.notifier);

    final reviewTextController = TextEditingController();
    final ratingController = TextEditingController();

    return Scaffold(
      appBar: AppBar(
        title: Text('Product Details'),
      ),
      body: productAsyncValue.when(
        data: (product) {
          return SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Image.network(
                    '${ApiEndpoints.baseUrl}/products/${product.image}',
                    fit: BoxFit.cover),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(product.name,
                          style: TextStyle(
                              fontSize: 24, fontWeight: FontWeight.bold)),
                      SizedBox(height: 10),
                      Text('\Rs. ${product.price}',
                          style: TextStyle(fontSize: 20, color: Colors.green)),
                      SizedBox(height: 10),
                      Text(product.description),
                      SizedBox(height: 20),
                      Text('Reviews',
                          style: TextStyle(
                              fontSize: 18, fontWeight: FontWeight.bold)),
                      reviewsAsyncValue.when(
                        data: (reviews) {
                          if (reviews.isEmpty) {
                            return Text('No reviews yet');
                          }
                          return Column(
                            children: reviews.map((review) {
                              return ListTile(
                                title: Text(review.userId ??
                                    'Anonymous'), // Display userId or 'Anonymous'
                                subtitle: Text(review.reviewText ??
                                    'No review text'), // Handle nullable reviewText
                                trailing: Text('${review.rating}/5'),
                              );
                            }).toList(),
                          );
                        },
                        loading: () =>
                            Center(child: CircularProgressIndicator()),
                        error: (error, stack) => Text('Error: $error'),
                      ),
                      SizedBox(height: 20),
                      Text('Add a Review',
                          style: TextStyle(
                              fontSize: 18, fontWeight: FontWeight.bold)),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Column(
                          children: [
                            TextField(
                              controller: ratingController,
                              keyboardType: TextInputType.number,
                              decoration: InputDecoration(
                                labelText: 'Rating (1-5)',
                                border: OutlineInputBorder(),
                              ),
                            ),
                            SizedBox(height: 10),
                            TextField(
                              controller: reviewTextController,
                              decoration: InputDecoration(
                                labelText: 'Review Text',
                                border: OutlineInputBorder(),
                              ),
                            ),
                            SizedBox(height: 10),
                            ElevatedButton(
                              onPressed: () {
                                final rating =
                                    int.tryParse(ratingController.text) ?? 1;
                                final reviewText = reviewTextController.text;

                                final review = Review(
                                  id: '', // Generate an ID if necessary or leave empty if backend handles it
                                  productId: productId,
                                  userId: ApiEndpoints.userId,
                                  rating: rating,
                                  reviewText: reviewText.isNotEmpty
                                      ? reviewText
                                      : null, // Ensure reviewText is nullable
                                  createdAt: DateTime.now(),
                                );

                                productViewModel.addReview(review);
                              },
                              child: Text('Submit Review'),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          );
        },
        loading: () => Center(child: CircularProgressIndicator()),
        error: (error, stack) => Center(child: Text('Error: $error')),
      ),
    );
  }
}
