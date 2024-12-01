part of 'products_cubit.dart';

enum ProductsStatus {
  initial,
  loading,
  success,
  error,
}

class ProductsState {
  final ProductsStatus status;
  final String errorMessage;
  final ProductsResponse productsResponse;

  const ProductsState({
    required this.status,
    this.errorMessage = '',
    required this.productsResponse,
  });

  factory ProductsState.initial() {
    return ProductsState(
      status: ProductsStatus.initial,
      productsResponse: ProductsResponse(
        products: [],
        total: 0,
        skip: 0,
        limit: 0,
      ),
    );
  }

  ProductsState copyWith(
      {ProductsStatus? status,
      String? errorMessage,
      ProductsResponse? productsResponse}) {
    return ProductsState(
      status: status ?? this.status,
      errorMessage: errorMessage ?? '',
      productsResponse: productsResponse ?? this.productsResponse,
    );
  }
}
