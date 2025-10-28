import 'package:dio/dio.dart';
import 'package:lazastore/features/home/data/models/categories_response.dart';
import 'package:lazastore/features/home/data/models/product_review_response.dart';
import 'package:lazastore/features/home/data/models/products_response.dart';
import 'package:retrofit/retrofit.dart';
import 'package:lazastore/core/networking/api_constants.dart';

part 'home_api_service.g.dart';

@RestApi(baseUrl: ApiConstants.baseUrl)
abstract class HomeApiService {
  factory HomeApiService(Dio dio) = _HomeApiService;

  @GET(ApiConstants.productsEndpoint)
  Future<ProductsResponse> getProducts({
    @Query('searchTerm') String? searchTerm,
    @Query('category') String? category,
    @Query('minPrice') double? minPrice,
    @Query('maxPrice') double? maxPrice,
    @Query('isInStock') bool? isInStock,
    @Query('sortBy') String? sortBy,
    @Query('sortOrder') String? sortOrder,
    @Query('page') int? page,
    @Query('pageSize') int? pageSize = 4,
  });
  @GET(ApiConstants.categoriesEndpoint)
  Future<CategoriesResponse> getCategories();

  @GET(ApiConstants.productReviewsEndpoint)
  Future<ProductReviewResponse> getProductReviews({
    @Query('productId') required String productId,
    @Query('page') int? page,
    @Query('pageSize') int? pageSize = 4,
  });
}
