import 'package:final_assignment/core/common/my_snackbar.dart';
import 'package:final_assignment/features/product/domain/usecases/product_usecase.dart';
import 'package:final_assignment/features/product/presentation/state/product_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final productViewModelProvider =
    StateNotifierProvider<ProductViewModel, ProductState>((ref) {
  return ProductViewModel(ref.read(productUsecaseProvider));
});
 
class ProductViewModel extends StateNotifier<ProductState> {
  ProductViewModel(this.productUsecase) : super(ProductState.initial()) {
    getAllProducts();
  }
  final ProductUsecase productUsecase;
 
  Future resetState() async {
    state = ProductState.initial();
    getAllProducts();
  }
 
  getAllProducts() async {
    state = state.copyWith(isLoading: true);
    final currentState = state;
    final page = currentState.page + 1;
    final products = currentState.lstProducts;
    final hasReachedMax = currentState.hasReachedMax;
 
    if (!hasReachedMax) {
      var data = await productUsecase.getAllProducts(page);
      data.fold((l) {
        state = state.copyWith(
            isLoading: false, error: l.error, hasReachedMax: true);
        showMySnackBar(message: l.error, color: Colors.red[800]);
      }, (r) {
        if (r.isEmpty) {
          state = state.copyWith(hasReachedMax: true, error: null);
        }
        else{
          state = state.copyWith(isLoading: false, lstProducts: [...products, ...r], error: null, page: page);
        }
      });
    }
  }
}



