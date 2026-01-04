import 'package:flowers_app/Features/order/data/models/cart_request_dto.dart';
import 'package:flowers_app/Features/order/domain/entities/cart_responce_entity.dart';
import 'package:flowers_app/core/base_response/base_response.dart';

abstract class CartRepoContract {
  Future<BaseResponse<CartResponceEntity>>addToCart(CartRequest cartRequest);
  Future<BaseResponse<CartResponceEntity>>deleteFromCart(String id);
  Future<BaseResponse<CartResponceEntity>>getCartData();
  Future<BaseResponse<CartResponceEntity>>updateCartItem(String id,int quantity);
}