import 'package:lazastore/core/networking/api_result.dart';
import 'package:lazastore/features/home/domain/entities/paginated_products_entity.dart';
import 'package:lazastore/features/home/domain/repos/home_repository.dart';

class GetProductsUseCase {
  final HomeRepository _repository;

  const GetProductsUseCase(this._repository);

  Future<ApiResult<PaginatedProductsEntity>> call({
    String? searchTerm,
    String? category,
    double? minPrice,
    double? maxPrice,
    bool? isInStock,
    String? sortBy,
    String? sortOrder,
    int? page,
    int? pageSize = 10,
  }) async {
    return await _repository.getProducts(
      searchTerm: searchTerm,
      category: category,
      minPrice: minPrice,
      maxPrice: maxPrice,
      isInStock: isInStock,
      sortBy: sortBy,
      sortOrder: sortOrder,
      page: page,
      pageSize: pageSize,
    );
  }
}
