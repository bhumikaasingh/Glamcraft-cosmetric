import 'package:dartz/dartz.dart';
import 'package:final_assignment/features/product/domain/entity/product_entiry.dart';
import 'package:final_assignment/features/product/domain/usecases/product_usecase.dart';
import 'package:final_assignment/features/product/presentation/viewmodel/product_viewmodel.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

 
import 'product_unit_test.mocks.dart';
import 'test_data/product_test_data.dart';
 
@GenerateNiceMocks([
  MockSpec<ProductUsecase>(),
])
void main() {
  TestWidgetsFlutterBinding.ensureInitialized();
 
  late ProviderContainer container;
  late ProductUsecase mockProductUsecase;
  late List<ProductEntiry> lstProducts;
 
  setUp(
    () {
      mockProductUsecase = MockProductUsecase();
      lstProducts = ProductTestData.getProductTestData();
      container = ProviderContainer(
        overrides: [
          productViewModelProvider.overrideWith(
            (ref) => ProductViewModel(mockProductUsecase),
          )
        ],
      );
    },
  );
 
  // Test initial state
  test('check product initial state', () async {
    // Arrage
    when(mockProductUsecase.getAllProducts(1)) // 1 is the page number
        .thenAnswer((_) => Future.value(Right(lstProducts)));
 
    // Act
    // Get all products
    await container.read(productViewModelProvider.notifier).getAllProducts();
 
    // Store the state
    final productState = container.read(productViewModelProvider);
 
    // Assert
    // Check the state
    expect(productState.isLoading, false);
    expect(productState.error, isNull);
    expect(productState.lstProducts, isNotEmpty);
  });
 
  test('Failing test on expecting empty product list', () async {
    // Arrage
    when(mockProductUsecase.getAllProducts(1)) // 1 is the page number
        .thenAnswer((_) => Future.value(Right(lstProducts)));
 
    // Act
    // Get all products
    await container.read(productViewModelProvider.notifier).getAllProducts();
 
    // Store the state
    final productState = container.read(productViewModelProvider);
 
    // Assert
    // Check the state
    expect(productState.isLoading, false);
    expect(productState.error, isNull);
    expect(productState.lstProducts, isNotEmpty);
  });
 
  tearDown(() {
    container.dispose();
  });
}
 