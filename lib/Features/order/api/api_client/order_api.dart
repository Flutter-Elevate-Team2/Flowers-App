import 'package:dio/dio.dart';
import 'package:flowers_app/Features/order/data/models/cart/cart_request_dto.dart';
import 'package:flowers_app/Features/order/data/models/cart/cart_response_model.dart';
import 'package:flowers_app/Features/order/data/models/cart/quantity_request.dart';
import 'package:flowers_app/Features/order/data/models/checkout/cash_checkout_response_model.dart';
import 'package:flowers_app/Features/order/data/models/checkout/credit/credit_checkout_response_model.dart';
import 'package:flowers_app/Features/order/data/models/checkout/order_request_dto.dart';
import 'package:flowers_app/core/constants/api_constants.dart';
import 'package:injectable/injectable.dart';
import 'package:retrofit/error_logger.dart';
import 'package:retrofit/http.dart';

part 'order_api.g.dart';

@lazySingleton
@RestApi()
@injectable
abstract class OrderApi {
  @factoryMethod
  factory OrderApi(Dio dio) = _OrderApi;

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
  @POST(ApiConstants.orders)
  Future<CashCheckoutResponseModel> cashOrderCheckout(
    @Body() OrderRequest orderRequest,
  );

  @POST("${ApiConstants.orders}/checkout")
  Future<CreditCheckoutResponseModel> creditOrderCheckout(
    @Body() OrderRequest orderRequest,
    @Query("url") String redirectUrl,
  );
}
