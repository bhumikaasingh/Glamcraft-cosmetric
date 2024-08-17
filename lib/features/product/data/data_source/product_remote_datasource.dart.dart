import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:final_assignment/app/constant/api_endpoint.dart';
import 'package:final_assignment/core/failure/failure.dart';
import 'package:final_assignment/core/networking/remote/http_service.dart';
import 'package:final_assignment/features/product/data/model/product_model.dart';
import 'package:final_assignment/features/product/domain/entity/product_entiry.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final productRemoteDatasourceProvider = Provider(
  (ref) => ProductRemoteDatasource(
    dio: ref.read(httpServiceProvider),
    productApiModel: ref.read(productApiModelProvider),
  ),
);

class ProductRemoteDatasource {
  final Dio dio;
  final ProductApiModel productApiModel;

  ProductRemoteDatasource({
    required this.dio,
    required this.productApiModel,
  });

  Future<Either<Failure, List<ProductEntiry>>> getAllProducts(int page) async {
    try {
      var response = await dio.get(
        ApiEndpoints.getProducts,
        queryParameters: {
          'page': page,
          'limit': ApiEndpoints.limitPage,
        },
      );
      if (response.statusCode == 201) {
        return Right((response.data['products'] as List)
            .map((product) => ProductApiModel.fromJson(product).toEntity())
            .toList());

        // GetAllProductDTO productAddDTO = GetAllProductDTO.fromJson(response.data);
        // return Right(ProductApiModel.toEntityList(productAddDTO.data));
      } else {
        return Left(
          Failure(
            error: response.statusMessage.toString(),
            statusCode: response.statusCode.toString(),
          ),
        );
      }
    } on DioException catch (e) {
      return Left(
        Failure(
          error: e.error.toString(),
        ),
      );
    }
  }
}
