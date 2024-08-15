import 'package:dartz/dartz.dart';
import 'package:final_assignment/core/failure/failure.dart';
import 'package:final_assignment/features/product/domain/entity/product_entiry.dart';
import 'package:final_assignment/features/product/domain/repository/product_repository.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final productUsecaseProvider = Provider<ProductUsecase>(
    (ref) => ProductUsecase(productRepository: ref.read(productRepositoryProvider)));
 
class ProductUsecase {
  final IProductRepository productRepository;
  ProductUsecase({required this.productRepository});   
 
  Future<Either<Failure, List<ProductEntiry>>> getAllProducts(int page) {
    return productRepository.getAllProducts(page);
  }
}



