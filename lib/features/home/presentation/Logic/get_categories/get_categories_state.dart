import 'package:lazastore/features/home/domain/entities/category_entity.dart';
sealed class GetCategoriesState {}

class GetCategoriesInitial extends GetCategoriesState {}

class GetCategoriesSuccess extends GetCategoriesState {
  final List<CategoryEntity> categories;
  GetCategoriesSuccess(this.categories);
}

class GetCategoriesError extends GetCategoriesState {
  final String message;
  GetCategoriesError(this.message);
}

class GetCategoriesLoadingState extends GetCategoriesState {
  GetCategoriesLoadingState();
}
