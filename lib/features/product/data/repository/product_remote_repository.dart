// import 'package:dartz/dartz.dart';
// import 'package:final_assignment/core/failure/failure.dart';
// import 'package:final_assignment/features/product/data/data_source/product_remote_datasource.dart.dart';
// import 'package:final_assignment/features/product/domain/entity/product_entiry.dart';
// import 'package:final_assignment/features/product/domain/repository/product_repository.dart';
// import 'package:flutter_riverpod/flutter_riverpod.dart';

// final productRemoteRepositoryProvider = Provider<IProductRepository>((ref) {
//   return ProductRemoteRepository(
//       productRemoteDataSource: ref.read(productRemoteDatasourceProvider));
// });

// class ProductRemoteRepository implements IProductRepository {
//   final ProductRemoteDatasource productRemoteDataSource;

//   ProductRemoteRepository({required this.productRemoteDataSource});

//   @override
//   Future<Either<Failure, List<ProductEntiry>>> getAllProducts(int page) {
//     return productRemoteDataSource.getAllProducts(page);
//   }
// }
