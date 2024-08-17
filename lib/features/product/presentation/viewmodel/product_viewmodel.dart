import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:dio/dio.dart';
import '../../data/model/product_model.dart';
import '../../data/model/review_model.dart'; // Import Review model
import '../../../../app/constant/api_endpoint.dart';

// Define a provider for ProductViewModel
final productViewModelProvider =
    StateNotifierProvider<ProductViewModel, List<Product>>((ref) {
  return ProductViewModel();
});

class ProductViewModel extends StateNotifier<List<Product>> {
  ProductViewModel() : super([]);

  Future<void> fetchProducts() async {
    try {
      final response =
          await Dio().get('${ApiEndpoints.baseUrl}${ApiEndpoints.getProducts}');
      if (response.statusCode == 200) {
        List<Product> products = (response.data['products'] as List)
            .map((productJson) => Product.fromJson(productJson))
            .toList();
        state = products;
      } else {
        throw Exception('Failed to load products');
      }
    } catch (e) {
      print('Error fetching products: $e');
    }
  }

  Future<void> addReview(Review review) async {
    try {
      final response = await Dio().post(
        '${ApiEndpoints.baseUrl}${ApiEndpoints.createReview}',
        data: review.toJson(),
      );

      if (response.statusCode == 201) {
        print('Review added successfully');
      } else {
        throw Exception('Failed to add review');
      }
    } catch (e) {
      print('Error adding review: $e');
    }
  }
}

final productDetailsProvider =
    FutureProvider.family<Product, String>((ref, productId) async {
  final response = await Dio()
      .get('${ApiEndpoints.baseUrl}${ApiEndpoints.getSingleProduct}$productId');
  if (response.statusCode == 200) {
    return Product.fromJson(response.data['product']);
  } else {
    throw Exception('Failed to load product');
  }
});

final productReviewsProvider =
    FutureProvider.family<List<Review>, String>((ref, productId) async {
  final response = await Dio()
      .get('${ApiEndpoints.baseUrl}${ApiEndpoints.getReviews}$productId');
  if (response.statusCode == 200) {
    return (response.data['reviews'] as List)
        .map((json) => Review.fromJson(json))
        .toList();
  } else {
    throw Exception('Failed to load reviews');
  }
});
