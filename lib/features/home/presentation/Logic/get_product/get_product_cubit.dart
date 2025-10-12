import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lazastore/core/networking/api_result.dart';
import 'package:lazastore/features/home/domain/use_cases/get_products_use_case.dart';
import 'package:lazastore/features/home/presentation/Logic/get_product/get_product_state.dart';

class GetProductCubit extends Cubit<GetProductState> {
  GetProductCubit(this._getProductsUseCase) : super(GetProductInitial());
  final GetProductsUseCase _getProductsUseCase;

  Future<void> getProducts() async {
    emit(ProductLoadingState());

    final result = await _getProductsUseCase.call(page: 1, pageSize: 18);
    result.when(
      success: (paginatedProducts) {
        emit(
          ProductLoaded(
            paginatedProducts,
            hasMore: paginatedProducts.hasNextPage,
          ),
        );
      },
      failure: (error) {
        emit(ProductError(error.message));
      },
    );
  }

  // Load more products
  void loadMoreProducts() async {
    final currentState = state;
    if (currentState is ProductLoaded &&
        !currentState.isLoadingMore &&
        currentState.hasMore) {
      emit(currentState.copyWith(isLoadingMore: true));
      final currentProducts = currentState.products;
      if (currentProducts.hasNextPage) {
        final result = await _getProductsUseCase.call(
          page: currentProducts.page + 1,
          pageSize: 18,
        );
        result.when(
          success: (newpaginatedProducts) {
            newpaginatedProducts += currentState.products;
            emit(
              ProductLoaded(
                newpaginatedProducts,
                hasMore: newpaginatedProducts.hasNextPage,
                isLoadingMore: false,
              ),
            );
          },
          failure: (error) {
            emit(
              ProductLoaded(
                currentProducts,
                hasMore: currentProducts.hasNextPage,
                isLoadingMore: false,
              ),
            );
          },
        );
      }
      return;
    }
  }
}
