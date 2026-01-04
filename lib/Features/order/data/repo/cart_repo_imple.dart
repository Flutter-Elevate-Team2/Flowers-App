 import 'package:flowers_app/Features/order/data/data_source/cart_remote_data_source/cart_remote_data_source_contract.dart';
import 'package:flowers_app/Features/order/data/mappers/cart_responce_mapper.dart';
import 'package:flowers_app/Features/order/data/models/cart_request_dto.dart';
import 'package:flowers_app/Features/order/data/models/cart_responce_model.dart';
import 'package:flowers_app/Features/order/domain/entities/cart_responce_entity.dart';
import 'package:flowers_app/Features/order/domain/repo/cart_repo_contract.dart';
import 'package:flowers_app/core/base_response/base_response.dart';
import 'package:injectable/injectable.dart';
import '../../../../core/helpers/api_execution_mixin.dart';

@Injectable(as:CartRepoContract )
class CartRepoImple with ApiExecutionMixin implements CartRepoContract {
  final CartRemoteDataSourceContract _cartRemoteDataSourceContract;
  CartRepoImple(this._cartRemoteDataSourceContract);
  @override
  Future<BaseResponse<CartResponceEntity>> addToCart(CartRequest cartRequest) async{
    return execute<CartResponceModel,CartResponceEntity>(
      action: ()async=>await _cartRemoteDataSourceContract.addToCart(cartRequest),
      mapper: (responce)=>responce.toEntity(),
    );



  }

  @override
  Future<BaseResponse<CartResponceEntity>> deleteFromCart(String id) {
    return execute<CartResponceModel,CartResponceEntity>(
      action: ()async=>await _cartRemoteDataSourceContract.deleteItemFromCart(id),
      mapper: (responce)=>responce.toEntity(),
    );

  }

  @override
  Future<BaseResponse<CartResponceEntity>> getCartData() {
    return execute<CartResponceModel,CartResponceEntity>(
      action: ()async=>await _cartRemoteDataSourceContract.getCartData(),
      mapper: (responce)=>responce.toEntity(),
    );
  }

  @override
  Future<BaseResponse<CartResponceEntity>> updateCartItem(String id, int quantity) {
    return execute<CartResponceModel,CartResponceEntity>(
      action: ()async=>await _cartRemoteDataSourceContract.updateCartItem(id, quantity),
      mapper: (responce)=>responce.toEntity(),
    );
  }
 }