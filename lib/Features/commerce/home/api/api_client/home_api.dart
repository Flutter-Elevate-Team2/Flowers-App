import 'package:dio/dio.dart';
import 'package:flowers_app/Features/commerce/home/data/models/home_response/home_response.dart';
import 'package:flowers_app/core/constants/api_constants.dart';
import 'package:injectable/injectable.dart';
import 'package:retrofit/retrofit.dart';

part 'home_api.g.dart';

@lazySingleton
@RestApi()
abstract class HomeApi {
  @factoryMethod
  factory HomeApi(Dio dio) = _HomeApi;

  @GET(ApiConstants.home)
  Future<HomeResponse> getHomeSections();
}
