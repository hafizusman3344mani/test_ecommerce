import 'package:flutter/foundation.dart';

import '../../../constants/api_endpoints.dart';
import '../../../core/exceptions/api_error.dart';
import '../../../core/network/dio_client.dart';
import 'package:dio/dio.dart';

import '../../home/models/product_model.dart';

class ProductsRepository {
  final DioClient _dioClient;

  ProductsRepository({
    required DioClient dioClient,
  }) : _dioClient = dioClient;

  Future<ProductsResponse> searchProductsByCategory(
      String category, String? query) async {
    try {
      var response = await _dioClient.get(
          "${Endpoints.productsByCategory}$category",
          queryParameters: {"q": query});
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
