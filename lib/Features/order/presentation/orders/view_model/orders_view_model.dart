import 'package:flowers_app/Features/order/domain/entities/checkout/user_orders_entity.dart';
import 'package:flowers_app/Features/order/domain/entities/checkout/user_orders_response_entity.dart';
import 'package:flowers_app/Features/order/presentation/orders/view_model/orders_event.dart';
import 'package:flowers_app/Features/order/presentation/orders/view_model/orders_states.dart';
import 'package:flowers_app/core/constants/api_constants.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:flowers_app/core/base_response/base_response.dart';
import 'package:flowers_app/Features/order/domain/use_cases/get_user_orders.dart';

@Injectable()
class OrdersViewModel extends Cubit<OrdersState> {
  final GetUserOrders getUserOrders;

  OrdersViewModel(this.getUserOrders) : super(const OrdersState());

  void doIntent(OrdersEvent event) {
    if (event is GetUserOrdersEvent) {
      _getOrders();
    } else if (event is ChangeOrdersFilterEvent) {
      _filterOrders(event.filter);
    }
  }

  Future<void> _getOrders() async {
    emit(state.copyWith(isLoading: true, errorMessage: null));

    final response = await getUserOrders.call();

    if (response is SuccessResponse<UserOrdersResponseEntity>) {
      final orders = response.data.orders ?? [];
      emit(
        state.copyWith(
          isLoading: false,
          allOrders: orders,
          filteredOrders: _applyFilter(orders, state.selectedFilter),
        ),
      );
    } else if (response is ErrorResponse<UserOrdersResponseEntity>) {
      emit(
        state.copyWith(isLoading: false, errorMessage: response.errorMessage),
      );
    }
  }

  void _filterOrders(OrderFilter filter) async {
    emit(state.copyWith(isFiltering: true));

    await Future.delayed(const Duration(milliseconds: 400));

    emit(
      state.copyWith(
        selectedFilter: filter,
        filteredOrders: _applyFilter(state.allOrders, filter),
        isFiltering: false,
      ),
    );
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
