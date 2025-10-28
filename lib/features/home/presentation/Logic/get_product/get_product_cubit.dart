import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lazastore/core/networking/api_result.dart';
import 'package:lazastore/features/home/domain/use_cases/get_products_use_case.dart';
import 'package:lazastore/features/home/presentation/Logic/get_product/get_product_state.dart';

class GetProductCubit extends Cubit<GetProductState> {
  GetProductCubit(this._getProductsUseCase) : super(GetProductInitial());
  final GetProductsUseCase _getProductsUseCase;
  int pageSize = 4;

  Future<void> getProducts() async {
    emit(ProductLoading());
    final result = await _getProductsUseCase.call(page: 1, pageSize: pageSize);
    result.when(
      success: (paginatedProducts) {
        emit(ProductLoaded(paginatedProducts));
      },
      failure: (error) {
        emit(ProductsError(error.message));
      },
    );
  }

  Future<void> loadMoreProducts() async {
    final currentState = state;

    // Prevent multiple simultaneous requests
    if (currentState is! ProductLoaded) return;
    if (currentState.isLoadingMore) return;
    if (!currentState.products.hasNextPage) return;

    final currentProducts = currentState.products;

    // Set loading state
    emit(currentState.copyWith(isLoadingMore: true, paginationError: null));

    final result = await _getProductsUseCase.call(
      page: currentProducts.page + 1,
      pageSize: pageSize,
    );

    result.when(
      success: (newPaginatedProducts) {
        final updatedProducts = currentProducts + newPaginatedProducts;
        emit(ProductLoaded(updatedProducts, isLoadingMore: false));
      },
      failure: (error) {
        // Emit error state to show retry UI to user
        emit(
          ProductLoaded(
            currentProducts,
            isLoadingMore: false,
            paginationError: error.message,
          ),
        );
      },
    );
  }
}
