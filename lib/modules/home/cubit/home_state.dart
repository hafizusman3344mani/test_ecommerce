part of 'home_cubit.dart';

enum HomeStatus {
  initial,
  loading,
  success,
  error,
}

class HomeState {
  final HomeStatus status;
  final String errorMessage;
  final ProductsResponse response;

  const HomeState(
      {required this.status, this.errorMessage = '', required this.response});

  factory HomeState.initial() {
    return HomeState(
        status: HomeStatus.initial,
        response: ProductsResponse(products: [], total: 0, limit: 0, skip: 0));
  }

  HomeState copyWith({
    HomeStatus? status,
    String? errorMessage,
    ProductsResponse? response,
  }) {
    return HomeState(
        status: status ?? this.status,
        errorMessage: errorMessage ?? '',
        response: response ?? this.response);
  }
}
