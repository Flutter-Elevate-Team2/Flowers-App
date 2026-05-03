import 'package:flowers_app/Features/order/domain/entities/checkout/user_orders_entity.dart';
import 'package:flowers_app/Features/order/domain/use_cases/get_user_orders.dart';
import 'package:flowers_app/Features/order/presentation/orders/view_model/orders_event.dart';
import 'package:flowers_app/Features/order/presentation/orders/view_model/orders_states.dart';
import 'package:flowers_app/core/constants/api_constants.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:flowers_app/core/base_response/base_response.dart';

@Injectable()
class OrdersViewModel extends Cubit<OrdersState> {
  final GetUserOrders getUserOrders;

  OrdersViewModel(this.getUserOrders) : super(const OrdersState());

  void doIntent(OrdersEvent event) {
    if (event is GetUserOrdersEvent) {
      _getOrders();
    } else if (event is ChangeOrdersFilterEvent) {
      emit(state.copyWith(selectedFilter: event.filter));
    }
  }

  Future<void> _getOrders() async {
    emit(state.copyWith(isLoading: true, errorMessage: null));

    final response = await getUserOrders.call();

    if (response is SuccessResponse<List<OrdersEntity>>) {
      final allOrders = response.data;

      final active = allOrders
          .where(
            (o) =>
                o.state == ApiConstants.pending ||
                o.state == ApiConstants.inProgress ||
                o.isPaid == false,
          )
          .toList();

      final completed = allOrders
          .where((o) => o.state == ApiConstants.completed)
          .toList();

      emit(
        state.copyWith(
          isLoading: false,
          allOrders: allOrders,
          activeOrders: active,
          completedOrders: completed,
        ),
      );
    } else if (response is ErrorResponse<List<OrdersEntity>>) {
      emit(
        state.copyWith(isLoading: false, errorMessage: response.errorMessage),
      );
    }
  }
}
