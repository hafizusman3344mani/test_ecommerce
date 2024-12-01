part of 'favourites_cubit.dart';

enum FavouritesStatus {
  initial,
  loading,
  success,
  error,
}

class FavouritesState {
  final FavouritesStatus status;
  final String errorMessage;
  final List<ProductModel> favProducts;

  const FavouritesState({
    required this.status,
    this.errorMessage = '',
    required this.favProducts,
  });

  factory FavouritesState.initial() {
    return const FavouritesState(
        status: FavouritesStatus.initial, favProducts: []);
  }

  FavouritesState copyWith(
      {FavouritesStatus? status,
      String? errorMessage,
      List<ProductModel>? favProducts}) {
    return FavouritesState(
      status: status ?? this.status,
      errorMessage: errorMessage ?? '',
      favProducts: favProducts ?? this.favProducts,
    );
  }
}
