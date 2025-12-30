import 'package:dio/dio.dart';
import 'package:dio_cache_interceptor/dio_cache_interceptor.dart';
import 'package:flutter/foundation.dart';
import 'package:flowers_app/core/auth_interceptors/auth_interceptors.dart';
import 'package:flowers_app/core/constants/api_constants.dart';
import 'package:injectable/injectable.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';

@module
abstract class DioModule {
  @singleton
  CacheStore get cacheStore => MemCacheStore(); // Runtime memory cache

  @singleton
  CacheOptions get cacheOptions => CacheOptions(
    store: cacheStore,
    policy: CachePolicy.forceCache,
    hitCacheOnErrorCodes: [401, 403],
    maxStale: const Duration(hours: 3),
  );
  @singleton
  PrettyDioLogger get prettyDioLogger {
    return PrettyDioLogger(
      requestHeader: true,
      requestBody: true,
      responseBody: true,
      responseHeader: false,
      error: true,
      compact: true,
      maxWidth: 90,
    );
  }

  @singleton
  Dio dio(
    AuthInterceptor authInterceptor,
    PrettyDioLogger dioLogger,
    CacheOptions cacheOptions,
  ) {
    final dio = Dio(
      BaseOptions(
        baseUrl: ApiConstants.apiBaseUrl,
        headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
        },
        connectTimeout: const Duration(seconds: 30),
        receiveTimeout: const Duration(seconds: 30),
      ),
    );

    dio.interceptors.addAll([
      authInterceptor, // First: Attach tokens
      DioCacheInterceptor(
        options: cacheOptions,
      ), // Second: Check if data is cached
    ]);

    if (kDebugMode) {
      dio.interceptors.add(dioLogger);
    }

    return dio;
  }
}
