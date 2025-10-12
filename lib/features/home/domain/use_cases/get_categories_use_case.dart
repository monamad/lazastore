import 'package:lazastore/core/networking/api_result.dart';
import 'package:lazastore/features/home/domain/entities/category_entity.dart';
import 'package:lazastore/features/home/domain/repos/home_repository.dart';

class GetCategoriesUseCase {
  final HomeRepository _repository;

  const GetCategoriesUseCase(this._repository);

  Future<ApiResult<List<CategoryEntity>>> call() async {
    return await _repository.getCategories();
  }
}
