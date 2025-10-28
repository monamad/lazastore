import 'package:lazastore/core/networking/api_error_handler.dart';
import 'package:lazastore/core/networking/api_result.dart';
import 'package:lazastore/features/home/data/data_sources/home_api_service.dart';
import 'package:lazastore/features/home/domain/entities/category_entity.dart';
import 'package:lazastore/features/home/domain/entities/paginated_products_entity.dart';
import 'package:lazastore/features/home/domain/entities/product_entity.dart';
import 'package:lazastore/features/home/domain/repos/home_repository.dart';

class HomeRepositoryImpl implements HomeRepository {
  final HomeApiService _apiService;

  HomeRepositoryImpl(this._apiService);

  @override
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
  }) async {
    try {
      final response = await _apiService.getProducts(
        page: page,
        pageSize: pageSize,
      );

      final productsResponse = response;

      final products = productsResponse.items
          .map(
            (item) => ProductEntity(
              id: item.id,
              productCode: item.productCode,
              name: item.name,
              description: item.description,
              arabicName: item.arabicName,
              arabicDescription: item.arabicDescription,
              coverPictureUrl: item.coverPictureUrl,
              productPictures: item.productPictures,
              price: item.price,
              stock: item.stock,
              weight: item.weight,
              color: item.color,
              rating: item.rating,
              reviewsCount: item.reviewsCount,
              discountPercentage: item.discountPercentage,
              sellerId: item.sellerId,
              categories: item.categories,
            ),
          )
          .toList();

      final paginatedProducts = PaginatedProductsEntity(
        items: products,
        page: productsResponse.page,
        pageSize: productsResponse.pageSize,
        totalCount: productsResponse.totalCount,
        hasNextPage: productsResponse.hasNextPage,
        hasPreviousPage: productsResponse.hasPreviousPage,
      );

      return Success(paginatedProducts);
    } catch (error) {
      return ApiResult.failure(ApiErrorHandler.handleError(error));
    }
  }

  @override
  Future<ApiResult<List<CategoryEntity>>> getCategories() async {
    try {
      print('Fetching categories from API service...');
      final response = await _apiService.getCategories();
      print('Categories fetched: ${response.categories.length}');

      final categories = response.categories
          .map(
            (category) => CategoryEntity(
              id: category.id,
              name: category.name,
              description: category.description,
              coverPictureUrl: category.coverPictureUrl,
            ),
          )
          .toList();

      return Success(categories);
    } catch (error) {
      return ApiResult.failure(ApiErrorHandler.handleError(error));
    }
  }
}
