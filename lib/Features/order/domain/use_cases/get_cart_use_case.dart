import 'package:flowers_app/Features/order/domain/entities/cart_responce_entity.dart';
import 'package:flowers_app/Features/order/domain/repo/cart_repo_contract.dart';
import 'package:flowers_app/core/base_response/base_response.dart';
import 'package:injectable/injectable.dart';

@injectable
class GetCartUseCase {
  final CartRepoContract _cartRepoContract;
  GetCartUseCase(this._cartRepoContract);
  Future<BaseResponse<CartResponceEntity>>call()async{
    return await _cartRepoContract.getCartData();
  }
}