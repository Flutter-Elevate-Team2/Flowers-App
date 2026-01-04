import 'package:flowers_app/Features/order/data/models/cart_request_dto.dart';
import 'package:flowers_app/Features/order/domain/entities/cart_responce_entity.dart';
import 'package:flowers_app/Features/order/domain/repo/cart_repo_contract.dart';
import 'package:flowers_app/core/base_response/base_response.dart';
import 'package:injectable/injectable.dart';

@injectable
class AddToCartUseCase {
  final CartRepoContract _cartRepoContract;
  AddToCartUseCase(this._cartRepoContract);
  Future<BaseResponse<CartResponceEntity>>call(CartRequest request)async{
    return await _cartRepoContract.addToCart(request);
  }
}