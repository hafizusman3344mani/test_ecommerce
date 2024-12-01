import 'package:flutter/foundation.dart';
import 'package:test_ecommerce/modules/home/models/product_model.dart';

import '../../../constants/api_endpoints.dart';
import '../../../core/exceptions/api_error.dart';
import '../../../core/network/dio_client.dart';
import 'package:dio/dio.dart';

class HomeRepository {
  final DioClient _dioClient;

  HomeRepository({
    required DioClient dioClient,
  }) : _dioClient = dioClient;

  Future<ProductsResponse> getProducts() async {
    try {
      var response = await _dioClient.get(
        Endpoints.products,
      );
      ProductsResponse productsResponse =
          await compute(productsResponseFromJson, response.data);
      return productsResponse;
    } on DioException catch (e, stackTrace) {
      throw ApiError.fromDioException(e);
    } on TypeError catch (e, stackTrace) {
      throw ApiError(message: '$e', code: 0);
    } catch (e) {
      throw ApiError(message: '$e', code: 0);
    }
  }

  Future<ProductsResponse> searchProducts(String query) async {
    try {
      var response = await _dioClient
          .get(Endpoints.searchProducts, queryParameters: {"q": query});
      ProductsResponse productsResponse =
          await compute(productsResponseFromJson, response.data);
      return productsResponse;
    } on DioException catch (e, stackTrace) {
      throw ApiError.fromDioException(e);
    } on TypeError catch (e, stackTrace) {
      throw ApiError(message: '$e', code: 0);
    } catch (e) {
      throw ApiError(message: '$e', code: 0);
    }
  }
}
