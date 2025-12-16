import 'package:flowers_app/core/api_constants/api_constants.dart';
import 'package:injectable/injectable.dart';
import 'package:dio/dio.dart';

@module
abstract class DioModule {
  @singleton
  Dio get dio => Dio(BaseOptions(baseUrl: ApiConstants.apiBaseUrl));
}