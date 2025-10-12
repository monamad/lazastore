import 'package:lazastore/features/home/domain/entities/paginated_products_entity.dart';

sealed class GetProductState {}

class GetProductInitial extends GetProductState {}

class ProductLoadingState extends GetProductState {
  ProductLoadingState();
}

class ProductLoaded extends GetProductState {
  final PaginatedProductsEntity products;
  final bool isLoadingMore;
  final bool hasMore;

  ProductLoaded(
    this.products, {
    this.isLoadingMore = false,
    this.hasMore = false,
  });
  ProductLoaded copyWith({
    PaginatedProductsEntity? products,
    bool? isLoadingMore,
    bool? hasMore,
  }) {
    return ProductLoaded(
      products ?? this.products,
      isLoadingMore: isLoadingMore ?? this.isLoadingMore,
      hasMore: hasMore ?? this.hasMore,
    );
  }
}

class ProductError extends GetProductState {
  final String message;
  ProductError(this.message);
}
