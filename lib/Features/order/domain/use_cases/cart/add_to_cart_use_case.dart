import 'package:flowers_app/Features/order/data/models/cart/cart_request_dto.dart';
import 'package:flowers_app/Features/order/domain/entities/cart/cart_response_entity.dart';
import 'package:flowers_app/Features/order/domain/repo/order_repo_contract.dart';
import 'package:flowers_app/core/base_response/base_response.dart';
import 'package:injectable/injectable.dart';

@injectable
class AddToCartUseCase {
  final OrderRepoContract _orderRepoContract;
  AddToCartUseCase(this._orderRepoContract);
  Future<BaseResponse<CartResponseEntity>> call(CartRequest request) async {
    return await _orderRepoContract.addToCart(request);
  }
}