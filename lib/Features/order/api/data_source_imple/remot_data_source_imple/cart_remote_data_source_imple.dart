import 'package:flowers_app/Features/order/api/api_client/cart_api.dart';
import 'package:flowers_app/Features/order/data/data_source/cart_remote_data_source/cart_remote_data_source_contract.dart';
import 'package:flowers_app/Features/order/data/models/cart_request_dto.dart';
import 'package:flowers_app/Features/order/data/models/cart_response_model.dart';
import 'package:injectable/injectable.dart';
@Injectable(as:CartRemoteDataSourceContract)
class CartRemoteDataSourceImple implements CartRemoteDataSourceContract {
 final CartApi _cartApi;
  CartRemoteDataSourceImple(this._cartApi);
  @override
  Future<CartResponseModel> addToCart(CartRequest cartRequest) {
    return  _cartApi.addProductToCart(cartRequest);

  }

  @override
  Future<CartResponseModel> deleteItemFromCart(String id) {
   return   _cartApi.deleteProductFromCart(id);
  }

  @override
  Future<CartResponseModel> getCartData() {
    return  _cartApi.getProductsCart();

  }

  @override
  Future<CartResponseModel> updateCartItem(String id, int quantity) {
    return  _cartApi.updateCartProduct(id, quantity);

  }
 }