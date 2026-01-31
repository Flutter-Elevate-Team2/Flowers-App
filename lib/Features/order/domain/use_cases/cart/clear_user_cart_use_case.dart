import 'package:flowers_app/Features/order/domain/entities/cart/cart_response_entity.dart';
import 'package:flowers_app/Features/order/domain/repo/order_repo_contract.dart';
import 'package:flowers_app/core/base_response/base_response.dart';
import 'package:injectable/injectable.dart';

@injectable
class ClearCartUseCase {
  final OrderRepoContract _orderRepoContract;
  ClearCartUseCase(this._orderRepoContract);
  Future<BaseResponse<CartResponseEntity>> call() async {
    return await _orderRepoContract.clearUserCart();
  }
}
