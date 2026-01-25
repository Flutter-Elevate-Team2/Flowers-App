import 'package:flowers_app/Features/order/data/models/cart/cart_request_dto.dart';
import 'package:flowers_app/Features/order/data/models/cart/cart_response_model.dart';
import 'package:flowers_app/Features/order/data/models/cart/quantity_request.dart';
import 'package:flowers_app/Features/order/data/models/checkout/cash_checkout_response_model.dart';
import 'package:flowers_app/Features/order/data/models/checkout/credit/credit_checkout_response_model.dart';
import 'package:flowers_app/Features/order/data/models/checkout/order_request_dto.dart';

abstract class OrderRemoteDataSourceContract {
  Future<CartResponseModel>addToCart(CartRequest cartRequest);
  Future<CartResponseModel>getCartData();
  Future<CartResponseModel>deleteItemFromCart(String id);
  Future<CartResponseModel>updateCartItem(String id,QuantityRequest quantityRequest);
  Future<CashCheckoutResponseModel>cashOrderCheckout(OrderRequest orderRequest);
  Future<CreditCheckoutResponseModel>creditOrderCheckout(OrderRequest orderRequest);
}