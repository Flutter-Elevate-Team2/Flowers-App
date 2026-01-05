import 'package:flowers_app/Features/order/data/data_source/cart_remote_data_source/cart_remote_data_source_contract.dart';
import 'package:flowers_app/Features/order/data/mappers/cart_response_mapper.dart';
import 'package:flowers_app/Features/order/data/models/cart_request_dto.dart';
import 'package:flowers_app/Features/order/data/models/cart_response_model.dart';
import 'package:flowers_app/Features/order/domain/entities/cart_response_entity.dart';
import 'package:flowers_app/Features/order/domain/repo/cart_repo_contract.dart';
import 'package:flowers_app/core/base_response/base_response.dart';
import 'package:injectable/injectable.dart';
import '../../../../core/helpers/api_execution_mixin.dart';

@Injectable(as: CartRepoContract)
class CartRepoImple with ApiExecutionMixin implements CartRepoContract {
  final CartRemoteDataSourceContract _cartRemoteDataSourceContract;
  CartRepoImple(this._cartRemoteDataSourceContract);

  @override
  Future<BaseResponse<CartResponseEntity>> addToCart(
    CartRequest cartRequest,
  ) async {
    return execute<CartResponseModel, CartResponseEntity>(
      action: () => _cartRemoteDataSourceContract.addToCart(cartRequest),
      mapper: (response) => response.toEntity(),
    );
  }

  @override
  Future<BaseResponse<CartResponseEntity>> deleteFromCart(String id) {
    return execute<CartResponseModel, CartResponseEntity>(
      action: () => _cartRemoteDataSourceContract.deleteItemFromCart(id),
      mapper: (response) => response.toEntity(),
    );
  }

  @override
  Future<BaseResponse<CartResponseEntity>> getCartData() {
    return execute<CartResponseModel, CartResponseEntity>(
      action: () => _cartRemoteDataSourceContract.getCartData(),
      mapper: (response) => response.toEntity(),
    );
  }

  @override
  Future<BaseResponse<CartResponseEntity>> updateCartItem(
    String id,
    int quantity,
  ) {
    return execute<CartResponseModel, CartResponseEntity>(
      action: () => _cartRemoteDataSourceContract.updateCartItem(id, quantity),
      mapper: (response) => response.toEntity(),
    );
  }
}
