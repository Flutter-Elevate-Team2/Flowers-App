import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';
import 'package:retrofit/http.dart';

part 'user_address_api.g.dart';

@lazySingleton
@RestApi()
abstract class UserAddressApi {
  @factoryMethod
  factory UserAddressApi(Dio dio) = _UserAddressApi;
  
}