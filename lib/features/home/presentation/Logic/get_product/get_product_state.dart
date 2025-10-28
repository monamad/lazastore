import 'package:lazastore/features/home/domain/entities/paginated_products_entity.dart';

sealed class GetProductState {}

class GetProductInitial extends GetProductState {}

class ProductLoading extends GetProductState {}

class ProductLoaded extends GetProductState {
  final PaginatedProductsEntity products;
  final bool isLoadingMore;
  final String? paginationError; // Track pagination failures separately

  ProductLoaded(
    this.products, {
    this.isLoadingMore = false,
    this.paginationError,
  });

  ProductLoaded copyWith({
    PaginatedProductsEntity? products,
    bool? isLoadingMore,
    String? paginationError,
  }) {
    return ProductLoaded(
      products ?? this.products,
      isLoadingMore: isLoadingMore ?? this.isLoadingMore,
      paginationError: paginationError,
    );
  }
}

class ProductsError extends GetProductState {
  final String message;
  ProductsError(this.message);
}
