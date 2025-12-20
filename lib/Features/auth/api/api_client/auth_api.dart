import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';
import 'package:retrofit/error_logger.dart';
import 'package:retrofit/http.dart';

part 'auth_api.g.dart';

@lazySingleton
@RestApi()
abstract class AuthApi {
  @factoryMethod
  factory AuthApi(Dio dio) = _AuthApi;
  
 
}
