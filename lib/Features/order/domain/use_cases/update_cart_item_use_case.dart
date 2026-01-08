import 'package:flowers_app/Features/order/data/models/quantity_request.dart';
import 'package:flowers_app/Features/order/domain/entities/cart_response_entity.dart';
import 'package:flowers_app/Features/order/domain/repo/cart_repo_contract.dart';
import 'package:flowers_app/core/base_response/base_response.dart';
import 'package:injectable/injectable.dart';

@injectable
class UpdateCartItemUseCase {
  final CartRepoContract _cartRepoContract;
  UpdateCartItemUseCase(this._cartRepoContract);
  Future<BaseResponse<CartResponseEntity>> call(
    String id,
    QuantityRequest quantityRequest,
  ) async {
    return await _cartRepoContract.updateCartItem(id, quantityRequest);
  }
}
