import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/exceptions/api_error.dart';
import '../../home/models/product_model.dart';
import '../repository/products_repository.dart';

part 'products_state.dart';

class ProductsCubit extends Cubit<ProductsState> {
  final ProductsRepository _productsRepository;

  ProductsCubit({required ProductsRepository productsRepository})
      : _productsRepository = productsRepository,
        super(ProductsState.initial());

  Future<void> getProductsByCategory(String category, {String? query}) async {
    emit(state.copyWith(status: ProductsStatus.loading));

    try {
      ProductsResponse productsResponse =
          await _productsRepository.searchProductsByCategory(category, query);
      emit(state.copyWith(
          status: ProductsStatus.success, productsResponse: productsResponse));
    } on ApiError catch (e) {
      emit(state.copyWith(
          status: ProductsStatus.error, errorMessage: e.message));
    }
  }

  Future<void> addFav(int prodId, bool value) async {

    try {
      ProductsResponse productsResponse = state.productsResponse;
      productsResponse.products
          .firstWhere((product) => product.id == prodId)
          .isFav = value;
      emit(state.copyWith(
          status: ProductsStatus.success, productsResponse: productsResponse));
    } on ApiError catch (e) {
      emit(state.copyWith(
          status: ProductsStatus.error, errorMessage: e.message));
    }
  }
}
