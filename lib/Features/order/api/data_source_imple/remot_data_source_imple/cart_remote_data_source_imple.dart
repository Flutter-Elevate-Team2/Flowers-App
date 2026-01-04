import 'package:flowers_app/Features/order/api/api_client/cart_api.dart';
import 'package:flowers_app/Features/order/data/data_source/cart_remote_data_source/cart_remote_data_source_contract.dart';
import 'package:flowers_app/Features/order/data/models/cart_request_dto.dart';
import 'package:flowers_app/Features/order/data/models/cart_responce_model.dart';
import 'package:injectable/injectable.dart';
@Injectable(as:CartRemoteDataSourceContract)
class CartRemoteDataSourceImple implements CartRemoteDataSourceContract {
 final CartApi _cartApi;
  CartRemoteDataSourceImple(this._cartApi);
  @override
  Future<CartResponceModel> addToCart(CartRequest cartRequest) async{
    return await _cartApi.addProductToCart(cartRequest);

  }

  @override
  Future<CartResponceModel> deleteItemFromCart(String id) async{
   return  await _cartApi.deleteProductFromCart(id);
  }

  @override
  Future<CartResponceModel> getCartData() async{
    return await _cartApi.getProductsCart();

  }

  @override
  Future<CartResponceModel> updateCartItem(String id, int quantity) async{
    return await _cartApi.updateCartProduct(id, quantity);

  }
 }