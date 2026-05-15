import 'package:dio/dio.dart';
import 'package:dio_cache_interceptor/dio_cache_interceptor.dart';
import 'package:flowers_app/Features/commerce/data/models/home_response/home_response.dart';
import 'package:flowers_app/Features/commerce/data/models/products_model/products_response.dart';
import 'package:flowers_app/core/constants/api_constants.dart';
import 'package:flowers_app/core/constants/api_params.dart';
import 'package:injectable/injectable.dart';
import 'package:retrofit/retrofit.dart';

part 'commerce_api.g.dart';

@lazySingleton
@RestApi()
abstract class CommerceApi {
  @factoryMethod
  factory CommerceApi(Dio dio) = _CommerceApi;

  @GET(ApiConstants.home)
  @Extra({'cache_policy': CachePolicy.refreshForceCache})
  Future<HomeResponse> getHomeSections();

  @GET(ApiConstants.getProducts)
  @Extra({'cache_policy': CachePolicy.refreshForceCache})
  Future<ProductsResponse> getProducts({
    @Query(ApiParams.category) String? categoryId,
    @Query(ApiParams.occasion) String? occasionId,
    @Query(ApiParams.sort) String? sort,
    @Query(ApiParams.search) String? search,
    @Query(ApiParams.page) int? page,
    @Query(ApiParams.limit) int? limit,
  });
}
