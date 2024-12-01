import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/exceptions/api_error.dart';
import '../models/categories_model.dart';
import '../repository/categories_repository.dart';

part 'categories_state.dart';

class CategoriesCubit extends Cubit<CategoriesState> {
  final CategoriesRepository _categoriesRepository;

  CategoriesCubit({required CategoriesRepository categoriesRepository})
      : _categoriesRepository = categoriesRepository,
        super(CategoriesState.initial());

  Future<void> getCategories() async {
    emit(state.copyWith(status: CategoriesStatus.loading));

    try {
      List<CategoryModel> categories =
          await _categoriesRepository.getCategories();
      emit(state.copyWith(
          status: CategoriesStatus.success, categories: categories));
    } on ApiError catch (e) {
      emit(state.copyWith(
          status: CategoriesStatus.error, errorMessage: e.message));
    }
  }
}
