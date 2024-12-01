import 'package:dio/dio.dart';

class ApiError implements Exception {
  final int? code;
  final String? message;

  ApiError({
    this.code,
    required this.message,
  });

  factory ApiError.fromDioException(DioException dioException) {
    if (dioException.response != null) {
      switch (dioException.response?.statusCode) {
        case 400:
          return ApiError(
            code: dioException.response?.statusCode,
            message: dioException.response?.data['message'],
          );
        case 401:
          return ApiError(
            code: dioException.response?.statusCode,
            message: dioException.response?.data['message'],
          );
        case 404:
          return ApiError(
            code: dioException.response?.statusCode,
            message: dioException.response?.data['message'],
          );
        case 405:
          return ApiError(
            code: dioException.response?.statusCode,
            message: dioException.response?.data['message'],
          );
        case 500:
          return ApiError(
            code: dioException.response?.statusCode,
            message: 'Source not found',
          );
        case 502:
          return ApiError(
            code: dioException.response?.statusCode,
            message: 'Server not responding',
          );
        case 503:
          return ApiError(
            code: dioException.response?.statusCode,
            message: dioException.response?.data['message'],
          );
        default:
          return ApiError(
            code: dioException.response?.statusCode ?? 0,
            message: dioException.response?.data['message'],
          );
      }
    }

    /// Exception on socket/no internet
    else if (dioException.type == DioExceptionType.unknown) {
      return ApiError(
        code: 503,
        message: 'No internet',
      );
    } else if (dioException.type == DioExceptionType.connectionError) {
      return ApiError(
        code: 500,
        message: 'No Internet available',
      );
    }

    /// Exceptions on timeout
    else if (dioException.type == DioExceptionType.connectionTimeout ||
        dioException.type == DioExceptionType.sendTimeout ||
        dioException.type == DioExceptionType.receiveTimeout) {
      return ApiError(
        code: 0,
        message: 'Time out, try again!',
      );
    }

    return ApiError(
      code: dioException.response?.statusCode ?? 0,
      message: dioException.message,
    );
  }

  @override
  String toString() {
    return 'ApiError(code: $code, message: $message)';
  }
}
