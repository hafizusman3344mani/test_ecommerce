import 'package:dio/dio.dart';
import 'package:dio/io.dart';

class DioClient extends DioForNative {
  final String baseUrl;
  String? _authToken;

  void setToken(String token) {
    this._authToken = token;
  }

  DioClient({required this.baseUrl}) {
    options = BaseOptions(
      baseUrl: baseUrl,
      responseType: ResponseType.json,
    );
    interceptors.add(
      InterceptorsWrapper(onRequest: (options, handler) {
        if (_authToken != null) {
          options.headers
              .putIfAbsent('Authorization', () => 'Bearer $_authToken');
        }
        return handler.next(options);
      }),
    );
    interceptors.add(LogInterceptor(
      request: false,
      requestHeader: false,
      requestBody: true,
      responseHeader: false,
      responseBody: true,
    ));
  }
}
