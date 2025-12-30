import 'package:dio/dio.dart';
import 'package:dio_cache_interceptor/dio_cache_interceptor.dart';
import 'package:dio_cache_interceptor_hive_store/dio_cache_interceptor_hive_store.dart';
import 'package:flowers_app/core/auth_interceptors/auth_interceptors.dart';
import 'package:flowers_app/core/constants/api_constants.dart';
import 'package:flutter/foundation.dart';
import 'package:injectable/injectable.dart';
import 'package:path_provider/path_provider.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';

@module
abstract class DioModule {
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
  @preResolve
  Future<CacheStore> get cacheStore async {
    final dir = await getApplicationDocumentsDirectory();
    return HiveCacheStore(dir.path, hiveBoxName: 'dio_cache');
  }

  @singleton
  CacheOptions cacheOptions(CacheStore cacheStore) {
    return CacheOptions(
      store: cacheStore,
      policy: CachePolicy.forceCache,
      hitCacheOnErrorExcept: [401, 403],
      maxStale: const Duration(days: 7),
      priority: CachePriority.high,
      keyBuilder: CacheOptions.defaultCacheKeyBuilder,
      allowPostMethod: false,
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
      DioCacheInterceptor(options: cacheOptions), // Second: Check cache
    ]);

    if (kDebugMode) {
      dio.interceptors.add(dioLogger); // Third: Log (if network hit)
    }

    return dio;
  }
}
