import 'package:dio/dio.dart';
import 'package:flowers_app/Features/order/data/models/cart_request_dto.dart';
import 'package:flowers_app/Features/order/data/models/cart_response_model.dart';
import 'package:flowers_app/Features/order/data/models/quantity_request.dart';
import 'package:flowers_app/core/constants/api_constants.dart';
import 'package:injectable/injectable.dart';
import 'package:retrofit/error_logger.dart';
import 'package:retrofit/http.dart';

part 'cart_api.g.dart';

@lazySingleton
@RestApi()
@injectable
abstract class CartApi {
  @factoryMethod
  factory CartApi(Dio dio) = _CartApi;

  @POST(ApiConstants.cart)
  Future<CartResponseModel> addProductToCart(@Body() CartRequest cartRequest);

  @GET(ApiConstants.cart)
  Future<CartResponseModel> getProductsCart();

  @DELETE("${ApiConstants.cart}/{id}")
  Future<CartResponseModel> deleteProductFromCart(@Path("id") String itemId);

  @PUT("${ApiConstants.cart}/{id}")
  Future<CartResponseModel> updateCartProduct(
    @Path("id") String itemId,
    @Body() QuantityRequest quantityRequest,
  );
}

//Todo: Remove the comments and implement the Cart API client and run build runner to generate the part file.
