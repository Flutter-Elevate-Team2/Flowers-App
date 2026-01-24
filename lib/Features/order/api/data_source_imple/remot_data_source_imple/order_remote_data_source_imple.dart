import 'package:flowers_app/Features/order/api/api_client/order_api.dart';
import 'package:flowers_app/Features/order/data/data_source/order_remote_data_source/order_remote_data_source_contract.dart';
import 'package:flowers_app/Features/order/data/models/cart/cart_request_dto.dart';
import 'package:flowers_app/Features/order/data/models/cart/cart_response_model.dart';
import 'package:flowers_app/Features/order/data/models/cart/quantity_request.dart';
import 'package:injectable/injectable.dart';

@LazySingleton(as: OrderRemoteDataSourceContract)
class OrderRemoteDataSourceImple implements OrderRemoteDataSourceContract {
  final OrderApi _orderApi;
  OrderRemoteDataSourceImple(this._orderApi);
  @override
  Future<CartResponseModel> addToCart(CartRequest cartRequest) {
    return _orderApi.addProductToCart(cartRequest);
  }

  @override
  Future<CartResponseModel> deleteItemFromCart(String id) {
    return _orderApi.deleteProductFromCart(id);
  }

  @override
  Future<CartResponseModel> getCartData() {
    return _orderApi.getProductsCart();
  }

  @override
  Future<CartResponseModel> updateCartItem(
    String id,
    QuantityRequest quantityRequest,
  ) {
    return _orderApi.updateCartProduct(id, quantityRequest);
  }
}
