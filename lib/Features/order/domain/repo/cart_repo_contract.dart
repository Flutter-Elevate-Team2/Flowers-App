import 'package:flowers_app/Features/order/data/models/cart_request_dto.dart';
import 'package:flowers_app/Features/order/data/models/quantity_request.dart';
import 'package:flowers_app/Features/order/domain/entities/cart_response_entity.dart';
import 'package:flowers_app/core/base_response/base_response.dart';

abstract class CartRepoContract {
  Future<BaseResponse<CartResponseEntity>> addToCart(CartRequest cartRequest);
  Future<BaseResponse<CartResponseEntity>> deleteFromCart(String id);
  Future<BaseResponse<CartResponseEntity>> getCartData();
  Future<BaseResponse<CartResponseEntity>> updateCartItem(
    String id,
    QuantityRequest quantityRequest,
  );
}
