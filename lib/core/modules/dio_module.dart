import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:flowers_app/core/auth_interceptors/auth_interceptors.dart';
import 'package:flowers_app/core/constants/api_constants.dart';
import 'package:injectable/injectable.dart';
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
  Dio dio(
    AuthInterceptor authInterceptor,
    PrettyDioLogger dioLogger,
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
    dio.interceptors.add(authInterceptor);
    if (kDebugMode) {
      dio.interceptors.add(dioLogger);
    }
    return dio;
  }
}
