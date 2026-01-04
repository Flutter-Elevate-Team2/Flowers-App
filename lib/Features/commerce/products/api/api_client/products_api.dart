import 'package:dio/dio.dart';
import 'package:flowers_app/Features/commerce/products/data/models/products_model/products_response.dart';
import 'package:flowers_app/core/constants/api_constants.dart';
import 'package:flowers_app/core/constants/api_params.dart';
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
    @Query(ApiParams.category) String? categoryId,
    @Query(ApiParams.occasion) String? occasionId,
    @Query(ApiParams.sort) String? sort,
    @Query(ApiParams.search) String? search,
    @Query(ApiParams.page) int? page,
    @Query(ApiParams.limit) int? limit,
  });
}
