import 'package:dio/dio.dart';
import 'package:flowers_app/Features/products/data/models/products_model/products_response.dart';
import 'package:flowers_app/core/constants/api_constants.dart';
import 'package:injectable/injectable.dart';
import 'package:retrofit/error_logger.dart';
import 'package:retrofit/http.dart';

part 'products_api.g.dart';

@lazySingleton
@RestApi()
abstract class ProductsApi {
  @factoryMethod
  factory ProductsApi(Dio dio) = _ProductsApi;

  @GET(ApiConstants.getProducts)
  Future<ProductsResponse> getProducts({
    @Query('category') String? categoryId,
    @Query('occasion') String? occasionId,
    @Query('sort') String? sort,
  });
}