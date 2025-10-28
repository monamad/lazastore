import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lazastore/core/networking/api_result.dart';
import 'package:lazastore/features/home/domain/use_cases/get_categories_use_case.dart';
import 'package:lazastore/features/home/presentation/Logic/get_categories/get_categories_state.dart';

class GetCategoriesCubit extends Cubit<GetCategoriesState> {
  GetCategoriesCubit(this._getCategoriesUseCase)
    : super(GetCategoriesInitial());
  final GetCategoriesUseCase _getCategoriesUseCase;

  Future<void> getCategories() async {
    emit(GetCategoriesLoadingState());
    final result = await _getCategoriesUseCase.call();
    print(
      'categories fetched-------------------------------------------------------------------',
    );

    result.when(
      success: (categories) {
        emit(GetCategoriesSuccess(categories));
      },
      failure: (error) {
        emit(GetCategoriesError(error.message));
      },
    );
  }
}
