import 'package:flutter/foundation.dart';

import '../../../constants/api_endpoints.dart';
import '../../../core/exceptions/api_error.dart';
import '../../../core/network/dio_client.dart';
import 'package:dio/dio.dart';

import '../models/categories_model.dart';

class CategoriesRepository {
  final DioClient _dioClient;

  CategoriesRepository({
    required DioClient dioClient,
  }) : _dioClient = dioClient;

  Future<List<CategoryModel>> getCategories() async {
    try {
      var response = await _dioClient.get(Endpoints.categories);
      List<CategoryModel> categoriesResponse =
          await compute(categoriesResponseFromJson, response.data);
      return categoriesResponse;
    } on DioException catch (e, stackTrace) {
      throw ApiError.fromDioException(e);
    } on TypeError catch (e, stackTrace) {
      throw ApiError(message: '$e', code: 0);
    } catch (e) {
      throw ApiError(message: '$e', code: 0);
    }
  }
}
