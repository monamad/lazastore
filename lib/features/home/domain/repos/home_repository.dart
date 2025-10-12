import 'package:lazastore/core/networking/api_result.dart';
import 'package:lazastore/features/home/domain/entities/category_entity.dart';
import 'package:lazastore/features/home/domain/entities/paginated_products_entity.dart';

abstract class HomeRepository {


  Future<ApiResult<PaginatedProductsEntity>> getProducts({
    String? searchTerm,
    String? category,
    double? minPrice,
    double? maxPrice,
    bool? isInStock,
    String? sortBy,
    String? sortOrder,
    int? page,
    int? pageSize,
  });

  Future<ApiResult<List<CategoryEntity>>> getCategories();
}
