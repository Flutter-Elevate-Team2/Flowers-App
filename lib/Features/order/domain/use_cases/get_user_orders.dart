import 'package:flowers_app/Features/order/domain/entities/checkout/user_orders_entity.dart';
import 'package:flowers_app/Features/order/domain/entities/checkout/user_orders_response_entity.dart';
import 'package:flowers_app/Features/order/domain/repo/order_repo_contract.dart';
import 'package:flowers_app/core/base_response/base_response.dart';
import 'package:flowers_app/core/constants/api_constants.dart';
import 'package:injectable/injectable.dart';

@injectable
class GetUserOrders {
  final OrderRepoContract _orderRepoContract;
  GetUserOrders(this._orderRepoContract);

  Future<BaseResponse<List<OrdersEntity>>> call({
    required OrderFilter filter,
  }) async {
    final response = await _orderRepoContract.getUserOrders();

    if (response is SuccessResponse<UserOrdersResponseEntity>) {
      final orders = response.data.orders ?? [];

      final filteredOrders = _applyFilter(orders, filter);

      return SuccessResponse(data: filteredOrders);
    } else if (response is ErrorResponse<UserOrdersResponseEntity>) {
      return ErrorResponse(errorMessage: response.errorMessage);
    }

    return ErrorResponse(errorMessage: "Unknown error");
  }

  List<OrdersEntity> _applyFilter(
    List<OrdersEntity> orders,
    OrderFilter filter,
  ) {
    switch (filter) {
      case OrderFilter.completed:
        return orders.where((o) => o.state == ApiConstants.completed).toList();

      case OrderFilter.pending:
        return orders
            .where((o) => o.state == ApiConstants.pending || o.isPaid == false)
            .toList();
    }
  }
}
enum OrderFilter {
  pending,
  completed,
}