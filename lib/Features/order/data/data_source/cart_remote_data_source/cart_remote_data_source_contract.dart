import 'package:flowers_app/Features/order/data/models/cart_request_dto.dart';
import 'package:flowers_app/Features/order/data/models/cart_response_model.dart';
import 'package:flowers_app/Features/order/data/models/quantity_request.dart';

abstract class CartRemoteDataSourceContract {
  Future<CartResponseModel>addToCart(CartRequest cartRequest);
  Future<CartResponseModel>getCartData();
  Future<CartResponseModel>deleteItemFromCart(String id);
  Future<CartResponseModel>updateCartItem(String id,QuantityRequest quantityRequest);
}