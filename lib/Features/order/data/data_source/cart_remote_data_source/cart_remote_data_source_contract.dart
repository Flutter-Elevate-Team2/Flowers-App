import 'package:flowers_app/Features/order/data/models/cart_request_dto.dart';
import 'package:flowers_app/Features/order/data/models/cart_responce_model.dart';

abstract class CartRemoteDataSourceContract {
  Future<CartResponceModel>addToCart(CartRequest cartRequest);
  Future<CartResponceModel>getCartData();
  Future<CartResponceModel>deleteItemFromCart(String id);
  Future<CartResponceModel>updateCartItem(String id,int quantity);
}