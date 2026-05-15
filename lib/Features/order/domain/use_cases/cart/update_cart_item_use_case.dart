import 'package:flowers_app/Features/order/data/models/cart/quantity_request.dart';
import 'package:flowers_app/Features/order/domain/entities/cart/cart_response_entity.dart';
import 'package:flowers_app/Features/order/domain/repo/order_repo_contract.dart';
import 'package:flowers_app/core/base_response/base_response.dart';
import 'package:injectable/injectable.dart';

@injectable
class UpdateCartItemUseCase {
  final OrderRepoContract _orderRepoContract;
  UpdateCartItemUseCase(this._orderRepoContract);
  Future<BaseResponse<CartResponseEntity>> call(
    String id,
    QuantityRequest quantityRequest,
  ) async {
    return await _orderRepoContract.updateCartItem(id, quantityRequest);
  }
}
