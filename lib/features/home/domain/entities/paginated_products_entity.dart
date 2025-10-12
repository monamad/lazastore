import 'package:lazastore/features/home/domain/entities/product_entity.dart';

class PaginatedProductsEntity {
  final List<ProductEntity> items;
  final int page;
  final int pageSize;
  final int totalCount;
  final bool hasNextPage;
  final bool hasPreviousPage;

  const PaginatedProductsEntity({
    required this.items,
    required this.page,
    required this.pageSize,
    required this.totalCount,
    required this.hasNextPage,
    required this.hasPreviousPage,
  });

  PaginatedProductsEntity operator +(PaginatedProductsEntity other) {
    return PaginatedProductsEntity(
      items: [...items, ...other.items],
      page: other.page,
      pageSize: other.pageSize,
      totalCount: totalCount + other.totalCount,
      hasNextPage: other.hasNextPage,
      hasPreviousPage: hasPreviousPage,
    );
  }
}
