import 'package:dio/dio.dart';
import 'package:dio_cache_interceptor/dio_cache_interceptor.dart';
import 'package:flutter/foundation.dart';

const _logRequests = true;

class DioClient {
  // UUID helper to mark requests

  static Dio getClient({
    required String baseUrl,
    CacheOptions? cacheOptions,
    List<Interceptor> interceptors = const [],
  }) {
    List<Interceptor> interceptorsList = [...interceptors];

    interceptorsList.add(_getLogInterceptor());

    final dio = Dio(_dioOptions(baseUrl));

    for (var interceptor in interceptorsList) {
      dio.interceptors.add(interceptor);
    }

    return dio;
  }

  static Interceptor _getLogInterceptor() {
    return LogInterceptor(
      request: _logRequests,
      requestHeader: _logRequests,
      requestBody: _logRequests,
      responseHeader: _logRequests,
      responseBody: _logRequests,
      error: _logRequests,
      logPrint: _logPrint,
    );
  }

  static BaseOptions _dioOptions(String baseUrl) => BaseOptions(
        baseUrl: baseUrl,
        followRedirects: false,
        receiveDataWhenStatusError: true,
        connectTimeout: const Duration(seconds: 240),
        receiveTimeout: const Duration(seconds: 240),
      );

  static void _logPrint(dynamic message) {
    if (kDebugMode) {
      print(message?.toString());
    }
  }
}
