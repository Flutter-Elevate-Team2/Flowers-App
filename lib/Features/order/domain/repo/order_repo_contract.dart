import 'package:flowers_app/Features/order/data/models/cart/cart_request_dto.dart';
import 'package:flowers_app/Features/order/data/models/cart/quantity_request.dart';
import 'package:flowers_app/Features/order/data/models/checkout/order_request_dto.dart';
import 'package:flowers_app/Features/order/domain/entities/cart/cart_response_entity.dart';
import 'package:flowers_app/Features/order/domain/entities/checkout/cash_checkout_response_entity.dart';
import 'package:flowers_app/Features/order/domain/entities/checkout/credit_checkout_response_entity.dart';
import 'package:flowers_app/Features/order/domain/entities/checkout/user_orders_response_entity.dart';
import 'package:flowers_app/core/base_response/base_response.dart';

abstract class OrderRepoContract {
  Future<BaseResponse<CartResponseEntity>> addToCart(CartRequest cartRequest);
  Future<BaseResponse<CartResponseEntity>> deleteFromCart(String id);
  Future<BaseResponse<CartResponseEntity>> getCartData();
  Future<BaseResponse<CartResponseEntity>> updateCartItem(
    String id,
    QuantityRequest quantityRequest,
  );
  Future<BaseResponse<CashCheckoutResponseEntity>> cashOrderCheckout(
    OrderRequest orderRequest,
  );
  Future<BaseResponse<CreditCheckoutResponseEntity>> creditOrderCheckout(
      OrderRequest orderRequest,
      );
  Future<BaseResponse<UserOrdersResponseEntity>> getUserOrders();

}
