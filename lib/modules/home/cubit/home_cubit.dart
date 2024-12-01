import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:test_ecommerce/modules/home/models/product_model.dart';
import 'package:test_ecommerce/modules/home/respository/home_repository.dart';

import '../../../core/exceptions/api_error.dart';

part 'home_state.dart';

class HomeCubit extends Cubit<HomeState> {
  final HomeRepository _homeRepository;
  HomeCubit({required HomeRepository homeRepository})
      : _homeRepository = homeRepository,
        super(HomeState.initial());

  Future<void> getProducts({String query = ''}) async {
    emit(state.copyWith(status: HomeStatus.loading));

    try {
      if (query.isNotEmpty) {
        ProductsResponse productsResponse =
            await _homeRepository.searchProducts(query);
        emit(state.copyWith(
            status: HomeStatus.success, response: productsResponse));
      } else {
        ProductsResponse productsResponse = await _homeRepository.getProducts();
        emit(state.copyWith(
            status: HomeStatus.success, response: productsResponse));
      }
    } on ApiError catch (e) {
      emit(state.copyWith(status: HomeStatus.error, errorMessage: e.message));
    }
  }

  Future<void> addFav(int prodId, bool value) async {

    try {
      ProductsResponse productsResponse = state.response;
      productsResponse.products
          .firstWhere((product) => product.id == prodId)
          .isFav = value;
      emit(state.copyWith(
          status: HomeStatus.success, response: productsResponse));
    } on ApiError catch (e) {
      emit(state.copyWith(
          status: HomeStatus.error, errorMessage: e.message));
    }
  }

}
