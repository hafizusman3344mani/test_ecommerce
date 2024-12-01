part of 'categories_cubit.dart';

enum CategoriesStatus {
  initial,
  loading,
  success,
  error,
}

class CategoriesState  {
  final CategoriesStatus status;
  final String errorMessage;
  final List<CategoryModel> categories;

  const CategoriesState({
    required this.status,
    this.errorMessage = '',
    required this.categories,
  });

  factory CategoriesState.initial() {
    return const CategoriesState(
      status: CategoriesStatus.initial,
      categories: []
    );
  }


  CategoriesState copyWith({
  CategoriesStatus? status,
    String? errorMessage,
    List<CategoryModel>? categories,
  }) {
    return CategoriesState(
        status: status ?? this.status, errorMessage: errorMessage ?? '',categories: categories??this.categories);
  }
}
