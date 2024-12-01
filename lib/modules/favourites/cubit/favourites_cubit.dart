import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:test_ecommerce/modules/home/models/product_model.dart';

import '../../../../core/exceptions/api_error.dart';

part 'favourites_state.dart';

class FavouritesCubit extends Cubit<FavouritesState> {
  FavouritesCubit() : super(FavouritesState.initial());

  List<ProductModel> favProducts = [];
  Future<void> getFavourites() async {
    emit(state.copyWith(status: FavouritesStatus.loading));

    try {
      emit(state.copyWith(
          status: FavouritesStatus.success, favProducts: favProducts));
    } on ApiError catch (e) {
      emit(state.copyWith(
          status: FavouritesStatus.error, errorMessage: e.message));
    }
  }

  Future<void> addFavourite(ProductModel product) async {
    emit(state.copyWith(status: FavouritesStatus.loading));

    try {
      if (favProducts.any((pro) => pro.id == product.id)) {
        favProducts.remove(product);
      } else {
        favProducts.add(product);
      }

      emit(state.copyWith(
          status: FavouritesStatus.success, favProducts: favProducts));
    } on ApiError catch (e) {
      emit(state.copyWith(
          status: FavouritesStatus.error, errorMessage: e.message));
    }
  }

  Future<void> removeFavourite(int productId) async {
    try {
      favProducts.removeWhere((prod) => prod.id == productId);

      emit(state.copyWith(
          status: FavouritesStatus.success, favProducts: favProducts));
    } on ApiError catch (e) {
      emit(state.copyWith(
          status: FavouritesStatus.error, errorMessage: e.message));
    }
  }
}
