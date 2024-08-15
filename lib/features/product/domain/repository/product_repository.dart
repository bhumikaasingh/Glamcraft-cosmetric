import 'package:dartz/dartz.dart';
import 'package:final_assignment/core/failure/failure.dart';
import 'package:final_assignment/features/product/data/repository/product_remote_repository.dart';
import 'package:final_assignment/features/product/domain/entity/product_entiry.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';


final productRepositoryProvider = Provider<IProductRepository>((ref) {
  return ref.read(productRemoteRepositoryProvider);
});

abstract class IProductRepository {
  Future<Either<Failure, List<ProductEntiry>>> getAllProducts(int page);
}
