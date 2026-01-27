import 'package:flowers_app/Features/order/domain/entities/checkout/user_orders_response_entity.dart';
import 'package:flowers_app/Features/order/domain/repo/order_repo_contract.dart';
import 'package:flowers_app/core/base_response/base_response.dart';
import 'package:injectable/injectable.dart';

@injectable
class GetUserOrders {
  final OrderRepoContract _orderRepoContract;
  GetUserOrders(this._orderRepoContract);
  Future<BaseResponse<UserOrdersResponseEntity>> call() async {
    return await _orderRepoContract.getUserOrders();
  }
}