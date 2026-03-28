import 'package:flowers_app/Features/order/domain/entities/checkout/user_orders_entity.dart';
import 'package:flowers_app/Features/order/domain/entities/checkout/user_orders_response_entity.dart';
import 'package:flowers_app/Features/order/domain/repo/order_repo_contract.dart';
import 'package:flowers_app/core/base_response/base_response.dart';
import 'package:injectable/injectable.dart';

@injectable
class GetUserOrders {
  final OrderRepoContract _orderRepoContract;
  GetUserOrders(this._orderRepoContract);

  Future<BaseResponse<List<OrdersEntity>>> call() async {
    final response = await _orderRepoContract.getUserOrders();

    if (response is SuccessResponse<UserOrdersResponseEntity>) {
      final orders = response.data.orders ?? [];
      return SuccessResponse(data: orders);
    } else if (response is ErrorResponse<UserOrdersResponseEntity>) {
      return ErrorResponse(errorMessage: response.errorMessage);
    }

    return ErrorResponse(errorMessage: "Unknown error");
  }
}

enum OrderFilter { pending, completed }
